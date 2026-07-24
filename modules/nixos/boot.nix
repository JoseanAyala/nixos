{ colors, ... }:
{
  boot = {
    loader = {
      limine = {
        enable = true;
        extraEntries = ''
          /Windows
              protocol: efi_chainload
              path: guid(243c5304-98c3-40fd-aa31-2831ff4553b3):/EFI/Microsoft/Boot/bootmgfw.efi
        '';
        style = {
          wallpapers = [ ../../assets/limine-wallpaper.jpg ];
          interface = {
            branding = "NixOS";
            brandingColor = colors.text;
            helpColor = colors.muted;
            helpColorBright = colors.accent;
          };
          graphicalTerminal = {
            foreground = colors.text;
            margin = 0;
            marginGradient = 0;
          };
        };
      };
      efi.canTouchEfiVariables = true;
    };

    plymouth.enable = true;

    # Silent boot.
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
  };
}
