{ pkgs, ... }: {
  home.packages = [
    pkgs.git
    pkgs.gh
    pkgs.lazygit
    pkgs.just
  ];
}
