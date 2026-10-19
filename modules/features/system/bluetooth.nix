{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.bluetooth;
in
{
  options = {
    features.bluetooth = {
      enable = lib.mkEnableOption "Enable bluetooth and bluetui";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    environment.systemPackages = [ pkgs.bluetui ];
  };
}
