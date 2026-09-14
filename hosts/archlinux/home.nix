{
  inputs,
  config,
  pkgs,
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
  nixpkgs.config = {
    allowUnfree = true;
  };

  targets.genericLinux = {
    enable = true;

    nixGL = {
      packages = nixGLPackages;
      defaultWrapper = "nvidia";
      installScripts = [ "nvidia" ];
    };
  };

  programs = {
    beets.settings.directory = "/mnt/pirate/Music/Library";
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
