{ pkgs, ... }:

let
  soroemono = pkgs.stdenv.mkDerivation rec {
    pname = "soroemono";
    version = "1.0.0";

    src = pkgs.fetchurl {
      url = "https://github.com/qrac/soroemono/releases/download/1.0.0/SOROEMONO_v1.0.0.zip";
      hash = "sha256-oEu/Dqop0MJrLc79tY3rZL8B5yluLUB/s/buYqQ6aTA=";
    };

    nativeBuildInputs = [ pkgs.unzip ];

    unpackPhase = "unzip $src";

    installPhase = ''
      runHook preInstall
      font_dir=$out/share/fonts/truetype/soroemono
      mkdir -p $font_dir
      cp *.ttf $font_dir/
      runHook postInstall
    '';
  };
in

{
  fonts.packages = [ soroemono ];
}
