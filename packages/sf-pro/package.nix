{
  stdenv,
  fetchurl,
  p7zip,
}:

stdenv.mkDerivation {
  pname = "sf-pro";
  version = "7.0.6";
  nativeBuildInputs = [ p7zip ];

  src = fetchurl {
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
}
