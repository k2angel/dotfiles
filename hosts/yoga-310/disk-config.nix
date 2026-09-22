let
  mountOptions = [
    "noatime"
    "compress=zstd"
  ];
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";

        content = {
          type = "gpt";

          partitions = {
            ESP = {
              size = "128M";
              type = "EF00";
              priority = 1;

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              size = "100%";
              priority = 2;

              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];

                subvolumes = {
                  "@" = {
                    inherit mountOptions;
                    mountpoint = "/";
                  };

                  "@home" = {
                    inherit mountOptions;
                    mountpoint = "/home";
                  };

                  "@nix" = {
                    inherit mountOptions;
                    mountpoint = "/nix";
                  };

                  "@swap" = {
                    mountpoint = "/.swap";

                    mountOptions = [
                      "noatime"
                      "nodatacow"
                      "nodatasum"
                    ];

                    swap = {
                      swapfile = {
                        size = "4G";
                        path = "swapfile";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
