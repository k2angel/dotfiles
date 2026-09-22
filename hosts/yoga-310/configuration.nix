{ pkgs, username, ... }:

{
  nix.settings = {
    substituters = [
      "http://192.168.3.171:5000"
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "cache.archlinux.local-1:30Lhk8MrzdEz+Fp5oRrjiyR9m/icirtQsDxntO0oKcA="
    ];
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  users.users.${username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKeFnOZf13UIpO0QK2eGJoiGYPvdOUrUaiVwoTC7I4fm k2angel@archlinux"
  ];
}
