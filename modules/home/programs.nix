{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config.theme = "OneHalfDark";
  };

  home.packages = with pkgs; [
    duf
    ripgrep
    tealdeer
    fastfetch
    yazi
  ];
}
