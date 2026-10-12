{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) types;

  cfg = config.services.lmsd;

  lms = pkgs.lms.overrideAttrs (old: rec {
    version = "3.81.0";

    src = pkgs.fetchFromGitHub {
      owner = "epoupon";
      repo = "lms";
      rev = "v${version}";
      hash = "sha256-wyMTnTlKMS4N3zTY4C574BTB88nRugsi21QWjDeLZrg=";
    };

    buildInputs = with pkgs; [
      gtest
      boost190
      wt
      taglib
      libconfig
      libarchive
      ffmpeg
      zlib
      stb
      openssl
      xxhash
      pugixml
      onnxruntime
    ];

    postInstall = "";
  });

  configAttrs = {
    working-dir = "/var/lib/lmsd";
    wt-resources = "${pkgs.wt}/share/Wt/resources";
    docroot = "${lms}/share/lms/docroot/;/resources,/css,/images,/js,/favicon.ico";
    approot = "${lms}/share/lms/approot";
    musicnn-model-path = "${lms}/share/lms/models/MSD_musicnn_embedding.onnx";
  };

  configFile = pkgs.writeText "lms.conf" (
    lib.generators.toKeyValue {
      mkKeyValue = key: value: "${key} = \"${value}\";";
    } configAttrs
  );
in
{
  options = {
    services.lmsd = {
      enable = lib.mkEnableOption "Lightweight Music Server";

      library = lib.mkOption {
        type = types.str;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.lmsd = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      environment.OMP_THREAD_LIMIT = "1";

      serviceConfig = {
        ExecStart = "${lib.getExe lms} ${configFile}";
        StateDirectory = "lmsd";
        DynamicUser = true;
        Restart = "on-failure";
        RestartSec = 10;

        CapabilityBoundingSet = [ "" ];
        DeviceAllow = "";
        DevicePolicy = "closed";
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        PrivateDevices = true;
        PrivateTmp = true;
        PrivateUsers = true;
        ProcSubset = "pid";
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectProc = "invisible";
        ProtectSystem = "strict";
        ReadOnlyPaths = [
          cfg.library
        ];
        RemoveIPC = true;
        RestrictAddressFamilies = [
          "AF_INET"
          "AF_INET6"
          "AF_UNIX"
        ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = [
          "@system-service"
          "~@resources"
          "~@privileged"
        ];
        UMask = "0077";
      };
    };
  };
}
