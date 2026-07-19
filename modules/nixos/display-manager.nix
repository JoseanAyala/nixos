{ pkgs, ... }:
let
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
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      extraPackages = sddmTheme.propagatedBuildInputs;
      settings.Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  environment.systemPackages = [
    sddmTheme
    pkgs.bibata-cursors
  ];
}
