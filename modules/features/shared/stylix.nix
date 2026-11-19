{
  self,
  config,
  pkgs,
  ...
}:

{
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    polarity = config.lib.stylix.colors.variant;
    image = "${self + /image/large_ev50.png}";

    # cursor = {
    #   name = "Adwaita";
    #   package = pkgs.adwaita-icon-theme;
    #   size = 24;
    # };

    fonts = {
      serif = {
        package = pkgs.noto-fonts-cjk-serif;
        name = "serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "sans-serif";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "monospace";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "emoji";
      };

      sizes = {
        terminal = 11.25;
      };
    };

    opacity = {
      terminal = 0.9;
    };
  };
}
