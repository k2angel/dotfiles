{ pkgs, fetchFromGitHub, ... }:

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
      base16 = fetchFromGitHub {
        owner = "matt-dong-123";
        repo = "base16.yazi";
        rev = "b02b7a80b59b9166b050a6a6dfd8769a81eab5e1";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };
    };

    plugins = with pkgs.yaziPlugins; {
      # full-border = full-border;
      ouch = ouch;
    };

    keymap = {
      mgr.prepend_keymap = [
        { run = "plugins ouch"; on = [ "C" ]; desc = "Compress with ouch"; }
      ];
    };

    settings = {
      opener = {
        extract = [
          { run = '${pkgs.ouch}/bin/ouch d -y "$@"'; desc = "Extract here with ouch"; }
        ];
      };

      plugin.prepend_previewers = [
        { run = "ouch --show-file-icons"; mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}"; }
      ];
    };

    theme = {
      flavor = { dark = "base16"; light = "base16"; };

      indicator = {
        padding = { open = "█"; close = "█"; };
      };

      status = {
        overall = { bg = "black"; };
        sep_left = { open = ""; close = ""; };
        sep_right = { open = ""; close = ""; };
      };
    };
  };
}
