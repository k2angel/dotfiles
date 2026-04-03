{ pkgs, host, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      initContent = builtins.readFile ./init.zsh;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.ignoreAllDups = true;

      plugins = [
        { name = "fzf-tab"; src = "${pkgs.zsh-fzf-tab}/share/fzf-tab"; }
      ];

      shellAliases = {
        nrl = "nh os switch --hostname ${host}";
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
