{
  lib,
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
  pkg-config,
  sqlite,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "seeker";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "k2angel";
    repo = "seeker";
    tag = version;
    hash = "sha256-LECc8z6hV/6TtziP4y8gJJ5ac99J1Z8OkLHQKZP6JiI=";
  };

  cargoHash = "sha256-9BjEJgNF0OMz4eR7+gPPZNMNSNyybab8JyOQX5cRInA=";

  nativeBuildInputs = [
    installShellFiles
    pkg-config
  ];

  buildInputs = [
    sqlite
    openssl
  ];

  postInstall = ''
    installShellCompletion --cmd seeker \
      --bash <($out/bin/seeker completion bash) \
      --zsh <($out/bin/seeker completion zsh) \
      --fish <($out/bin/seeker completion fish)
  '';

  checkFlags = [
    "--skip=database_insert_test"
    "--skip=build_song_test"
    "--skip=import_chart_test"
    "--skip=import_directory_test"
    "--skip=parse_chart_test"
    "--skip=parse_header_test"
  ];

  meta = {
    description = "CLI BMS library manager";
    homepage = "https://github.com/k2angel/seeker";
    license = with lib.licenses; [
      apsl20
      mit
    ];
    mainProgram = "seeker";
    platforms = lib.platforms.linux;
  };
}
