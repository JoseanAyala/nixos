{ ... }:
let
  moz = slug: "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
in
{
  programs.firefox = {
    enable = true;

    # Keep using the existing Firefox profile location and silence the
    # Home Manager configPath migration warning.
    configPath = ".mozilla/firefox";

    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = moz "ublock-origin";
          private_browsing = true;
        };

        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          installation_mode = "normal_installed";
          install_url = moz "1password-x-password-manager";
          private_browsing = true;
        };
      };
    };
  };
}
