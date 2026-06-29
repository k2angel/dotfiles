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

  sf-pro = pkgs.stdenv.mkDerivation {
    pname = "sf-pro";
    version = "7.0.6";
    nativeBuildInputs = [ pkgs.p7zip ];

    src = pkgs.fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
      hash = "sha256-YxGk8IQ6TS5hagsFx3US0x0uqVBFnPUmzbW5CZageU8=";
    };

    unpackPhase = ''
      7z e $src "SFProFonts/SF Pro Fonts.pkg"
      7z e "SF Pro Fonts.pkg"
      7z e Payload\~ "./Library/Fonts/*"
    '';

    installPhase = ''
      runHook preInstall
      install -Dm644 -t "$out/share/fonts/opentype/" *.otf
      install -Dm644 -t "$out/share/fonts/truetype/" *.ttf
      runHook postInstall
    '';
  };
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
    udev-gothic
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
