{ username, ... }:

{
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune.enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.containers = {
      watcher = {
        image = "ghcr.io/k2angel/watcher";
        extraOptions = [ "--userns=keep-id" ];
        podman.user = username;

        volumes = [
          "/home/${username}/Documents/Containers/volumes/watcher/config.json:/app/config.json:ro"
          "/home/${username}/Documents/Containers/volumes/watcher/attachments:/app/attachments:rw"
        ];
      };
    };
  };

  users.users.${username}.linger = true;
}
