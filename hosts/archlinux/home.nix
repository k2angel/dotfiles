{
  self,
  config,
  lib,
  pkgs,
  isNixOS,
  ...
}:

{
  imports = [
    (self + /modules/features/beets.nix)
  ];

  programs = {
    beets.settings.directory = "/mnt/pirate/Music/Library";
    firefox.profiles.default.settings."browser.display.use_document_fonts" = 0;

    retroarch =
      let
        retroarch = pkgs.retroarch-bare;
      in
      {
        enable = true;
        package = lib.mkIf (!isNixOS) (
          retroarch
          // {
            wrapper = args: config.lib.nixGL.wrap (retroarch.wrapper args);
          }
        );

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
      blocky
      wireguard-tools
      yay
      (config.lib.nixGL.wrap llama-cpp-cuda)
    ];
}
