{ lib, username, ... }:

{
  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "26.05";

    keyboard = {
      layout = lib.mkDefault "jp";
      options = [ "ctrl:nocaps" ];
    };
  };
}
