{ self, pkgs, ... }:

{
  imports = [
    (self + /modules/features/attic-watch-store.nix)
    ../archlinux/home.nix
    ../archlinux/serviecs.nix
    ../archlinux/sway.nix
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
