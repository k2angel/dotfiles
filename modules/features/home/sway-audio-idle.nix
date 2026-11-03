{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.sway-audio-idle;
in
{
  options = {
    services.sway-audio-idle = {
      enable = lib.mkEnableOption "Prevent swayidle/hypridle from sleeping";

      package = lib.mkPackageOption pkgs "sway-audio-idle-inhibit" { };

      extraArgs = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
        example = [
          "--dry-print-both"
          "--dry-print-both-waybar"
        ];
        description = "Extra arguments to pass to sway-audio-idle";
      };

      systemdTarget = lib.mkOption {
        type = lib.types.str;
        default = config.wayland.systemd.target;
        description = "Systemd target to bind to.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.sway-audio-idle = {
      Unit = {
        Description = "Prevent swayidle/hypridle from sleeping";
        PartOf = [ cfg.systemdTarget ];
        After = [ cfg.systemdTarget ];
      };

      Service = {
        Type = "simple";
        Restart = "always";
        ExecStart = "${lib.getExe cfg.package} ${lib.escapeShellArgs cfg.extraArgs}";
      };

      Install = {
        WantedBy = [ cfg.systemdTarget ];
      };
    };
  };
}
