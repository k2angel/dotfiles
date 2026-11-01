{
  programs.nh.clean = {
    enable = true;
    dates = "Sun *-*-* 00:00:00";
    extraArgs = "--keep-since=1w --no-gcroots --no-direnv";
  };
}
