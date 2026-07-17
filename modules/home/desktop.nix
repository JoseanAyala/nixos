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
    # Front-end to udisks2; needs the polkit agent below to authorize actions.
    gnome-disk-utility

    # Provides the xdg-user-dirs-update CLI on PATH
    xdg-user-dirs
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

  # GTK apps: dark Adwaita-style theme + Papirus icons.
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
    gtk4.theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  # Qt apps (Dolphin, Gwenview, Okular, Ark) follow the Noctalia palette via the
  # KDE platform theme.
  qt = {
    enable = true;
    platformTheme.name = "kde"; # pulls in kdePackages.plasma-integration
    style.name = "breeze"; # pulls in the Breeze widget style
  };
}
