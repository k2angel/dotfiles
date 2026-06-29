{ config, ... }:

let
  volumes_dir = "${config.home.homeDirectory}/Containers/volumes";
in
{
  services.podman = {
    enable = true;

    containers = {
      jellyfin = {
        autoStart = false;
        image = "docker.io/jellyfin/jellyfin:latest";
        ports = [ "8096:8096" ];
        volumes = [
          "${volumes_dir}/jellyfin-cache:/cache:rw"
          "${volumes_dir}/jellyfin-config:/config:rw"
          "/mnt/pirate/jellyfin:/media:rw"
        ];
      };

      lms = {
        image = "docker.io/epoupon/lms:latest";
        ports = [ "5082:5082" ];
        volumes = [
          "${volumes_dir}/lms-data:/var/lms:rw"
          "/mnt/pirate/Music/Library:/music:ro"
        ];
      };

      watcher = {
        image = "ghcr.io/k2angel/watcher:latest";
        userNS = "keep-id";
        volumes = [
          "${volumes_dir}/watcher/config.json:/usr/src/app/config.json:ro"
          "${volumes_dir}/watcher/attachments:/usr/src/app/attachments:rw"
        ];
      };
    };
  };
}
