{ username, ... }: {
  imports = [
    ../../modules/home/apps.nix
    ../../modules/home/cli.nix
    ../../modules/home/desktop.nix
    ../../modules/home/file-manager.nix
    ../../modules/home/firefox.nix
    ../../modules/home/fish.nix
    ../../modules/home/fonts.nix
    ../../modules/home/ghostty.nix
    ../../modules/home/git.nix
    ../../modules/home/herdr
    ../../modules/home/hypr
    ../../modules/home/neovim
    ../../modules/home/noctalia
    ../../modules/home/zed
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11"; # Please read the comment before changing.
  };

  # Home Manager writes ~/.config/user-dirs.dirs and creates the folders.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
