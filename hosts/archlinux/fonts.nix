{ self, pkgs, ... }:

let
  sf-pro = pkgs.callPackage (self + /packages/sf-pro/package.nix) { };
  soroemono = pkgs.callPackage (self + /packages/soroemono/package.nix) { };
in
{
  home.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    sf-pro
    soroemono
    twitter-color-emoji
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
      monospace = [
        "JetBrains Mono"
        "SOROEMONO"
        "Noto Sans Mono CJK JP"
        "Symbols Nerd Font"
      ];
      emoji = [
        "Twitter Color Emoji"
        "Noto Color Emoji"
      ];
    };
  };
}
