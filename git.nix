{ pkgs, lib, ... }: {
  home.packages = [
      pkgs.gh
      pkgs.lazygit
    ];
}
