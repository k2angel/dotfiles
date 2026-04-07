{ pkgs, fetchFromGithub, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    # initLua = ''
    #   require("full-border"):setup({
    #     type = ui.Border.PLAIN,
    #   })
    # '';

    flavors = {
      base16 = fetchFromGithub {
        owner = "matt-dong-123";
        repo = "base16.yazi";
        rev = "b02b7a80b59b9166b050a6a6dfd8769a81eab5e1";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };
    };

    plugins = with pkgs.yaziPlugins; {
      compress = compress;
      # full-border = full-border;
    };

    keymap = {
      mgr.prepend_keymap = [
        { run = "plugin compress"; on = ["c" "a" "a" ]; };
        { run = "plugin compress -p"; on = ["c" "a" "p" ]; };
        { run = "plugin compress -ph"; on = ["c" "a" "h" ]; };
        { run = "plugin compress -l"; on = ["c" "a" "l" ]; };
        { run = "plugin compress -phl"; on = ["c" "a" "u" ]; };
      ]
    };

    theme = {
      flavor = { dark = "base16"; light = "base16"; };

      indicator = {
        padding = { open = "█"; close = "█"; };
      };

      status = {
        oeverall = { bg = "black"; };
        sep_left = { open = ""; close = ""; };
        sep_right = { open = ""; close = ""; };
      };
    };
  };
}
