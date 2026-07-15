# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# fzf
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --info=inline'

# Shell integrations
zoxide init --cmd=cd fish | source
fzf --fish | source

# eza (modern ls)
alias ls='eza --icons --group-directories-first'
alias l='eza -l --icons --group-directories-first --git --time-style=relative'
alias la='eza -la --icons --group-directories-first --git --time-style=relative'
alias lt='eza --tree --level=2 --icons --group-directories-first'

# bat (modern cat)
alias cat='bat --paging=never'

# trash-cli (safer rm)
alias rm='trash-put'

# misc
alias cls='clear'
alias vim='nvim'
alias gg='lazygit'
alias cc='claude'
alias z='cd'
