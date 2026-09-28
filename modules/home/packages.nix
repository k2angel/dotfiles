{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-tools
    duf
    dust
    fastfetch
    fd
    jq
    ouch
    ripgrep
    tree
    wl-clipboard
    xh

    (trash-cli.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        (pkgs.fetchpatch {
          url = "https://github.com/andreafrancia/trash-cli/pull/403.patch";
          hash = "sha256-c9xUuHifZ4eTpOU7Lg+EvOJda5uoq3qh1LM/BEGYKSA=";
        })
      ];
    }))
  ];
}
