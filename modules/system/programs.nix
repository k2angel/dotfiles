{ pkgs, username, ... }:

{
  programs = {
    kdeconnect.enable = true;
    zsh.enable = true;

    nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/${username}/nixos";
    };

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

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    ripgrep
    yazi
    nix-output-monitor
    nvd
  ];
}
