{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    git
    gcc
    gnumake
    unzip
    ripgrep
    fd
    lazygit
    tree-sitter

    # Nix tooling
    nil
    nixfmt-rfc-style
    statix

    # Lua tooling for this Neovim config
    lua-language-server
    stylua
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile."nvim".source = ./config;
}
