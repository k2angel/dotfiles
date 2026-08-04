{ stdenv, fetchzip }:

stdenv.mkDerivation rec {
  pname = "soroemono";
  version = "1.0.0";

  src = fetchzip {
    url = "https://github.com/qrac/soroemono/releases/download/${version}/SOROEMONO_v${version}.zip";
    hash = "sha256-70PzvCDoT8pP/jY0PvYXLChuXKdhuAmw0+nDRxpWQ5Y=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall
    install -Dm644 -t "$out/share/fonts/truetype/" *.ttf
    runHook postInstall
  '';
}
