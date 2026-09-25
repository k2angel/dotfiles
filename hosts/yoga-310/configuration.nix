{
  self,
  pkgs,
  username,
  ...
}:

{
  imports = [ (self + /modules/features/attic-watch-store.nix) ];

  nix = {
    settings = {
      trusted-users = [ "@wheel" ];
    };

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
