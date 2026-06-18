{
  config,
  pkgs,
  host,
  ...
}:

{
  programs = {
    fzf.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.ignoreAllDups = true;

      initContent = ''
        ${builtins.readFile ./init.zsh}
        if [ -n "$SSH_CONNECTION" ]; then
          ${pkgs.fortune}/bin/fortune -s | ${pkgs.cowsay}/bin/cowsay -p
        else
          ${pkgs.fortune}/bin/fortune -s | ${pkgs.cowsay}/bin/cowsay
        fi
      '';

      plugins = [
        {
          name = "fzf-tab";
          src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
      ];

      shellAliases = {
        beet-import = "${pkgs.beets}/bin/beet import ${config.xdg.userDirs.music}/beet-import";
        ghqc = "cd $(${pkgs.ghq}/bin/ghq root)/$(${pkgs.ghq}/bin/ghq list | ${pkgs.fzf}/bin/fzf)";
        nob = "${pkgs.nh}/bin/nh os boot --diff always --hostname ${host}";
        nos = "${pkgs.nh}/bin/nh os switch --diff always --hostname ${host}";
      };
    };

    lsd = {
      enable = true;

      settings = {
        size = "short";
        date = "+%y-%m-%d %T";
      };
    };

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
