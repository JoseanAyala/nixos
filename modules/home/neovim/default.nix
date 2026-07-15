{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      neovim
      git
      gcc
      gnumake
      unzip
      ripgrep
      fd
      lazygit
      tree-sitter

      # -----------------------------------------------
      # Mason uninstalled in config, let nix manage LSP

      # Nix tooling
      nil
      nixfmt
      statix

      # Lua tooling for this Neovim config
      lua-language-server
      stylua
    ];

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };

  xdg.configFile."nvim".source = ./config;
}
