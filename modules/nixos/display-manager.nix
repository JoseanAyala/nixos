{ pkgs, ... }:
let
  # sddm-astronaut configured declaratively via nixpkgs' override. Mirrors the
  # Limine approach: a static wallpaper baked into the store + hand-picked accent
  # hexes, reusing the Limine palette so boot -> login stay cohesive.
  #
  # Background is a store path (world-readable) rather than a ~/ path, because
  # SDDM renders as the `sddm` system user *before* login and can't read $HOME.
  sddmTheme = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    themeConfig = {
      Background = "${../../assets/wallpaper.png}";
      CropBackground = "true";
      DimBackground = "0.35";
      DimBackgroundColor = "#1a1b26";

      # Full-screen blurred wallpaper, transparent centered form on top.
      FullBlur = "true";
      PartialBlur = "false";
      BlurMax = "64";
      Blur = "1.0";
      HaveFormBackground = "false";
      FormPosition = "center";
      RoundCorners = "12";

      # 12-hour clock, matching the Noctalia bar clock.
      HourFormat = "h:mm AP";
      DateFormat = "dddd, MMMM d";

      # Palette: Limine off-white text + red accent over a Tokyo Night base.
      HeaderTextColor = "#e1e2d5";
      DateTextColor = "#e1e2d5";
      TimeTextColor = "#e1e2d5";

      FormBackgroundColor = "#1a1b26";
      BackgroundColor = "#1a1b26";

      LoginFieldBackgroundColor = "#24283b";
      PasswordFieldBackgroundColor = "#24283b";
      LoginFieldTextColor = "#e1e2d5";
      PasswordFieldTextColor = "#e1e2d5";
      UserIconColor = "#e1e2d5";
      PasswordIconColor = "#e1e2d5";

      PlaceholderTextColor = "#6b6c63";
      WarningColor = "#d94a59";

      LoginButtonTextColor = "#e1e2d5";
      LoginButtonBackgroundColor = "#d94a59";
      SystemButtonsIconsColor = "#e1e2d5";
      SessionButtonTextColor = "#e1e2d5";
      VirtualKeyboardButtonTextColor = "#e1e2d5";

      DropdownTextColor = "#e1e2d5";
      DropdownSelectedBackgroundColor = "#d94a59";
      DropdownBackgroundColor = "#1a1b26";

      HighlightTextColor = "#e1e2d5";
      HighlightBackgroundColor = "#d94a59";
      HighlightBorderColor = "transparent";

      HoverUserIconColor = "#d94a59";
      HoverPasswordIconColor = "#d94a59";
      HoverSystemButtonsIconsColor = "#d94a59";
      HoverSessionButtonTextColor = "#d94a59";
      HoverVirtualKeyboardButtonTextColor = "#d94a59";
    };
  };
in
{
  services = {
    # SDDM as a Wayland greeter (no X server needed for a pure-Wayland setup).
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      # qtsvg / qtmultimedia / qtvirtualkeyboard are needed at runtime by the theme.
      extraPackages = sddmTheme.propagatedBuildInputs;
    };

    # Keymap for the greeter (Hyprland sets its own via config/input.lua).
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Installs the theme under /run/current-system/sw/share/sddm/themes.
  environment.systemPackages = [ sddmTheme ];
}
