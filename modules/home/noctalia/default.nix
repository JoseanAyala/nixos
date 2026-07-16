{ config, pkgs, ... }:
{
  # Noctalia v5 (via the flake overlay in flake.nix).
  home.packages = [ pkgs.noctalia ];

  xdg.configFile."noctalia".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/noctalia/config";
}
