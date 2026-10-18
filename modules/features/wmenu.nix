{
  nixpkgs.overlays = [
    (final: prev: {
      wmenu = prev.symlinkJoin {
        name = "wmenu-wrapped";
        paths = [ prev.wmenu ];
        nativeBuildInputs = [ final.makeWrapper ];

        postBuild = ''
          wrapProgram "$out/bin/wmenu" \
            --run 'eval "set -- ''${WMENU_OPTS-} \"\$@\""'
          wrapProgram "$out/bin/wmenu-run" \
            --run 'eval "set -- ''${WMENU_OPTS-} \"\$@\""'
        '';
      };
    })
  ];
}
