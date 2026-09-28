{
  stdenvNoCC,
  fetchurl,
  installFonts,
  p7zip,
}:

stdenvNoCC.mkDerivation {
  pname = "sf-pro";
  version = "22.0d5e4";
  nativeBuildInputs = [
    installFonts
    p7zip
  ];

  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    hash = "sha256-loqzuLH5LC2K9h6waA9cIiTE541ZuYa/AEUCp/wBKRg=";
  };

  unpackPhase = ''
    7z e $src
    7z e -tcpio Payload\~ "./Library/Fonts/*"
  '';
}
