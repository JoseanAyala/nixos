{ config, pkgs, ... }: {
  # EasyEffects: a software effects rack for PipeWire, like a RØDECaster/GoXLR.
  services.easyeffects.enable = true;

  home.packages = with pkgs; [
    rnnoise-plugin
  ];

  xdg.dataFile."easyeffects/input/Podmic.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/audio/easyeffects/input/Podmic.json";
}
