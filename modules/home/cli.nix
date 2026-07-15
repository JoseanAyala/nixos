{ pkgs, ... }: {
  home.packages = with pkgs; [
    gh
    lazygit
    just
    btop
    fastfetch
    zoxide
    fzf
    eza
    trash-cli
  ];
}
