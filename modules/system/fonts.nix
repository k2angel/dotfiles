{ pkgs, ... }:
let
  soroemono = pkgs.stdenv.mkDerivation rec {
    pname = "soroemono";
    version = "1.0.0";

    src = pkgs.fetchzip {
      url = "https://github.com/qrac/soroemono/releases/download/${version}/SOROEMONO_v${version}.zip";
      hash = "sha256-70PzvCDoT8pP/jY0PvYXLChuXKdhuAmw0+nDRxpWQ5Y=";
      stripRoot = false;
    };

    installPhase = ''
      runHook preInstall
      install -Dm644 -t "$out/share/fonts/truetype/" *.ttf
      runHook postInstall
    '';
  };
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
