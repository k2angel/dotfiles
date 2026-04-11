{ inputs, pkgs, ... }:

let
  nix-colors = inputs.nix-colors;
  colorScheme = nix-colors.colorSchemes.onedark;
in
{

  nixpkgs.overlays = with colorScheme.palette; [
    (self: super: {
      wmenu = super.symlinkJoin {
        name = "wmenu-wrapped";
        paths = [ super.wmenu ];
        nativeBuildInputs = [ self.makeWrapper ];
        postBuild = ''
          WMENU_FLAGS="-f 'JetBrains Mono NL Regular 11' -N '#${base00}' -n '#${base05}' -M '#${base0D}' -m '#${base00}' -S '#${base0D}' -s '#${base00}'"
          wrapProgram $out/bin/wmenu --add-flags "$WMENU_FLAGS"
          wrapProgram $out/bin/wmenu-run --add-flags "$WMENU_FLAGS"
        '';
      };
    })
  ];
}
