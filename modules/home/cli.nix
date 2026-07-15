{ pkgs, ... }: {
  home.packages = [
    pkgs.gh
    pkgs.lazygit
    pkgs.just
    pkgs.ghostty
    pkgs.btop
    pkgs.fastfetch
    pkgs.zoxide
    pkgs.trash-cli
  ];
}
