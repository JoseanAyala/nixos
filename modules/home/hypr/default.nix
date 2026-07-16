{ config, ... }:
{
  # Absolute string path (NOT ./config) so the symlink points at the live,
  # writable repo instead of a read-only /nix/store/...-source copy. This lets
  # Noctalia write its generated theme files into ~/.config/hypr at runtime.
  xdg.configFile."hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/hypr/config";
}
