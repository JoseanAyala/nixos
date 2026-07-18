{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lazygit
    just
    btop
    fastfetch
    eza
    trash-cli
    claude-code
    bat
    ripgrep
    fd

    # TUI file manager — opens files via xdg/mimeapps.list
    yazi
    poppler-utils # PDF preview for yazi
    imagemagick # image preview for yazi
    ffmpegthumbnailer # video thumbnails
  ];

  programs = {
    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "cd"
      ];
    };
    fzf = {
      enable = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      fileWidget.command = "fd --type f --hidden --follow --exclude .git";
      changeDirWidget.command = "fd --type d --hidden --follow --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--info=inline"
      ];
    };
  };
}
