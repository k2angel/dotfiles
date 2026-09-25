{
  inputs,
  self,
  config,
  lib,
  pkgs,
  isNixOS,
  ...
}:

let
  nixGLPackages = import "${inputs.nixGL}/default.nix" {
    pkgs = import inputs.nixpkgs-nixgl {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    enable32bits = true;
    enableIntelX86Extensions = true;
  };
in
{
  imports = [ (self + /modules/features/beets.nix) ];

  nixpkgs.config.allowUnfree = !isNixOS;

  targets.genericLinux = lib.mkIf (!isNixOS) {
    enable = true;

    nixGL = {
      packages = nixGLPackages;
      defaultWrapper = "nvidia";
      installScripts = [ "nvidia" ];
    };
  };

  programs = {
    beets.settings.directory = "/mnt/pirate/Music/Library";

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
      sox
      slsk-batchdl
      tdl
      twitch-dl
      unar
      wireguard-tools
      yay
      xq-xml
      xnviewmp
    ]
    ++ lib.optionals (!isNixOS) [
    ];
}
