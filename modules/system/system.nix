{ self, lib, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  console.useXkbConfig = true;
  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "ja_JP.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  environment.etc."current-flake".source = self.outPath;

  system = {
    stateVersion = "26.05";
    configurationRevision = lib.mkIf (self ? rev || self ? dirtyRev) (self.rev or self.dirtyRev);
    tools.nixos-rebuild.enableRun0Elevation = true;
  };
}
