{ lib, isNixos, ... }:

{
  imports = [
    ./home.nix
    ./serviecs.nix
    ./sway.nix
    ./virtualization.nix
  ]
  ++ lib.optionals (!isNixos) [
    ./atticd.nix
    ./fonts.nix
  ];
}
