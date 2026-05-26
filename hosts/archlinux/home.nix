{ pkgs, ... }:

{
  programs = {
    beets.settings.directory = "/mnt/pirate/Music/Library";
  };

  home.packages = with pkgs; [
    mcomix
    payload-dumper-go
    pipe-rename
    razer-cli
    savepagenow
    sox
    slsk-batchdl
    twitch-dl
    wireguard-tools
    yay
    yt-dlp
  ];
}
