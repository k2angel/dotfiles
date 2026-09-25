{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation rec {
  pname = "kindlegen";
  version = "2.9";

  src = fetchurl {
    url = "https://archive.org/download/kindlegen${version}/kindlegen_linux_2.6_i386_v2_9.tar.gz";
    sha256 = "sha256-mCjbWiyJcNSHraLKqRo7ZAMhDV0YOn44SbGyBv8EIpY=";
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/doc/kindlegen
    mkdir -p $out/share/licenses/kindlegen

    install -m755 kindlegen $out/bin/

    install -m644 EULA.txt \
    $out/share/licenses/kindlegen/

    install -m644 "KindleGen Legal Notices 2013-02-19 Linux.txt" \
    $out/share/licenses/kindlegen/

    cp -r docs manual.html \
    $out/share/doc/kindlegen/
  '';

  meta = {
    description = "Amazon KindleGen binary";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}
