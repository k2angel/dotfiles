{
  self,
  pkgs,
  username,
  ...
}:

{
  imports = [ (self + /modules/features/lanzaboote.nix) ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [
    "nixremote"
    "@wheel"
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  programs.uwsm.waylandCompositors.sway.extraArgs = [ "--unsupported-gpu" ];

  boot.kernelParams = [
    "drm.edid_firmware=DP-2:edid/lg.bin"
    "video=DP-2:d"
    "video=HDMI-A-1:e"
  ];

  hardware = {
    graphics.enable = true;
    nvidia.open = true;

    display.edid.packages = [
      (pkgs.runCommand "lg-edid" { } ''
        mkdir -p $out/lib/firmware/edid
        cp "${./edid/lg.bin}" $out/lib/firmware/edid/lg.bin
      '')
    ];

    openrazer = {
      enable = true;
      users = [ "${username}" ];
    };
  };

  users = {
    groups.nixremote = { };

    users = {
      ${username}.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINy5U5i0X7MxWivscSC289DyUil96Gbdekwfei56ckZ1 u0_a468"
      ];

      nixremote = {
        isSystemUser = true;
        group = "nixremote";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEbCDJLpXQRW4OirmsLdK/BHTrWkE90zsNKlxIMnvhpy root@yoga-310"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    llama-cpp-cuda
  ];
}
