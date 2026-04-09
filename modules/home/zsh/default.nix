{ config, pkgs, host, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      dotDir = "${config.xdg.configHome}/zsh";

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.ignoreAllDups = true;

      initContent = ''
        ${builtins.readFile ./init.zsh}
        ${pkgs.fortune}/bin/fortune -s | ${pkgs.cowsay}/bin/cowsay
      '';

      plugins = [
        { name = "fzf-tab"; src = "${pkgs.zsh-fzf-tab}/share/fzf-tab"; }
      ];

      shellAliases = {
        nob = "${pkgs.nh}/bin/nh os boot --diff always --hostname ${host}";
        nos = "${pkgs.nh}/bin/nh os switch --diff always --hostname ${host}";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    lsd = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        size = "short";
        date = "+%y-%m-%d %T";
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
