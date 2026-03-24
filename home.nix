{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "k2angel";
  home.homeDirectory = "/home/k2angel";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    hello
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    LANG = "ja_JP.UTF-8";
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.ignoreAllDups = true;

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];
    initContent = ''
      # env
      export PROMPT="[%n@%m %1~]%(#.#.$) "

      # completion
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

      # keybindings
      bindkey -e
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[3~" delete-char
      bindkey "^H" backward-kill-word
      bindkey "^[[3;5~" kill-word
      bindkey "^p" history-search-backward
      bindkey "^n" history-search-forward

      # title
      autoload -Uz add-zsh-hook
      _precmd_title() { print -Pn "\e]0;%~ — zsh\a" }
      _preexec_title() { print -Pn "\e]0;%~ — $1\a" }
      add-zsh-hook precmd _precmd_title
      add-zsh-hook preexec _preexec_title
    '';
    shellAliases = {
      lg = "lazygit";
    };
  };

  programs.bat = {
    enable = true;

    config = {
      theme = "OneHalfDark";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;

    options = [
      "--cmd cd"
    ];
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

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "k2angel";
        email = "90847045+k2angel@users.noreply.github.com";
      };
    };
  };

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      onedarkpro-nvim
    ];
    initLua = ''
      vim.opt.number = true
      vim.opt.cursorline = true
      vim.opt.relativenumber = true
      vim.opt.signcolumn = "yes"

      vim.opt.expandtab = true
      vim.opt.shiftwidth = 4
      vim.opt.tabstop = 2
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { nix },
        callback = function()
          if vim.bo.filetype == "nix" then
            vim.opt_local.shiftwidth = 2
            vim.opt_local.tabstop = 2
          end
        end,
      })

      vim.opt.list = true
      vim.opt.listchars = {
        space = "･",
        tab = "» ",
        trail = "_",
      }

      vim.opt.undofile = true
      local undodir = vim.fn.expand("~/.local/state/nvim/undo")
      if vim.fn.isdirectory(undodir) == 0 then
        vim.fn.mkdir(undodir, "p")
      end
      vim.opt.undodir = undodir
      vim.opt.undolevels = 10000
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
