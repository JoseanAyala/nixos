{ pkgs, ... }: {
  home.packages = with pkgs; [
    lazygit
    just
    btop
    fastfetch
    zoxide
    fzf
    eza
    trash-cli
    claude-code
    bat

    # TUI file manager — opens files via xdg/mimeapps.list (no ksycoca needed)
    yazi
    poppler-utils # PDF preview for yazi
    imagemagick # image preview for yazi
    ffmpegthumbnailer # video thumbnails
  ];
}
