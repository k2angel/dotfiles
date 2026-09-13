{
  stdenv,
  fetchurl,
  p7zip,
}:

stdenv.mkDerivation {
  pname = "sf-pro";
  version = "7.0.7";
  nativeBuildInputs = [ p7zip ];

  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    hash = "sha256-qQlPDem3idc1RO5Q/FKgiE1Kn3/PYt5Sl04yBPOnSmI=";
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
}
