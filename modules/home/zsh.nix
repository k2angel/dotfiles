{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = builtins.readFile ../../config/init.zsh;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.ignoreAllDups = true;
    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];
  };

  programs.bat = {
    enable = true;
    config.theme = "OneHalfDark";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      size = "short";
      date = "+%y-%m-%d %T";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
