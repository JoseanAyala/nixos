{ pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    spotify
    zapzap
  ];
}
