{ pkgs, ... }:

{
  features = {
    attic-watch-store = {
      enable = true;
      cache = "k2angel:private";
    };
  };

  home.packages = with pkgs; [
    attic-client
  ];
}
