{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        font = "JetBrains Mono:size=11.25, SOROEMONO:size=11.25, Symbols Nerd Font:size=11.25";
        pad = "4x2";
      };
      colors-dark = {
        background = "282c34";
        foreground = "abb2bf";
        alpha = "0.9";

        regular0 = "1e2127";
        regular1 = "e06c75";
        regular2 = "98c379";
        regular3 = "d19a66";
        regular4 = "61afef";
        regular5 = "c678dd";
        regular6 = "56b6c2";
        regular7 = "abb2bf";

        bright0 = "5c6370";
        bright1 = "e06c75";
        bright2 = "98c379";
        bright3 = "d19a66";
        bright4 = "61afef";
        bright5 = "c678dd";
        bright6 = "56b6c2";
        bright7 = "ffffff";
      };
    };
  };
}
