{ ... }:

{
  fileSystems = {
    "/".options = [ "noatime" "compress=zstd" ];
    "/home".options = [ "noatime" "compress=zstd" ];
    "/nix".options = [ "noatime" "compress=zstd" ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 2*1024;
  }];
}

