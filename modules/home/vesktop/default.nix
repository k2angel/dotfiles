{ lib, ... }:

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

  xdg.configFile."vesktop/settings/settings.json".source = lib.file.mkOutOfStoreSymlink "${./settings.json}";
  xdg.configFile."vesktop/settings/quickCss.css".source = lib.file.mkOutOfStoreSymlink "${./quickCss.css}";
}
