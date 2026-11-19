{ config, lib, ... }:

let
  settings = with config.lib.stylix.colors.withHashtag; {
    f = "monospace 11";
    N = base00;
    n = base05;
    M = base0D;
    m = base00;
    S = base0D;
    s = base00;
  };

  flags = lib.cli.toCommandLineShell (optionName: {
    option = "-${optionName}";
    sep = null;
    explicitBool = false;
  }) settings;
in
{
  nixpkgs.overlays = [
    (final: prev: {
      wmenu = prev.symlinkJoin {
        name = "wmenu-wrapped";
        paths = [ prev.wmenu ];
        nativeBuildInputs = [ final.makeWrapper ];

        postBuild = ''
          wrapProgram $out/bin/wmenu --add-flags "${flags}"
          wrapProgram $out/bin/wmenu-run --add-flags "${flags}"
        '';
      };
    })
  ];
}
