{ pkgs, ... }:

{
  programs = {
    beets.settings.directory = "/mnt/pirate/Music/Library";
  };

  home.packages = with pkgs; [
    mcomix
    razer-cli
  ];
}
