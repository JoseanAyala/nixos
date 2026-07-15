{ pkgs, ... }: {
  home.packages = [
    pkgs.git
    pkgs.gh
    pkgs.lazygit
    pkgs.just
    pkgs.ghostty
    pkgs.neovim
    pkgs.btop
    pkgs.fastfetch
    pkgs.zoxide
    pkgs.trash-cli
  ];
}
