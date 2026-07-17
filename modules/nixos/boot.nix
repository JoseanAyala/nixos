{ ... }:
{
  boot = {
    # Limine registers a clean, named "Limine" UEFI entry in NVRAM
    # (idempotently), instead of the generic "UEFI OS" systemd-boot showed.
    loader = {
      limine.enable = true;
      efi.canTouchEfiVariables = true;

      # If your AMI board still hides the named entry and only lists the
      # "UEFI OS" fallback, uncomment to also install at \EFI\BOOT\BOOTX64.EFI:
      # limine.efiInstallAsRemovable = true;

      # Seconds the bootloader menu waits before auto-booting the default
      # generation. Kept short so rollback/OS choices stay visible.
      timeout = 3;
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
