{ pkgs, username, ... }:

{
  services.atticd = {
    enable = true;
    environmentFile = "/etc/atticd/environment";

    settings = {
      listen = "0.0.0.0:5000";

      storage = {
        type = "local";
        path = "/mnt/atticd/storage";
      };

      garbage-collection = {
        interval = "1day";
        default-retention-period = "1 months";
      };
    };
  };

  users = {
    users.atticd = {
      isSystemUser = true;
      group = "atticd";
      uid = 929;
    };

    groups.atticd = {
      gid = 928;
      members = [ username ];
    };
  };

  environment.systemPackages = [ pkgs.attic-client ];
}
