{
  inputs,
  self,
  pkgs,
  username,
  ...
}:

{
  imports = [
    (self + /modules/features/lanzaboote.nix)
    (self + /modules/features/bluetooth.nix)
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos-cuda.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];

    trusted-users = [
      "nixremote"
      "@wheel"
    ];
  };

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
      users = [ username ];
    };
  };

  programs = {
    gamemode.enable = true;

    java = {
      enable = true;
      package = pkgs.jdk.override { enableJavaFX = true; };
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        pipewire
        pipewire.jack
        jportaudio
        ffmpeg
      ];
    };

    steam = {
      enable = true;
      protontricks.enable = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
        inputs.nixpkgs-xr.packages.${pkgs.stdenv.hostPlatform.system}.proton-rtsp-bin
      ];
    };
  };

  systemd.services = {
    activate-monitor-dp-2 = {
      enable = true;
      description = "Enable DP-2 when WM starts";

      wantedBy = [ "graphical.target" ];
      after = [ "graphical.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/tee /sys/class/drm/card1-DP-2/status";
        StandardInputText = "on";
        RemainAfterExit = true;
      };
    };
  };

  users.users = {
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

  users.groups = {
    nixremote = { };
  };

  environment.systemPackages = with pkgs; [
    ffmpeg
    llama-cpp-cuda
    python3
    wineWow64Packages.waylandFull
    winetricks

    (pkgs.writeShellScriptBin "wine64" ''
      exec ${pkgs.wineWow64Packages.waylandFull}/bin/wine "$@"
    '')
  ];
}
