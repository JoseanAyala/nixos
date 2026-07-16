  { pkgs, ... }:

  {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      nerd-fonts.meslo-lg      # terminal + noctalia bar (your primary font)
      noto-fonts               # sans/serif fallback (system default resolves here)
      noto-fonts-color-emoji   # emoji

      liberation_ttf                  # Arial/Times look-alikes (web/docs)
      dejavu_fonts                    # broad extra coverage
      font-awesome                    # only if a widget needs FontAwesome specifically
    ];

    xdg.configFile."fontconfig/conf.d/10-dotfiles-defaults.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias>
          <family>monospace</family>
          <prefer>
            <family>MesloLGS Nerd Font</family>
            <family>Noto Sans Mono</family>
          </prefer>
        </alias>
        <alias>
          <family>sans-serif</family>
          <prefer><family>Noto Sans</family></prefer>
        </alias>
        <alias>
          <family>emoji</family>
          <prefer><family>Noto Color Emoji</family></prefer>
        </alias>
      </fontconfig>
    '';
  }
