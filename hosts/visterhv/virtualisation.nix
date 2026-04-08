{ pkgs, username, ... }:

{
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers = {
      backend = "podman";

      containers = {
        jellyfin = {
          image = "docker.io/jellyfin/jellyfin:latest";
          autoStart = true;
          ports = [ "8096:8096" ];
          volumes = [
            "/var/lib/jellyfin-cache:/cache"
            "/var/lib/jellyfin-config:/config"
            "/mnt/pirate/jellyfin:/media"
          ];
        };

        lms = {
          image = "docker.io/epoupon/lms:3.76.0";
          autoStart = true;
          ports = [ "5082:5082" ];
          volumes = [
            "/var/lib/lms-data:/var/lms:rw"
            "/mnt/pirate/Music/Library:/music:ro"
          ];
        };
      };
    };
  };

  environment.systemPackages = [
    pkgs.docker-compose
  ];

  # users.users.${username}.extraGroups = [ "podman" ];
}
