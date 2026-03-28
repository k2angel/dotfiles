{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      if [ "$TERM" = "linux" ]; then
        export LANG=en_US.UTF-8
      fi
    '';
  };

  # Enable sway
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      # i3blocks
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
}
