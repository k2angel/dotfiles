{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) types;

  cfg = config.programs.tuigreet;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.programs.tuigreet = {
    enable = lib.mkEnableOption "Graphical console greeter for greetd";
    package = lib.mkPackageOption pkgs "tuigreet" { };

    settings = lib.mkOption {
      type = tomlFormat.type;

      example = lib.literalExpression ''
        {
          display = {
            show_time = true;
            greeting = "Welcome to the system!";
            align_greeting = "center";
            issue = false;
          };

          remember = {
            username = true;
            session = false;
            user_session = true;
          };
        }
      '';

      description = ''
        tuigreet configuration ([documentation](https://github.com/tuigreet/tuigreet))
        as a Nix attribute set.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      useTextGreeter = true;
      settings.default_session.command = "${lib.getExe cfg.package} --config ${tomlFormat.generate "tuigreet.toml" cfg.settings}";
    };
  };
}
