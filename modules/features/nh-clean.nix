{ ... }:

{
  programs.nh.clean = {
    enable = true;
    dates = "daily";
    extraArgs = "--keep-since=1w --no-gcroots --no-direnv";
  };
}
