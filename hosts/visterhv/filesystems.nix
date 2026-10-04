{ lib, username, ... }:

let
  btrfsOptions = [
    "noatime"
    "compress=zstd"
  ];
in
{
  fileSystems = {
    "/".options = btrfsOptions;
    "/home".options = btrfsOptions;
    "/nix".options = btrfsOptions;
    "/mnt/arch_home".options = btrfsOptions;
    "/mnt/arcade".options = btrfsOptions;
    "/mnt/atticd".options = btrfsOptions;
    "/mnt/game".options = btrfsOptions;
  };
}
