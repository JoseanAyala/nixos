{ pkgs, config, ... }:
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
      # Let nix manage LSPs

      # Nix tooling
      nil
      nixfmt
      statix

      # Lua tooling for this Neovim config
      lua-language-server
      stylua
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/neovim/config";
}
