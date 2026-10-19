{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.attic-watch-store;
in
{
  options = {
    features.attic-watch-store = {
      enable = lib.mkEnableOption "Enable attic watch-store service";

      cache = lib.mkOption {
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.attic-watch-store-k2angel-private = {
      Unit = {
        Description = "Attic Binary Cache Auto-Push Service for ${cfg.cache}";
        After = [
          "network-online.target"
          "nix-daemon.service"
        ];
      };

      Service = {
        Restart = "on-failure";
        RestartSec = "15s";

        ReadOnlyPaths = [
          "/nix/store"
          "%h/.config/attic"
        ];
        ExecStart = "${pkgs.attic-client}/bin/attic watch-store --ignore-upstream-cache-filter ${cfg.cache}";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
