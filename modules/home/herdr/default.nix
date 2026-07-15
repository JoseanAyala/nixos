{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      herdr
    ];
  };
  xdg.configFile."herdr".source = ./config;
}
