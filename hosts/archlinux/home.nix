{
  config,
  lib,
  pkgs,
  isNixOS,
  ...
}:

{
  features = {
    vesktop.enable = true;

    beets = {
      enable = true;
      directory = "/mnt/pirate/Music/Library";
    };
  };

  programs = {
    firefox.profiles.default.settings."browser.display.use_document_fonts" = 0;

    retroarch = {
      enable = true;

      cores = {
        np2kai.enable = true;
      };
    };
  };

  systemd.user.packages = [
    config.services.mako.package
  ];

  home.packages =
    with pkgs;
    [
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
      seeker
      sox
      slsk-batchdl
      tdl
      twitch-dl
      unar
      xq-xml
      xnviewmp
    ]
    ++ lib.optionals (!isNixOS) [
      wireguard-tools
      yay
    ];
}
