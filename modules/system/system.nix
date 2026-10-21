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

  system.stateVersion = "26.05";
}
