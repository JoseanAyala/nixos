{ config, pkgs, ... }: {
  home.packages = [
    pkgs.ghostty
  ];

  # Writable out-of-store symlink so Noctalia can drop its generated ghostty
  # theme into ~/.config/ghostty at runtime (a plain `./config` copy is
  # read-only in the store and freezes the theme).
  xdg.configFile."ghostty".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/ghostty/config";
}
