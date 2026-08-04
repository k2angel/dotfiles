{ self, pkgs, ... }:

let
  soroemono = pkgs.callPackage (self + /packages/soroemono/package.nix) { };
in
{
  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    soroemono
    twitter-color-emoji
    udev-gothic
  ];
  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Noto Sans CJK JP" ];
    serif = [ "Noto Serif CJK JP" ];
    monospace = [
      "JetBrains Mono"
      "SOROEMONO"
      "Symbols Nerd Font"
    ];
    emoji = [
      "Twitter Color Emoji"
      "Noto Color Emoji"
    ];
  };
}
