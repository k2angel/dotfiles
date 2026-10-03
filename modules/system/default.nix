{
  imports = [
    ../features/nh-clean.nix
    ../features/pkgs.nix
    ../features/wmenu.nix

    ./boot.nix
    ./fonts.nix
    ./networking.nix
    ./packages.nix
    ./portal.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./users.nix
  ];
}
