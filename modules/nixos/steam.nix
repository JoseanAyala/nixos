{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers

    # Adds a "Steam (gamescope)" SDDM session: Steam Big Picture inside its own
    # micro-compositor, isolated from Hyprland
    gamescopeSession.enable = true;
  };
}
