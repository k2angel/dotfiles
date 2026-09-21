{ pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = false;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
