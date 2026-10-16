{
  inputs,
  config,
  pkgs,
  ...
}:

let
  nixGLPackages = import "${inputs.nixGL}/default.nix" {
    pkgs = import inputs.nixGL.inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    enable32bits = true;
    enableIntelX86Extensions = true;
  };

  retroarch = pkgs.retroarch-bare;
in
{
  nixpkgs.config.allowUnfree = true;

  targets.genericLinux = {
    enable = true;

    nixGL = {
      packages = nixGLPackages;
      defaultWrapper = "nvidia";
      installScripts = [ "nvidia" ];
    };
  };

  programs = {
    retroarch.package = (
      retroarch
      // {
        wrapper = args: config.lib.nixGL.wrap (retroarch.wrapper args);
      }
    );
  };
}
