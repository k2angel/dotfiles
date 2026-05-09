{
  lib,
  config,
  pkgs,
  ...
}:

{

  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "unrar"
        "ventoy"
      ];

    permittedInsecurePackages = [
      "ventoy-1.1.12"
    ];
  };

  programs = {
    bat = {
      enable = true;
      config.theme = "OneHalfDark";
    };

    bemenu = {
      enable = true;

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
      enableBashIntegration = true;
      enableZshIntegration = true;
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

  home.packages = with pkgs; [
    android-tools
    aria2
    duf
    fastfetch
    fd
    libnotify
    ntfs2btrfs
    ouch
    payload-dumper-go
    ripgrep
    rsync
    sox
    slsk-batchdl
    sway-contrib.grimshot
    trash-cli
    twitch-dl
    tree
    unrar
    ventoy
    wmenu
    wl-clipboard
    yt-dlp
  ];
}
