{ pkgs, ... }:

{
  home.packages = with pkgs; [
    duf
    ripgrep
    tealdeer
    fastfetch
    yazi
  ];
}
