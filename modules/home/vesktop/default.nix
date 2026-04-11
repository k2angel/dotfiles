{ config, ... }:

{
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

  #   xdg.configFile."vesktop/settings/settings.json".source =
  #     config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home/vesktop/settings.json";
  #   xdg.configFile."vesktop/settings/quickCss.css".source =
  #    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home/vesktop/quickCss.css";
}
