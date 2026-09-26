{ self, pkgs, ... }:

{
  imports = [ (self + /modules/features/attic-watch-store.nix) ];

  home.packages = with pkgs; [
    attic-client
  ];
}
