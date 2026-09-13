{ inputs, pkgs }:

{
  mkNixosConfig =
    args@{
      host,
      username,
      ...
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs;
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
    args@{ host, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;

      modules = [
        ../hosts/${host}
        ../modules/home-manager
      ];
    };
}
