{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) types;

  cfg = config.services.lms;

  configFile = pkgs.runCommand "lms.conf" { } ''
    substitute ${cfg.package}/share/lms/lms.conf $out --replace-fail "/var/lms" "/var/lib/lms"
  '';
in
{
  options = {
    services.lms = {
      enable = lib.mkEnableOption "Lightweight Music Server";

      package = lib.mkPackageOption pkgs "lms" { };

      openFirewall = lib.mkOption {
        type = types.bool;
        default = false;
      };

      library = lib.mkOption {
        type = types.str;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ 5082 ];

    systemd.services.lms = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      environment.OMP_THREAD_LIMIT = "1";

      serviceConfig = {
        ExecStart = "${lib.getExe cfg.package} ${configFile}";
        StateDirectory = "lms";
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
