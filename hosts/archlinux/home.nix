{ pkgs, ... }:

{
  programs = {
    beets.settings.directory = "/mnt/pirate/Music/Library";
  };

  services = {
    pipewire = {
      enable = true;

      clientConfigs = {
        routing = {
          "stream.rules" = [
            {
              actions = {
                update-props = {
                  "target.object" = "alsa_output.usb-ASUSTeK_XONAR_SOUND_CARD-00.analog-stereo";
                };
              };

              matches = [
                { "node.name" = "bmsw-stream"; }
              ];
            }
          ];
        };
      };

      pulseConfigs = {
        routing = {
          "pulse.rules" = [
            {
              actions = {
                update-props = {
                  "target.object" = "alsa_output.pci-0000_00_1f.3.analog-stereo";
                };
              };

              matches = [
                { "application.process.binary" = "firefox"; }
              ];
            }
          ];
        };
      };
    };
  };

  home.packages = with pkgs; [
    mcomix
    payload-dumper-go
    pipe-rename
    razer-cli
    savepagenow
    sox
    slsk-batchdl
    twitch-dl
    wireguard-tools
    yay
  ];
}
