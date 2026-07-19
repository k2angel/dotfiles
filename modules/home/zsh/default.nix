{
  lib,
  config,
  pkgs,
  host,
  ...
}:

let
  cowsay = lib.getExe pkgs.cowsay;
  fortune = lib.getExe pkgs.fortune;
  ghq = lib.getExe pkgs.ghq;
  nh = lib.getExe pkgs.nh;
in
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
          ${fortune} -s | ${cowsay} -p
        else
          ${fortune} -s | ${cowsay}
        fi
      '';

      plugins = [
        {
          name = "fzf-tab";
          src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
      ];

      shellAliases = {
        beet-import = "${lib.getExe pkgs.beets} import ${config.xdg.userDirs.music}/beet-import";
        ghqc = "cd $(${ghq} root)/$(${ghq} list | ${lib.getExe pkgs.fzf})";
        nob = "${nh} os boot --diff always --hostname ${host}";
        nos = "${nh} os switch --diff always --hostname ${host}";
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
