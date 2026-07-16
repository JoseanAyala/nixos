{ config, pkgs, ... }:
{
  # Noctalia v5 (via the flake overlay in flake.nix).
  home.packages = [ pkgs.noctalia ];

  # Absolute string path (NOT ./config) so the symlink points at the live,
  # writable repo instead of a read-only /nix/store/...-source copy. Without
  # this, Noctalia cannot persist its own settings or generated palettes.
  xdg.configFile."noctalia".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/noctalia/config";
}
