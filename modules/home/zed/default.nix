{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zed-editor
    nil
    nixfmt
  ];

  xdg.configFile."zed".source = ./config;
}
