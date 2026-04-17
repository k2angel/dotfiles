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

    tealdeer = {
      enable = true;
      settings.update = {
        auto_update = true;
      };
    };
  };

  home.packages = with pkgs; [
    duf
    ripgrep
    fastfetch
    fortune
    cowsay
    wineWow64Packages.stableFull
    winetricks
  ];
}
