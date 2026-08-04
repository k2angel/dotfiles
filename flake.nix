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

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, ... }:
    let
      baseArgs = {
        inherit inputs self;
        username = "k2angel";
        system = "x86_64-linux";
      };

      mylib = import ./lib inputs;

      mkNixosConfig = host: mylib.mkNixosConfig (baseArgs // { inherit host; });
      mkHomeConfig = host: mylib.mkHomeConfig (baseArgs // { inherit host; });
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
