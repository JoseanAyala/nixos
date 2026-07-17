{ pkgs, ... }: {
  home.packages = with pkgs; [
    lazygit
    just
    btop
    fastfetch
    zoxide
    fzf
    eza
    trash-cli
    claude-code
  ];
}
