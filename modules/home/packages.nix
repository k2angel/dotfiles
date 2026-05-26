{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-tools
    duf
    dust
    fastfetch
    fd
    jq
    ouch
    ripgrep
    trash-cli
    tree
    xh
  ];
}
