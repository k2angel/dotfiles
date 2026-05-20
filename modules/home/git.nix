{
  config,
  pkgs,
  username,
  ...
}:

{
  programs = {
    gh.enable = true;

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    git = {
      enable = true;

      settings = {
        user = {
          name = "${username}";
          email = "90847045+k2angel@users.noreply.github.com";
        };

        delta = {
          line-numbers = true;
          keep-plus-minus-markers = true;
        };

        ghq = {
          root = "${config.home.homeDirectory}/src";
        };
      };
    };

    lazygit = {
      enable = true;

      settings = {
        gui.theme = with config.colorScheme.palette; {
          activeBorderColor = [
            "#${base0D}"
            "bold"
          ];
          inactiveBorderCoor = [ "#${base03}" ];
          searchingActiveBorderColor = [
            "#${base04}"
            "bold"
          ];
          optionsTextColor = [ "#${base06}" ];
          selectedLineBgColor = [ "#${base03}" ];
          cherryPickedCommitBgColor = [ "#${base02}" ];
          cherryPickedCommitFgColor = [ "#${base03}" ];
          unstagedChangesColor = [ "#${base08}" ];
          defaultFgColor = [ "#${base05}" ];
        };
      };
    };
  };

  home.packages = [
    pkgs.ghq
  ];
}
