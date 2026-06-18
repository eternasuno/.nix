{
  vars,
  inputs,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    imports = [inputs.textfox.homeManagerModules.default];

    textfox = {
      enable = true;
      profiles = ["default"];
      config = {
        displayTitles = false;
        displayUrlbarIcons = true;
        extraConfig = ''
          #taskbar-tabs-button {
            display: none;
          }
        '';
      };
    };

    programs.firefox = {
      enable = true;

      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFirefoxAccounts = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;

        BrowserDataBackup = {
          AllowBackup = false;
          AllowRestore = false;
        };

        ExtensionSettings = {
          "@testpilot-containers" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          };
          "extension@tabliss.io" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/extension@tabliss.io/latest.xpi";
          };
          "firefox@tampermonkey.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi";
          };
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
          };
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          };
        };

        RequestedLocales = ["zh-CN"];
      };

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        search = {
          force = true;
          default = "ddg";
        };

        settings = {
          # fonts
          "font.size.variable.x-western" = 18;
          "font.size.monospace.x-western" = 16;
          "font.minimum-size.x-western" = 14;

          # legacy
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;

          # privacy / security
          "dom.security.https_only_mode" = true;
          "privacy.bounceTrackingProtection.mode" = 1;
          "privacy.fingerprintingProtection" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "privacy.query_stripping.enabled" = true;
          "privacy.query_stripping.enabled.pbmode" = true;
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.clearOnShutdown_v2.cache" = false;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
          "privacy.clearOnShutdown_v2.formdata" = true;
          "privacy.clearSiteData.browsingHistoryAndDownloads" = true;
          "privacy.clearSiteData.cache" = false;
          "privacy.clearSiteData.cookiesAndStorage" = false;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.emailtracking.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "signon.rememberSignons" = false;

          # network / dns
          "network.dns.disablePrefetch" = true;
          "network.http.speculative-parallel-limit" = 0;
          "network.prefetch-next" = false;

          # ui
          "browser.ctrlTab.sortByRecentlyUsed" = true;
          "browser.tabs.inTitlebar" = 1;
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.translations.automaticallyPopup" = false;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;

          # devtools
          "devtools.chrome.enabled" = true;
          "devtools.debugger.remote-enabled" = true;

          # misc
          "browser.ml.chat.footerBadge" = false;
          "browser.ml.chat.shortcuts" = false;
          "layout.css.has-selector.enabled" = true;
          "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "layout.spellcheckDefault" = 0;
        };
      };
    };
  };
}
