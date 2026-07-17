{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Default file manager
    kdePackages.dolphin
    kdePackages.kio-extras # extra KIO protocols + thumbnail helpers for Dolphin
    kdePackages.breeze-icons # icon theme so toolbar/file icons render

    # Companion apps (KDE/Qt, to match Dolphin + the Qt theme below)
    kdePackages.gwenview # image viewer (already in your windowrules)
    kdePackages.okular # PDF / document viewer
    kdePackages.ark # archive GUI — Dolphin's "Extract here" uses this

    # Thumbnailers so Dolphin renders image/video/RAW previews
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kimageformats # HEIF/AVIF/etc. image format support
    kdePackages.qtimageformats
    ffmpegthumbnailer # video thumbnails

    # Archive backends (so Ark can handle 7z/zip/rar-family)
    p7zip
    unzip

    # Removable-media auto-mount agent (see autostart.lua + services.udisks2)
    udiskie

    # Graphical disk manager (partition, format, SMART, ATA secure-erase).
    gnome-disk-utility

    # Provides the xdg-user-dirs-update CLI on PATH
    xdg-user-dirs

    # GTK theming GUI (Noctalia GTK prereq).
    nwg-look
    # Runs Noctalia's KColorScheme post-hook (kde/apply.py)
    python3
  ];

  # Standard XDG user directories (Desktop, Documents, Downloads, ...).
  # Home Manager writes ~/.config/user-dirs.dirs and creates the folders.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
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
    # Opt GTK4 out of adw-gtk3 so Noctalia owns gtk-4.0/gtk.css and its colors apply.
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
