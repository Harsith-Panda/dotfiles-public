# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source "${HOME}/conda/etc/profile.d/conda.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/harsithps/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/harsithps/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/harsithps/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/harsithps/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

set -o vi

# Vi cursor. Block in every mode. The redraw hook was sending a bar
# whenever zsh still reported the insert keymap.
function _vi_cursor_shape() {
  emulate -L zsh
  builtin print -nu "${_ghostty_fd:-1}" '\e[2 q'
}

function _vi_cursor_install() {
  autoload -Uz add-zle-hook-widget
  add-zle-hook-widget zle-line-pre-redraw _vi_cursor_shape
  add-zle-hook-widget zle-keymap-select _vi_cursor_shape
  add-zle-hook-widget zle-line-init _vi_cursor_shape
  precmd_functions=(${precmd_functions:#_vi_cursor_install})
}
precmd_functions+=(_vi_cursor_install)

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/Users/harsithps/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/harsithps/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"



 export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export ODBCSYSINI=/usr/local/etc
export ODBCINI=/usr/local/etc/odbc.ini
export LDFLAGS="-L/usr/local/opt/freetds/lib"
export CPPFLAGS="-I/usr/local/opt/freetds/include"

# Added by Antigravity
export PATH="/Users/harsithps/.antigravity/antigravity/bin:$PATH"
eval "$(zoxide init zsh)"

# Added by Antigravity
export PATH="/Users/harsithps/.antigravity/antigravity/bin:$PATH"

# Added by Antigravity
export PATH="/Users/harsithps/.antigravity/antigravity/bin:$PATH"

# Added by Antigravity
export PATH="/Users/harsithps/.antigravity/antigravity/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/harsithps/.lmstudio/bin"
# End of LM Studio CLI section


# Added by Devin
export PATH="/Users/harsithps/.codeium/windsurf/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Themes - Subtle
# Colors refer to Ghostty's ANSI palette.


# ── Subtle syntax highlighting ──────────
#typeset -A ZSH_HIGHLIGHT_STYLES

#ZSH_HIGHLIGHT_STYLES[default]='fg=7'
#ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#626873'
#ZSH_HIGHLIGHT_STYLES[command]='fg=2'
#ZSH_HIGHLIGHT_STYLES[builtin]='fg=2'
#ZSH_HIGHLIGHT_STYLES[function]='fg=2'
#ZSH_HIGHLIGHT_STYLES[alias]='fg=6'
#ZSH_HIGHLIGHT_STYLES[precommand]='fg=2'
#ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=5'

#ZSH_HIGHLIGHT_STYLES[path]='fg=4,underline'
#ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=4'
#ZSH_HIGHLIGHT_STYLES[globbing]='fg=6'
#ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=5'

#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=3'
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=3'
#ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=3'
#ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=6'

#ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=8'
#ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=8'
#ZSH_HIGHLIGHT_STYLES[redirection]='fg=6'
#ZSH_HIGHLIGHT_STYLES[comment]='fg=8'
#

# opencode version
# Same dark palette. Unknown stays recessed grey. Valid commands sit
# lighter and greener so a typo and a real command don't share a weight.
typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[default]='fg=#D6D8DA'

ZSH_HIGHLIGHT_STYLES[command]='fg=#B7D4B0,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#B7D4B0,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=#B7D4B0,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#B7D4B0,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#B7D4B0,bold'
#ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#B7D4B0,bold'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#B7D4B0,bold,underline'

ZSH_HIGHLIGHT_STYLES[alias]='fg=#A8D4D2,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#A8D4D2,bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#A8D4D2,bold'

ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#D0B8D4'

# Unknown commands: dark grey, clearly not a command
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#7D858D'

#ZSH_HIGHLIGHT_STYLES[path]='fg=#A9C4E0'
#ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#A9C4E0'
#ZSH_HIGHLIGHT_STYLES[path]='fg=#A9C4E0,underline'
#ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#A9C4E0,underline'
#ZSH_HIGHLIGHT_STYLES[path]='fg=#8EBFDE,underline'
#ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#8EBFDE,underline'
#ZSH_HIGHLIGHT_STYLES[path]='fg=#C5CCD1,underline'
#ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#C5CCD1,underline'
ZSH_HIGHLIGHT_STYLES[path]='fg=#B3BAC0,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#B3BAC0,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#A8D4D2'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#D0B8D4'

#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#E0C49A'
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#E0C49A'
#ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#E0C49A'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#E2B48A'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#E2B48A'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#E2B48A'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#A8D4D2'

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#A7AEB6'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#A7AEB6'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#C4B0C8'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#8E969E'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#8E969E'

# Load syntax highlighting LAST
source "$(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

