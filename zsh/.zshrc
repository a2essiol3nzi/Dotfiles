# --- PERFORMANCE & HISTORY ---
# Impostiamo ZDOTDIR così Zsh sa dove cercare i suoi file (history, compdump, etc)
export ZDOTDIR="$HOME/.config/zsh"

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_ignore_space

# --- PLUGIN MANAGER MANUALE (High Performance) ---
ZSH_PLUGINS_DIR="$ZDOTDIR/plugins"

# Funzione per caricare e compilare plugin in bytecode (.zwc)
load_plugin() {
    local plugin_dir="$ZSH_PLUGINS_DIR/$1"
    local plugin_script="$plugin_dir/$2"

    if [[ -f "$plugin_script" ]]; then
        # Compila se il file .zwc non esiste o è più vecchio del sorgente
        if [[ ! "$plugin_script.zwc" -nt "$plugin_script" ]]; then
            zcompile "$plugin_script"
        fi
        source "$plugin_script"
    fi
}

# --- CARICAMENTO PLUGINS ---
# Nota: fast-syntax-highlighting sostituisce il vecchio syntax-highlighting per maggiore efficienza
load_plugin "fast-syntax-highlighting" "fast-syntax-highlighting.plugin.zsh"
load_plugin "zsh-autosuggestions" "zsh-autosuggestions.zsh"

# --- COMPLETAMENTI ---
autoload -Uz compinit

# Inizializza i completamenti
compinit -d "$ZDOTDIR/.zcompdump"

# Ottimizzazione: compila il file dei completamenti per la prossima volta
# Solo se il file esiste e quello compilato è più vecchio o mancante
if [[ -f "$ZDOTDIR/.zcompdump" && ! "$ZDOTDIR/.zcompdump.zwc" -nt "$ZDOTDIR/.zcompdump" ]]; then
    zcompile "$ZDOTDIR/.zcompdump"
fi
zstyle ':completion:*' menu select

# --- ALIAS ---
export EDITOR=hx

alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -lh'
alias la='ls -lha'
alias grep='grep --color=auto'

alias ff='fastfetch -c ~/.config/fastfetch/screenfetch.jsonc'
alias fullfetch='fastfetch -c ~/.config/fastfetch/all.jsonc'

alias kicat='kitten icat'
alias kifont='kitty +list-fonts --full-name'
alias ssh='kitty +kitten ssh'

alias nrs="sudo nixos-rebuild switch --flake ~/Projects/Dotfiles/nixos-dotfiles#ZeNix";
alias nrb="sudo nixos-rebuild boot --flake ~/Projects/Dotfiles/nixos-dotfiles#ZeNix";
alias nuf="sudo nix flake update --flake ~/Projects/Dotfiles/nixos-dotfiles"
alias ngc="sudo nix-collect-garbage -d"

# --- TOKYO NIGHT PROMPT ---
setopt PROMPT_SUBST
autoload -Uz vcs_info
precmd() { vcs_info }

# Colore Git (Rosso/Arancio TokyoNight)
zstyle ':vcs_info:git:*' formats ' %F{203}(%b)%f'
zstyle ':vcs_info:git:*' actionformats ' %F{203}(%b|%a)%f'
zstyle ':vcs_info:*' check-for-changes true

# PROMPT: Path (Blue/Cyan) + Git + Arrow (Magenta)
# Colore 111: Blue/Cyan TokyoNight
# Colore 141: Magenta TokyoNight
PROMPT='%F{111}%~${vcs_info_msg_0_}%f
%F{141}❯ %f'

# --- KEYBINDINGS ---
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

# --- WORD NAVIGATION (Ctrl+Arrows) ---
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3;5~" delete-word
bindkey "^H" backward-delete-word

# Necessario per pinentry-curses: dice a gpg-agent su quale terminale disegnare il prompt della passphrase. Va impostato per ogni sessione
# di shell (non in home.sessionVariables, che è statico per la sessione grafica e non conosce il tty di ogni singolo terminale).
export GPG_TTY="$(tty)"

