{ config, lib, ... }:

let
  cfg = config.features.vesktop;
in
{
  options = {
    features.vesktop = {
      enable = lib.mkEnableOption "Enable vesktop";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;

      settings = {
        discordBranch = "stable";
        minimizeToTray = false;
        arRPC = true;
        hardwareAcceleration = true;
        customTitleBar = false;
        splashColor = "rgb(220, 220, 223)";
        splashBackground = "rgb(0, 0, 0)";
        spellCheckLanguages = [ "ja" ];
        hardwareVideoAcceleration = true;
        tray = false;
        splashPixelated = false;
      };
    };
  };
}
