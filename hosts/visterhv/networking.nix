{
  self,
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = [ (self + /modules/features/lmsd.nix) ];

  networking = {
    useDHCP = false;
    wireless.iwd.enable = true;

    firewall = {
      allowedUDPPorts = [ 5353 ];

      extraInputRules =
        let
          tcp = "{ 5082, 8096, 8920 }";
          udp = "{ 1900, 7359 }";
        in
        ''
          ether saddr 94:45:60:13:b6:aa tcp dport ${tcp} accept
          ether saddr 94:45:60:13:b6:aa udp dport ${udp} accept
          tcp dport ${tcp} drop
          udp dport ${udp} drop
        '';
    };

    wg-quick.interfaces.wg0 = {
      autostart = false;
      configFile = "/etc/wireguard/wg-US-FREE-15.conf";
    };
  };

  systemd.network = {
    enable = true;

    networks."25-wireless" = {
      name = "wlan0";
      dhcpV4Config.UseDNS = false;

      networkConfig = {
        DHCP = true;
        MulticastDNS = true;
      };
    };
  };

  services = {
    jellyfin = {
      enable = true;
      user = username;
    };

    lmsd = {
      enable = true;
      library = "/mnt/pirate/Music/Library";

      package = pkgs.lms.overrideAttrs (old: rec {
        version = "3.81.0";

        src = pkgs.fetchFromGitHub {
          owner = "epoupon";
          repo = "lms";
          rev = "v${version}";
          hash = "sha256-wyMTnTlKMS4N3zTY4C574BTB88nRugsi21QWjDeLZrg=";
        };

        buildInputs = with pkgs; [
          gtest
          boost190
          wt
          taglib
          libconfig
          libarchive
          ffmpeg
          zlib
          stb
          openssl
          xxhash
          pugixml
          onnxruntime
        ];

        postInstall = "";
      });
    };
  };

  systemd.services = {
    jellyfin = {
      wantedBy = lib.mkForce [ ];
    };
  };
}
