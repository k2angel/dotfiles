{ inputs, self, pkgs, username, host, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs self username host; };
    users.${username} = {
      imports = [ ../home ];

      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "25.11";
      };
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
}
