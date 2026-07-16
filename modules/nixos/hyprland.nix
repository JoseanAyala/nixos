{
  programs.hyprland = {
    enable = true;
    withUWSM = true; # keybinds/config launch apps via `uwsm app --`
  };

  services = {
    # SDDM as a Wayland greeter (no X server needed for a pure-Wayland setup).
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Keymap for the greeter (Hyprland sets its own via config/input.lua).
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
