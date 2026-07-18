{
  programs.fish = {
    enable = true;

    shellAliases = {
      # eza
      ls = "eza --icons --group-directories-first";
      l = "eza -l --icons --group-directories-first --git --time-style=relative";
      la = "eza -la --icons --group-directories-first --git --time-style=relative";
      lt = "eza --tree --level=2 --icons --group-directories-first";

      # bat (modern cat)
      cat = "bat --paging=never";

      # trash-cli (safer rm)
      rm = "trash-put";

      # misc
      cls = "clear";
      vi = "nvim";
      vim = "nvim";
      gg = "lazygit";
      cc = "claude";
      h = "herdr";
      z = "cd";
    };

    functions = {
      fish_greeting = "fastfetch";
    };

  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
