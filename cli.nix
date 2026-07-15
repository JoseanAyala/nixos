{ pkgs, ... }: {
  home.packages = [
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
