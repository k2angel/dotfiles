{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "k2angel";
        email = "90847045+k2angel@users.noreply.github.com";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };
}
