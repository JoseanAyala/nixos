{ pkgs, config, ... }:
{
  home = {
    # Only neovim-specific tooling lives here. Shared CLI tools this config
    # also uses (git, lazygit, ripgrep, fd) are owned by cli.nix / git.nix so
    # removing this module can't break the shell setup.
    packages = with pkgs; [
      neovim
      gcc
      gnumake
      unzip
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
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/neovim/config";
}
