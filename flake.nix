{
  description = "NixOS configuration";

  inputs = {
    base16.url = "github:SenchoPens/base16.nix";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    nixpkgs-openrazer.url = "github:nixos/nixpkgs/965f876a780c1fad7f14b9f817e093e40ea5d5e5";
    nixpkgs-mozc.url = "github:nixos/nixpkgs/5f239bb3ce14be4f7c8e91962348df827900a7fe";
    nixGL.url = "github:danisosa2001/nixGL/fix-nvidia-open-kernel-regex";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.2.0";
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
        yoga-310 = mkNixosConfig "yoga-310";
      };

      homeConfigurations = {
        "k2angel@archlinux" = mkHomeConfig "archlinux";
      };
    };
}
