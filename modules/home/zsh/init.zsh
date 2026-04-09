# env
export PROMPT="[%n@%m %1~]%(#.#.$) "

# completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# keybindings
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

# title
autoload -Uz add-zsh-hook
_precmd_title() { print -Pn "\e]0;%~ — zsh\a" }
_preexec_title() { print -Pn "\e]0;%~ — $1\a" }
add-zsh-hook precmd _precmd_title
add-zsh-hook preexec _preexec_title
