{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # Provides the xdg-user-dirs-update CLI on PATH
      xdg-user-dirs

      # GTK theming GUI (Noctalia GTK prereq).
      nwg-look

      # Runs Noctalia's KColorScheme post-hook (kde/apply.py)
      python3
    ];

    # KDE's Qt platform theme (set below) reads the cursor from kcminputrc; without
    # it, it forces the (uninstalled) "breeze" cursor and KDE apps like Dolphin fall
    # back to the red-X cursor.
    file.".config/kcminputrc".text = ''
      [Mouse]
      cursorTheme=Bibata-Modern-Ice
      cursorSize=24
    '';

    pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    # Noctalia owns gtk-4.0/gtk.css and its colors apply.
    gtk4.theme = null;
  };

  # qt apps (dolphin, gwenview, okular, ark) follow the noctalia palette via the
  # kde platform theme (path: kde plasma direct kcolorscheme integration).
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };
}
