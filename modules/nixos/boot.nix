{
  boot = {
    loader = {
      limine.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3; # Seconds before auto-booting
    };

    # Show a graphical splash screen instead of the scrolling boot log.
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
