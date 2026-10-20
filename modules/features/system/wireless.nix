{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.wireless;
in
{
  options = {
    features.wireless = {
      enable = lib.mkEnableOption "Enable iwd and impala";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.wireless.iwd.enable = true;
    environment.systemPackages = [ pkgs.impala ];
  };
}
