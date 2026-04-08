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

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    username = "k2angel";

    mkNixosConfig = host: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self username host; };
      system = "x86_64-linux";
      modules = [
        ./hosts/${host}

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs self username host; };

          home-manager.users.${username} = {
            imports = [ ./modules/home ./hosts/${host}/home.nix ];

            home = {
              username = "${username}";
              homeDirectory = "/home/${username}";
              stateVersion = "25.11";
            };
          };
        }
      ];
    };
  in {
    nixosConfigurations = {
      nixos-vm = mkNixosConfig "nixos-vm";
      visterhv = mkNixosConfig "visterhv";
    };
  };
}
