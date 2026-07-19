{ config, pkgs, ... }:
{
  # Noctalia v5 (via the flake overlay in flake.nix).
  home.packages = with pkgs; [
    noctalia

    # Screen-capture backends Noctalia shells out to
    grim # frame grabber (fullscreen + region capture)
    slurp # interactive region selector
    wl-clipboard # `wl-copy`, used to put captures on the clipboard
  ];

  xdg.configFile."noctalia".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/noctalia/config";
}
