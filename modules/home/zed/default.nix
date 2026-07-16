{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    zed-editor
    nil
    nixfmt
  ];

  # Writable out-of-store symlink so Noctalia can write its generated theme to
  # ~/.config/zed/themes/noctalia.json at runtime instead of hitting a
  # read-only store copy.
  xdg.configFile."zed".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/zed/config";
}
