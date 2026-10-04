{
  lib,
  stdenv,
  fetchFromGitHub,
  jdk8,
  portaudio,
}:

stdenv.mkDerivation rec {
  pname = "jportaudio";
  version = "19.7.0";

  src = fetchFromGitHub {
    owner = "PortAudio";
    repo = "portaudio";
    tag = "v${version}";
    hash = "sha256-P2gIMSID2rclezJ/L7Uyu7uCmCpFGeoWyz7PRVDPIdc=";
  };

  nativeBuildInputs = [
    jdk8
  ];

  buildInputs = [
    portaudio
  ];

  buildPhase = ''
    runHook preBuild

    $CC \
      -shared \
      -fPIC \
      -I${jdk8}/include \
      -I${jdk8}/include/linux \
      -I${portaudio}/include \
      bindings/java/c/src/*.c \
     -L${portaudio}/lib \
     -lportaudio \
     -o libjportaudio.so

     runHook postBuild;
  '';

  installPhase = ''
    install -Dm755 libjportaudio.so $out/lib/libjportaudio.so
  '';
}
