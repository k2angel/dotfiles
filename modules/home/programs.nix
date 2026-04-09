{ pkgs, ... }:

{
  programs = {
    bat = {
      enable = true;
      config.theme = "OneHalfDark";
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        modernz
        thumbfast
      ];

      config = {
        osc = "no";
      };
    };
  };

  home.packages = with pkgs; [
    duf
    ripgrep
    tealdeer
    fastfetch
    fortune
    cowsay
    wineWow64Packages.stableFull
    winetricks
  ];
}
