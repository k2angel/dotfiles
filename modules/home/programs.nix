{
  config,
  pkgs,
  ...
}:

{
  programs = {
    aria2p.enable = true;

    aria2 = {
      enable = true;
      systemd.enable = true;

      settings = {
        dir = "${config.xdg.userDirs.download}/aria2";
      };
    };

    bat = {
      enable = true;
      config.theme = "OneHalfDark";
    };

    bemenu = {
      enable = true;
      package = null;

      settings = with config.colorScheme.palette; {
        tb = "#${base01}";
        tf = "#${base00}";
        ff = "#${base05}";
        cb = "#${base00}";
        nb = "#${base00}";
        nf = "#${base05}";
        hb = "#${base01}";
        hf = "#${base00}";
        ab = "#${base00}";
        af = "#${base05}";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "${config.home.homeDirectory}/dotfiles";
    };

    mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        modernz
        thumbfast
      ];

      config = {
        osc = "no";
      };
    };

    swaylock = {
      enable = true;
      settings.color = "000000";
    };

    tealdeer = {
      enable = true;
      settings.update = {
        auto_update = true;
      };
    };
  };
}
