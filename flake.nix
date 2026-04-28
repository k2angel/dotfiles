{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      username = "k2angel";
      system = "x86_64-linux";

      mkNixosConfig =
        host:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit
              inputs
              self
              username
              host
              ;
          };
          modules = [
            ./hosts/${host}
            ./modules/system

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  inputs
                  self
                  username
                  host
                  ;
              };

              home-manager.users.${username} = {
                imports = [
                  ./hosts/${host}/home.nix
                  ./modules/home
                ];
              };
            }
          ];
        };

      mkHomeConfig =
        host:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};

          extraSpecialArgs = {
            inherit
              inputs
              username
              host
              ;
          };

          modules = [
            ./hosts/${host}
            ./modules/home-manager
          ];
        };
    in
    {
      nixosConfigurations = {
        nixos-vm = mkNixosConfig "nixos-vm";
        visterhv = mkNixosConfig "visterhv";
      };

      homeConfigurations = {
        "k2angel@archlinux" = mkHomeConfig "archlinux";
      };
    };
}
