{ config, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        font = "JetBrains Mono:size=11.25, SOROEMONO:size=11.25, Symbols Nerd Font:size=11.25";
        pad = "4x2";
      };

      "colors-${config.colorScheme.variant}" = with config.colorScheme.palette; {
        alpha = "0.9";
        foreground = base05;
        background = base00;
        regular0 = base00;
        regular1 = base08;
        regular2 = base0B;
        regular3 = base0A;
        regular4 = base0D;
        regular5 = base0E;
        regular6 = base0C;
        regular7 = base05;
        bright0 = base03;
        bright1 = base08;
        bright2 = base0B;
        bright3 = base0A;
        bright4 = base0D;
        bright5 = base0E;
        bright6 = base0C;
        bright7 = base07;
        "16" = base09;
        "17" = base0F;
        "18" = base01;
        "19" = base02;
        "20" = base04;
        "21" = base06;
        selection-background = base05;
        selection-foreground = base00;
        urls = base04;
        jump-labels = "${base00} ${base0A}";
        scrollback-indicator = "${base00} ${base04}";
      };
    };
  };
}
