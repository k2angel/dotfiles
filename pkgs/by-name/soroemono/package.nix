{
  lib,
  stdenvNoCC,
  fetchzip,
  installFonts,
}:

stdenvNoCC.mkDerivation rec {
  pname = "soroemono";
  version = "2.0.0";

  src = fetchzip {
    url = "https://github.com/qrac/soroemono/releases/download/${version}/SOROEMONO_v${version}.zip";
    hash = "sha256-tfhAlD7A3jRZUQHN0FWg1NBrSf/HQMy1NP+oPy350iA=";
    stripRoot = false;
  };

  nativeBuildInputs = [ installFonts ];

  meta = {
    description = "Programming font that combines BIZ UD Gothic and JetBrains Mono in 1:2 ratio";
    homepage = "https://github.com/qrac/soroemono";
    license = lib.licenses.ofl;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.all;
  };
}
