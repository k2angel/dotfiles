{ lib, isNixOS, ... }:

{
  imports = [
    ./home.nix
    ./serviecs.nix
    ./sway.nix
    ./virtualization.nix
  ]
  ++ lib.optionals (!isNixOS) [
    ./fonts.nix
  ];
}
