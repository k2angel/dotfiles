{ lib, username, ... }:

let
  btrfsOptions = [
    "noatime"
    "compress=zstd"
  ];

  bindDirs = [
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Videos"
  ];
in
{
  fileSystems = {
    "/".options = btrfsOptions;
    "/home".options = btrfsOptions;
    "/nix".options = btrfsOptions;
    "/mnt/arch_home".options = btrfsOptions;
    "/mnt/arcade".options = btrfsOptions;
    "/mnt/game".options = btrfsOptions;
  }
  // lib.listToAttrs (
    map (dir: {
      name = "/home/${username}/${dir}";
      value = {
        device = "/mnt/arch_home/k2angel/${dir}";
        fsType = "none";
        options = [
          "bind"
          "x-systemd.after=/mnt/arch_home"
          "x-systemd.requires=/mnt/arch_home"
        ];
      };
    }) bindDirs
  );

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];
}
