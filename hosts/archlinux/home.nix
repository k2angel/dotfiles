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

  systemd.user.packages = lib.mkIf (!isNixOS) [
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

      (opencode.overrideAttrs (
        final: prev: {
          node_modules = prev.node_modules.overrideAttrs (_: {
            outputHash =
              if pkgs.stdenv.hostPlatform.isLinux then
                "sha256-prx9dX7kUvs/E3zopkaPk5LXh3xJAy5sZeum/W8L7cA="
              else if pkgs.stdenv.hostPlatform.isDarwin then
                "sha256-dIveiaiPFGSItwLyeMuPDxTE9gpvvnlTCB/+nG24qCc="
              else
                throw "Unsupported platform";
          });
        }
      ))
    ]
    ++ lib.optionals (!isNixOS) [
      nix-serve-ng
      wireguard-tools
      yay
    ];
}
