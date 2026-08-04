{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [ inputs.nix-index-database.homeModules.default ];

  programs = {
    aria2p.enable = true;
    jqp.enable = true;
    nix-index-database.comma.enable = true;

    aria2 = {
      enable = true;
      systemd.enable = true;

      settings = {
        dir = "${config.xdg.userDirs.download}/aria2";
        seed-time = 0;
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
      flake = "${config.home.homeDirectory}/dotfiles";

      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3 --no-gcroots --no-direnv";
      };
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
      settings.update.auto_update = true;
    };

    yt-dlp = {
      enable = true;

      settings = {
        output = "${config.xdg.userDirs.videos}/YouTube/%(id)s/%(id)s.%(ext)s";
        download-archive = "${config.xdg.userDirs.videos}/YouTube/downloaded.txt";
        downloader = "aria2c";
        embed-chapters = true;
        embed-info-json = true;
        embed-metadata = true;
        embed-thumbnail = true;
        write-comments = true;
        write-description = true;
        write-info-json = true;
        write-playlist-metafiles = true;
        write-thumbnail = true;
        merge-output-format = "mkv";
        remux-video = "mkv";
      };
    };
  };
}
