{ username, ... }:

{
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.containers = {
      watcher = {
        image = "ghcr.io/k2angel/watcher";
        extraOptions = [ "--userns=keep-id" ];
        podman.user = username;

        volumes = [
          "/home/${username}/Containers/volumes/watcher/config.json:/usr/src/app/config.json:ro"
          "/home/${username}/Containers/volumes/watcher/attachments:/usr/src/app/attachments:rw"
        ];
      };
    };
  };

  users.users.${username}.linger = true;
}
