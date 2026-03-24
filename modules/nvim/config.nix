{ config, pkgs, ... }:

{
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
    initLua = builtins.readFile ./init.lua;
  };
}
