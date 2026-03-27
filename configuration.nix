# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ./modules/soroemono.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Filesystem
  fileSystems = {
    "/".options = [ "noatime" "compress=zstd" ];
    "/home".options = [ "noatime" "compress=zstd" ];
    "/nix".options = [ "noatime" "compress=zstd" ];
  };
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 2*1024;
  }];

  networking.hostName = "nixos-vm"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" ];
  };
  console.keyMap = "jp106";

  # Enable sway
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      # i3blocks
      i3status
      foot
      grim
      swayidle
      swaylock
      swaybg
      wmenu
      autotiling
      wl-clipboard
      mako
    ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.k2angel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  security.polkit.enable = true;
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      groups = [ "wheel" ];
      keepEnv = true;
      persist = true;
    }];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    doas-sudo-shim
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    font-awesome
    jetbrains-mono
    udev-gothic
    nerd-fonts.symbols-only
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable greetd
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --time --cmd sway";
        user = "greeter";
      };
    };
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable= true;
    jack.enable = true;
    # pulse.enable = true;
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}

