{ pkgs, colors, ... }:
let
  text = "#${colors.text}";
  muted = "#${colors.muted}";
  accent = "#${colors.accent}";
  base = "#${colors.base}";
  surface = "#${colors.surface}";

  sddmTheme = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    themeConfig = {
      Background = "${../../assets/wallpaper.png}";
      CropBackground = "true";
      DimBackground = "0.35";
      DimBackgroundColor = base;

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

      HeaderTextColor = text;
      DateTextColor = text;
      TimeTextColor = text;

      FormBackgroundColor = base;
      BackgroundColor = base;

      LoginFieldBackgroundColor = surface;
      PasswordFieldBackgroundColor = surface;
      LoginFieldTextColor = text;
      PasswordFieldTextColor = text;
      UserIconColor = text;
      PasswordIconColor = text;

      PlaceholderTextColor = muted;
      WarningColor = accent;

      LoginButtonTextColor = text;
      LoginButtonBackgroundColor = accent;
      SystemButtonsIconsColor = text;
      SessionButtonTextColor = text;
      VirtualKeyboardButtonTextColor = text;

      DropdownTextColor = text;
      DropdownSelectedBackgroundColor = accent;
      DropdownBackgroundColor = base;

      HighlightTextColor = text;
      HighlightBackgroundColor = accent;
      HighlightBorderColor = "transparent";

      HoverUserIconColor = accent;
      HoverPasswordIconColor = accent;
      HoverSystemButtonsIconsColor = accent;
      HoverSessionButtonTextColor = accent;
      HoverVirtualKeyboardButtonTextColor = accent;
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
