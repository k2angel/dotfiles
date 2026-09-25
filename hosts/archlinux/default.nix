{ lib, isNixOS, ... }:

{
  imports = [
    ./home.nix
    ./serviecs.nix
    ./sway.nix
    ./virtualization.nix
  ]
  ++ lib.optionals (!isNixOS) [
    ./atticd.nix
    ./fonts.nix
  ];
}
