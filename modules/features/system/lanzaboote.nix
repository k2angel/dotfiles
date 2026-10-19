{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.lanzaboote;
in
{
  options = {
    features.lanzaboote = {
      enable = lib.mkEnableOption "Enable lanzaboote";
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader.systemd-boot.enable = false;

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
        autoGenerateKeys.enable = true;

        autoEnrollKeys = {
          enable = true;
          autoReboot = true;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
}
