{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      wmenu = super.symlinkJoin {
        name = "wmenu-wrapped";
        paths = [ super.wmenu ];
        nativeBuildInputs = [ self.makeWrapper ];
        postBuild = ''
          WMENU_FLAGS="-f 'JetBrains Mono NL Regular 11' -N '#282c34' -n '#abb2bf' -M '#61afef' -m '#1e2127' -S '#61afef' -s '#1e2127'"
          wrapProgram $out/bin/wmenu --add-flags "$WMENU_FLAGS"
          wrapProgram $out/bin/wmenu-run --add-flags "$WMENU_FLAGS"
        '';
      };
    })
  ];
}
