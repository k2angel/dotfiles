inputs: {
  mkNixosConfig =
    args@{
      host,
      username,
      ...
    }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = args;

      modules = [
        ../hosts/${host}
        ../modules/system

        inputs.disko.nixosModules.disko
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = args // {
              isNixOS = true;
            };

            users.${username} = {
              imports = [
                ../hosts/${host}/home.nix
                ../modules/home
              ];
            };
          };
        }
      ];
    };

  mkHomeConfig =
    args@{ host, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${builtins.currentSystem};
      extraSpecialArgs = args // {
        isNixOS = false;
      };

      modules = [
        ../hosts/${host}
        ../modules/home-manager
      ];
    };
}
