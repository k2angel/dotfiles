{
  inputs,
  config,
  pkgs,
  username,
  ...
}:

{
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

  features = {
    bluetooth.enable = true;
    lanzaboote.enable = true;
  };

  boot.kernelParams = [
    "drm.edid_firmware=DP-2:edid/lg.bin"
  ];

  hardware = {
    graphics.enable = true;

    display.edid.packages = [
      (pkgs.runCommand "lg-edid" { } ''
        mkdir -p $out/lib/firmware/edid
        cp "${./edid/lg.bin}" $out/lib/firmware/edid/lg.bin
      '')
    ];

    nvidia = {
      open = true;
      branch = "latest";
    };

    openrazer = {
      enable = true;
      users = [ username ];
      packages.kernel =
        config.boot.kernelPackages.callPackage
          "${inputs.nixpkgs-openrazer}/pkgs/os-specific/linux/openrazer/driver.nix"
          { };
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

  users.users = {
    ${username}.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINy5U5i0X7MxWivscSC289DyUil96Gbdekwfei56ckZ1 u0_a468"
    ];

    nixremote = {
      isSystemUser = true;
      group = "nixremote";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqee7NEVf6h2+TYbBWQ45SyduaY8Ej8JzSNMCUX12F9 root@yoga-310"
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
