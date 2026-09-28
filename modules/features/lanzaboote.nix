{ pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = false;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
