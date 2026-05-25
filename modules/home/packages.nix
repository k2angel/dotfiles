{ pkgs, ... }:

{
  home.packages = with pkgs; [
    duf
    dust
    fastfetch
    fd
    jq
    ouch
    ripgrep
    tree
    xh
  ];
}
