{
  config,
  lib,
  pkgs,
  ...
}:

let
  nixGL = config.targets.genericLinux.nixGL.defaultWrapper != null;

  cfg = config.programs.mpv;

  inherit (lib) generators;
  inherit (builtins) typeOf stringLength;

  renderOption =
    option:
    rec {
      int = toString option;
      float = int;
      bool = lib.hm.booleans.yesNo option;
      string = option;
    }
    .${typeOf option};

  renderOptionValue =
    value:
    let
      rendered = renderOption value;
      length = toString (stringLength rendered);
    in
    "%${length}%${rendered}";

  renderOptions = generators.toKeyValue {
    mkKeyValue = generators.mkKeyValueDefault {
      mkValueString = renderOptionValue;
    } "=";
    listsAsDuplicateKeys = true;
  };

  renderScriptOptions = generators.toKeyValue {
    mkKeyValue = generators.mkKeyValueDefault {
      mkValueString = renderOption;
    } "=";
    listsAsDuplicateKeys = true;
  };

  renderProfiles = generators.toINI {
    mkKeyValue = generators.mkKeyValueDefault {
      mkValueString = renderOptionValue;
    } "=";
    listsAsDuplicateKeys = true;
  };

  mpvConf = lib.concatStringsSep "\n" (
    lib.filter (x: x != "") [
      (lib.optionalString (cfg.defaultProfiles != [ ]) (renderOptions {
        profile = lib.concatStringsSep "," cfg.defaultProfiles;
      }))

      (lib.optionalString (cfg.config != { }) (renderOptions cfg.config))

      (lib.optionalString (cfg.profiles != { }) (renderProfiles cfg.profiles))

      (lib.optionalString (cfg.includes != [ ]) (
        lib.concatMapStringsSep "\n" (x: "include=${x}") cfg.includes
      ))
    ]
  );

  inputConf = lib.concatStringsSep "\n" (
    lib.filter (x: x != "") [
      (lib.concatStringsSep "\n" (lib.mapAttrsToList (key: value: "${key} ${value}") cfg.bindings))
      cfg.extraInput
    ]
  );
in
{
  home.packages = lib.mkIf nixGL [
    (config.lib.nixGL.wrap (
      pkgs.mpv.override {
        scripts = cfg.scripts;
      }
    ))
  ];

  xdg.configFile = lib.mkIf nixGL (
    {
      "mpv/mpv.conf" = lib.mkIf (mpvConf != "") {
        text = mpvConf + "\n";
      };

      "mpv/input.conf" = lib.mkIf (inputConf != "") {
        text = inputConf + "\n";
      };
    }
    // lib.mapAttrs' (
      name: value:
      lib.nameValuePair "mpv/script-opts/${name}.conf" {
        text = renderScriptOptions value + "\n";
      }
    ) cfg.scriptOpts
  );
}
