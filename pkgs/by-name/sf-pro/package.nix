{
  stdenvNoCC,
  fetchurl,
  installFonts,
  p7zip,
}:

stdenvNoCC.mkDerivation {
  pname = "sf-pro";
  version = "22.2d2e1";

  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    hash = "sha256-sn/mYi8fqWpwfHPcpmZtQ5w1sxLVsdR+DimA5hjrSyg=";
  };

  nativeBuildInputs = [
    installFonts
    p7zip
  ];

  unpackPhase = ''
    7z e $src
    7z e -tcpio Payload\~ "./Library/Fonts/*"
  '';
}
