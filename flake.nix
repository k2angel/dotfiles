{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    nixGL.url = "github:danisosa2001/nixGL/fix-nvidia-open-kernel-regex";
    nixpkgs-nixgl.url = "github:nixos/nixpkgs/93e8cdce7afc64297cfec447c311470788131cd9";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, ... }:
    let
      baseArgs = {
        inherit inputs self;
        username = "k2angel";
      };

      mkConfig = import (self + /lib/mkconfig.nix) inputs;
      mkNixosConfig = host: mkConfig.mkNixosConfig (baseArgs // { inherit host; });
      mkHomeConfig = host: mkConfig.mkHomeConfig (baseArgs // { inherit host; });
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
