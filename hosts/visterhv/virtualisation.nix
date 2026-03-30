{ username, ... }:

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
        lms = {
          image = "docker.io/epoupon/lms";
          autoStart = true;
          extraOptions = [ "--pull=always" ];
          ports = [ "5082:5082" ];
          volumes = [
            "/var/lib/lms-data:/var/lms:rw"
            "/mnt/pirate/Music/Library:/music:ro"
          ];
        };
      };
    };
  };

  # users.users.${username}.extraGroups = [ "podman" ];
}
