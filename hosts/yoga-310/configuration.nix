{ pkgs, username, ... }:

{
  nix = {
    distributedBuilds = true;

    settings = {
      trusted-users = [ "@wheel" ];
    };

    buildMachines = [
      {
        hostName = "builder";
        system = pkgs.stdenv.hostPlatform.system;
        protocol = "ssh-ng";
        maxJobs = 3;
      }
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
