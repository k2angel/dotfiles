{ username, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "${username}";
        email = "90847045+k2angel@users.noreply.github.com";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.gh.enable = true;
}
