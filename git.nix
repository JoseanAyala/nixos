{ pkgs, ... }: {
  home.packages = [
    pkgs.gh
    pkgs.lazygit
  ];
}
