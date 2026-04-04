{ pkgs, host, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
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
        nrl = "${pkgs.nh}/bin/nh os switch --diff always --hostname ${host}";
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    lsd = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        size = "short";
        date = "+%y-%m-%d %T";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
