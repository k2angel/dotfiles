{
  imports = [
    ../home
    ../features/nh-clean.nix
    ../features/pkgs.nix
    ../features/wmenu.nix

    ./mpv.nix
    ./nix.nix
    ./overrides.nix
    ./portal.nix
    ./services.nix
  ];
}
