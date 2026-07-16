{ username, ... }: {
  imports = [
    ../../modules/home/cli.nix
    ../../modules/home/firefox.nix
    ../../modules/home/fish
    ../../modules/home/ghostty
    ../../modules/home/git
    ../../modules/home/herdr
    ../../modules/home/hypr
    ../../modules/home/lazygit
    ../../modules/home/neovim
    ../../modules/home/noctalia
    ../../modules/home/zed
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11"; # Please read the comment before changing.
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
