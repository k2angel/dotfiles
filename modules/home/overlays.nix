{ config, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      wmenu = prev.symlinkJoin {
        name = "wmenu-wrapped";
        paths = [ prev.wmenu ];
        nativeBuildInputs = [ prev.makeWrapper ];
        postBuild = with config.colorScheme.palette; ''
          WMENU_FLAGS="-f 'monospace 11' -N '#${base00}' -n '#${base05}' -M '#${base0D}' -m '#${base00}' -S '#${base0D}' -s '#${base00}'"
          wrapProgram $out/bin/wmenu --add-flags "$WMENU_FLAGS"
          wrapProgram $out/bin/wmenu-run --add-flags "$WMENU_FLAGS"
        '';
      };
    })
  ];
}
