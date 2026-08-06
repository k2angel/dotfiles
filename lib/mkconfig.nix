inputs: {
  mkNixosConfig =
    args@{
      host,
      system,
      username,
      ...
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = args;

      modules = [
        ../hosts/${host}
        ../modules/system

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = args;

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
    args@{ host, system, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = args;

      modules = [
        ../hosts/${host}
        ../modules/home-manager
      ];
    };
}
