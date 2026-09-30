{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  python3,
}:

stdenvNoCC.mkDerivation rec {
  pname = "betterfox-nix";
  version = "154.0";

  src = fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    tag = version;
    hash = "sha256-mIP/WcXUcGrJsWCJzR4zqPOmt0BbbpTZVaN/MbIwBbw=";
  };

  nativeBuildInputs = [ python3 ];

  buildPhase = ''
    python3 ${./convert.py} --user-js "$src/user.js" > betterfox.nix
    python3 ${./convert.py} --policies "$src/policies.json" > policies.nix
  '';

  installPhase = ''
    mkdir -p "$out"
    cp *.nix "$out"
  '';

  meta = {
    description = "Firefox user.js for optimal privacy and security. Your favorite browser, but better.";
    homepage = "https://github.com/yokoffing/BetterFox";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
