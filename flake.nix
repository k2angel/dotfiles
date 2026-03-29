{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
  in {
    nixosConfigurations.nixos-vm = let
      host = "nixos-vm";
    in nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self username host; };
      system = "x86_64-linux";
      modules = [ ./hosts/${host} ];
    };

    nixosConfigurations.visterhv = let
      host = "visterhv";
    in nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self username host; };
      system = "x86_64-linux";
      modules = [ ./hosts/${host} ];
    };
  };
}
