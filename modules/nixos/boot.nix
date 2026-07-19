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
            brandingColor = "e1e2d5";
            helpColor = "6b6c63";
            helpColorBright = "d94a59";
          };
          graphicalTerminal = {
            foreground = "e1e2d5";
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
