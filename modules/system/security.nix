{ pkgs, ... }:

{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.enable = false;

    doas = {
      enable = true;

      extraRules = [{
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }];
    };
  };

  environment.systemPackages = [ pkgs.doas-sudo-shim ];
}
