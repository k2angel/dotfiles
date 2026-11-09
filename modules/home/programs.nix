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
    bat.enable = true;
    btop.enable = true;
    imv.enable = true;
    jqp.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    tmux.enable = true;

    aria2 = {
      enable = true;
      systemd.enable = true;

      settings = {
        dir = "${config.xdg.userDirs.download}/aria2";
        seed-time = 0;
      };
    };

    bemenu = {
      enable = true;
      package = null;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    foot = {
      enable = true;
      server.enable = true;

      settings = {
        main.pad = "4x2";
      };
    };

    nh = {
      enable = true;
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
      settings.updates.auto_update = true;
    };

    yt-dlp = {
      enable = true;

      settings = {
        output = "${config.xdg.userDirs.videos}/yt-dlp/%(extractor)s/%(id)s/%(id)s.%(ext)s";
        download-archive = "${config.xdg.userDirs.videos}/yt-dlp/downloaded.txt";
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

  home.sessionVariables = {
    COMMA_NIXPKGS_FLAKE = inputs.nixpkgs;
  };
}
