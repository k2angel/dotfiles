{ lib, isNixOS, ... }:

{
  imports = [
    ./home.nix
    ./serviecs.nix
    ./sway.nix
  ]
  ++ lib.optionals (!isNixOS) [
    ./atticd.nix
    ./fonts.nix
    ./virtualization.nix
  ];
}
