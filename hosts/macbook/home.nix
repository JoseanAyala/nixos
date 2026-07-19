{ username, ... }: {
  imports = [
    ../../modules/home/cli.nix
    ../../modules/home/fish.nix
    ../../modules/home/git.nix
    ../../modules/home/neovim
  ];

  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.11"; # Please read the comment before changing.
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
