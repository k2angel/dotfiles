{
  inputs,
  self,
  config,
  lib,
  pkgs,
  isNixos,
  ...
}:

let
  nixGLPackages = import "${inputs.nixGL}/default.nix" {
    pkgs = import inputs.nixGL.inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    enable32bits = true;
    enableIntelX86Extensions = true;
  };
in
{
  imports = [ (self + /modules/features/beets.nix) ];

  nixpkgs.config.allowUnfree = !isNixos;
  nixpkgs.config.cudaSupport = !isNixos;

  targets.genericLinux = lib.mkIf (!isNixos) {
    enable = true;

    nixGL = {
      packages = nixGLPackages;
      defaultWrapper = "nvidia";
      installScripts = [ "nvidia" ];
    };
  };

  programs = {
    beets.settings.directory = "/mnt/pirate/Music/Library";
    firefox.profiles.default.settings."browser.display.use_document_fonts" = 0;

    retroarch =
      let
        retroarch = pkgs.retroarch-bare;
      in
      {
        enable = true;
        package = lib.mkIf (!isNixos) (
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
      wireguard-tools
      xq-xml
      xnviewmp
    ]
    ++ lib.optionals (!isNixos) [
      blocky
      yay
      (config.lib.nixGL.wrap llama-cpp-cuda)
    ];
}
