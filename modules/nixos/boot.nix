{ ... }:
{
  # Limine registers a clean, named "Limine" UEFI entry in NVRAM
  # (idempotently), instead of the generic "UEFI OS" systemd-boot showed.
  boot.loader = {
    limine.enable = true;
    efi.canTouchEfiVariables = true;

    # If your AMI board still hides the named entry and only lists the
    # "UEFI OS" fallback, uncomment to also install at \EFI\BOOT\BOOTX64.EFI:
    # limine.efiInstallAsRemovable = true;
  };
}
