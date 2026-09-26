{ self, ... }:

{
  imports = [
    ../archlinux
    (self + /modules/features/attic-watch-store.nix)
  ];
}
