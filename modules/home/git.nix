{
  config,
  pkgs,
  username,
  ...
}:

{
  programs = {
    gh.enable = true;
    lazygit.enable = true;

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    git = {
      enable = true;
      package = null;

      settings = {
        init.defaultBranch = "main";

        user = {
          name = username;
          email = "90847045+k2angel@users.noreply.github.com";
        };

        delta = {
          keep-plus-minus-markers = true;
          line-numbers = true;
          side-by-side = true;
        };

        ghq = {
          root = "${config.xdg.userDirs.documents}/src";
        };
      };
    };
  };

  home.packages = [
    pkgs.ghq
  ];
}
