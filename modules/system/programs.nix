{ pkgs, ... }:

{
  programs = {
    kdeconnect.enable = true;
    zsh.enable = true;

    sway = {
      enable = true;

      extraPackages = with pkgs; [
        i3blocks
        i3status
        foot
        grim
        swayidle
        swaylock
        swaybg
        wmenu
        autotiling
        wl-clipboard
        mako
      ];
    };
  };
}
