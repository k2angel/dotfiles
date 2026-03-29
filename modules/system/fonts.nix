{ pkgs, ... }:

let
  soroemono = pkgs.stdenv.mkDerivation rec {
    pname = "soroemono";
    version = "1.0.0";
    nativeBuildInputs = [ pkgs.unzip ];
    sourceRoot = ".";

    src = pkgs.fetchurl {
      url = "https://github.com/qrac/soroemono/releases/download/${version}/SOROEMONO_v${version}.zip";
      hash = "sha256-oEu/Dqop0MJrLc79tY3rZL8B5yluLUB/s/buYqQ6aTA=";
    };

    installPhase = ''
      runHook preInstall
      install -Dm644 *.ttf -t $out/share/fonts/truetype/soroemono
      runHook postInstall
    '';
  };
in
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    font-awesome
    jetbrains-mono
    # udev-gothic
    soroemono
    nerd-fonts.symbols-only
  ];
  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Noto Sans CJK JP" ];
    serif = [ "Noto Serif CJK JP" ];
    monospace = [ "JetBrains Mono" "SOROEMONO" "Symbols Nerd Font" ];
    emoji = [ "Noto Color Emoji" ];
  };
}
