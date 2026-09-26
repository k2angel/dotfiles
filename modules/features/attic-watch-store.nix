{ pkgs, ... }:

{
  systemd.user.services.attic-watch-store-k2angel-private = {
    Unit = {
      Description = "Attic Binary Cache Auto-Push Service for k2angel:private";
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
      ExecStart = "${pkgs.attic-client}/bin/attic watch-store --ignore-upstream-cache-filter k2angel:private";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
