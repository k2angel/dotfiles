{ lib, isNixos, ... }:

{
  imports = [
    ./home.nix
    ./serviecs.nix
    ./sway.nix
  ]
  ++ lib.optionals (!isNixos) [
    ./atticd.nix
    ./fonts.nix
    ./virtualization.nix
  ];
}
