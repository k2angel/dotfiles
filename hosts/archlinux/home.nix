{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  programs = {
    beets.settings.directory = "/mnt/pirate/Music/Library";
  };

    };
  };

  systemd.user.packages = [
    config.services.mako.package
  ];

  home.packages = with pkgs; [
    dos2unix
    ipsw
    mcomix
    mkvtoolnix-cli
    n-m3u8dl-re
    opencommit
    payload-dumper-go
    pipe-rename
    razer-cli
    savepagenow
    sox
    slsk-batchdl
    tdl
    twitch-dl
    unar
    wireguard-tools
    yay
    xq-xml
    xnviewmp
  ];
}
