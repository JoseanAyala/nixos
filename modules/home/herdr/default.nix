{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      herdr
    ];
  };
  programs.fish.shellAliases.h = "herdr";
  xdg.configFile."herdr/config.toml".source = ./config/config.toml;
}
