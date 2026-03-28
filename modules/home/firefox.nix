{ lib, pkgs, ... }:

{
  imports = [ ./betterfox.nix ];

  programs.firefox = {
    enable = true;
    languagePacks = [ "ja" "en-US" ];

    policies = {
      DisableTelemetry = true;
      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "blocked";
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = moz "bitwarden-password-manager";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
        "{5cce4ab5-3d47-41b9-af5e-8203eea05245}" = {
          install_url = moz "control-panel-for-twitter";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
        "addon@darkreader.org" = {
          install_url = moz "darkreader";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
        "{506e023c-7f2b-40a3-8066-bc5deb40aebe}" = {
          install_url = moz "gesturefy";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
        "{242af0bb-db11-4734-b7a0-61cb8a9b20fb}" = {
          install_url = moz "malwarebytes";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = moz "vimium-ff";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
        "uBlock0@raymondhill.net" = {
          install_url = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
        "@ublacklist" = {
          install_url = moz "ublacklist";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
          install_url = moz "violentmonkey";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
        "{d148819b-332d-4519-bfc3-679e49d27112}" = {
          install_url = moz "one-dark-scheme";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
      };
      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec {
            importedLists = [
              "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
              "https://yuki2718.github.io/adblock2/japanese/jpf-plus.txt"
            ];
            externalLists = lib.concatStringsSep "\n" importedLists;
          };
          selectedFilterLists = [
            "user-filters"
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "easylist"
            "easyprivacy"
            "adguard-spyware-url"
            "urlhaus-1"
            "plowe-0"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "fanboy-social"
            "fanboy-ai-suggestions"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist-annoyances"
            "ublock-annoyances"
            "JPN-1"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            "https://yuki2718.github.io/adblock2/japanese/jpf-plus.txt"
          ];
        };
      };
    };

    profiles.default = {
      settings = {
        "intl.locale.requested" = "ja,en-US";
        "extension.activeTehemeID" = "{d148819b-332d-4519-bfc3-679e49d27112}";
      };
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "query";   value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Nix Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "query";   value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };
          "NixOS Wiki" = {
            urls = [{
              template = "https://wiki.nixos.org/w/index.php";
              params = [{ name = "search"; value = "{searchTerms}"; }];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nw" ];
          };
        };
      };
    };
  };
}
