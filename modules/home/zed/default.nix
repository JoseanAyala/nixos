{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zed-editor
    nil
    nixfmt-rfc-style
  ];

  xdg.configFile."zed".source = ./config;
}
