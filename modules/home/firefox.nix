{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    configPath = ".mozilla/firefox";

    profiles.default = {
      isDefault = true;
      extensions.packages = with pkgs.firefox-addons; [
        ublock-origin
        onepassword-password-manager
      ];
    };

    policies = {
      OfferToSaveLogins = false;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DontCheckDefaultBrowser = true;
    };
  };
}
