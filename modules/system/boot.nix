{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.systemd.enable = true;

    loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "max";
      systemd-boot.configurationLimit = 10;
      efi.canTouchEfiVariables = true;
    };
  };
}
