{ pkgs, ... }:

{
  programs = {
    lazydocker.enable = true;
    beets.settings.directory = "/mnt/pirate/Music/Library";
    zsh.shellAliases.lzd = "${pkgs.lazydocker}/bin/lazydocker";
  };

  home.packages = with pkgs; [
    mcomix
    razer-cli
  ];

  home.sessionVariables = {
    DOCKER_HOST = "unix://$(podman info -f '{{.Host.RemoteSocket.Path}}')";
  };
}
