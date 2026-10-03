{ self, pkgs, ... }:

{
  imports = [
    ../archlinux
    (self + /modules/features/attic-watch-store.nix)
  ];

  home.packages = with pkgs; [
    sf-pro
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      sansSerif = [
        "SF Pro"
        "Hiragino Sans"
        "Noto Sans CJK JP"
      ];
      serif = [
        "Hiragino Mincho ProN"
        "Noto Serif CJK JP"
      ];
    };
  };
}
