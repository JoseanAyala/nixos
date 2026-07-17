{
  programs.fish = {
    enable = true;

    shellAliases = {
      # eza (modern ls)
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
      z = "cd";
      h = "herdr";
    };

    functions = {
      fish_greeting = "fastfetch";
    };

    interactiveShellInit = ''
      # fzf
      set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
      set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
      set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
      set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --info=inline'

      # Shell integrations
      zoxide init --cmd=cd fish | source
      fzf --fish | source
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
