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

  # Default apps for double-click in Dolphin. Without these, images resolve to
  # Okular's NoDisplay kimgio helper (won't launch) and text has no reliable
  # handler. Point images at Gwenview and text/code at Zed.
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        gwenview = [ "org.kde.gwenview.desktop" ];
        zed = [ "dev.zed.Zed.desktop" ];
      in
      {
        "image/png" = gwenview;
        "image/jpeg" = gwenview;
        "image/gif" = gwenview;
        "image/webp" = gwenview;
        "image/bmp" = gwenview;
        "image/tiff" = gwenview;
        "image/svg+xml" = gwenview;
        "image/heif" = gwenview;
        "image/avif" = gwenview;

        "text/plain" = zed;
        "application/json" = zed;
        "application/xml" = zed;
        "text/markdown" = zed;

        "application/pdf" = [ "org.kde.okular.desktop" ];

        # Preserve the Claude Code URL handler that was auto-registered.
        "x-scheme-handler/claude-cli" = [ "claude-code-url-handler.desktop" ];
      };
  };

  # KDE apps (Dolphin, "Open With", file dialogs) resolve which app opens a file
  # via ksycoca, KDE's service cache. kbuildsycoca only indexes applications if it
  # can walk an XDG applications.menu — which no package installs on a non-Plasma
  # session, so the cache indexed ZERO apps and Dolphin returned "0 offers" for
  # every mimetype (nothing would open). Reuse the stock menu that plasma-workspace
  # ships (already in the system closure via plasma6) instead of hand-writing one —
  # the upstream-recommended fix, nixpkgs#409986. uwsm sets XDG_MENU_PREFIX=hyprland-
  # so provide that name; the bare name covers apps launched without the prefix.
  xdg.configFile =
    let
      menu = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    in
    {
      "menus/hyprland-applications.menu".source = menu;
      "menus/applications.menu".source = menu;
    };

  # KDE's Qt platform theme reads the cursor from kcminputrc; without it, it
  # forces the (uninstalled) "breeze" cursor and Dolphin falls back to the red-X
  # cursor. Point it at the same Bibata theme as the rest of the session.
  home.file.".config/kcminputrc".text = ''
    [Mouse]
    cursorTheme=Bibata-Modern-Ice
    cursorSize=24
  '';

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
