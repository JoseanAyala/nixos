{
  pkgs,
  username,
  hostname,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/1password.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/display-manager.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/steam.nix
  ];

  networking = {
    hostName = hostname;
    # NetworkManager runs its own wpa_supplicant; do NOT also set
    # networking.wireless.enable — that starts a second, standalone supplicant
    # that fights NetworkManager over the wifi interface.
    networkmanager.enable = true;
  };

  hardware.bluetooth.enable = true;

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
  };

  time.timeZone = "America/Puerto_Rico";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_PR.UTF-8";
    LC_IDENTIFICATION = "es_PR.UTF-8";
    LC_MEASUREMENT = "es_PR.UTF-8";
    LC_MONETARY = "es_PR.UTF-8";
    LC_NAME = "es_PR.UTF-8";
    LC_NUMERIC = "es_PR.UTF-8";
    LC_PAPER = "es_PR.UTF-8";
    LC_TELEPHONE = "es_PR.UTF-8";
    LC_TIME = "es_PR.UTF-8";
  };

  # Enable the fish shell system-wide
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      git
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # Deduplicate identical store files via hardlinks, on a schedule.
    optimise.automatic = true;
  };

  system.stateVersion = "26.05"; # Did you read the comment?
}
