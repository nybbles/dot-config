# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
# zstyle ':omz:update' mode disabled  # disable automatic updates zstyle ':omz:update' mode auto      # update automatically without asking
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
plugins=(git poetry fzf-zsh-plugin fzf-tab zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/jdt.ls/bin:$PATH

alias vim=nvim
export EDITOR=`which nvim`

eval "$(zoxide init zsh)"

export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/home/nimalan/.local/share/flatpak/exports/share:$XDG_DATA_DIRS

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

export PATH=/home/nimalan/code/beam/sdks/go/examples/.gogradle/project_gopath:$PATH

export PYTHONDONTWRITEBYTECODE=1

# From https://polothy.github.io/post/2019-08-19-fzf-git-checkout/

fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}

alias gb='fzf-git-branch'
alias gco='fzf-git-checkout'
alias gst='git status'
alias lg='lazygit'

# From https://github.com/unixorn/fzf-zsh-plugin#customization
export FZF_PREVIEW_ADVANCED=true
export FZF_PREVIEW_WINDOW='right:65%:nohidden'

LESSOPEN="|/home/nimalan/.local/lesspipe/./lesspipe.sh %s"
export LESSOPEN

export LESSOPEN='| lessfilter-fzf %s'

export GOPATH=$HOME/go

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nimalan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nimalan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/nimalan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/nimalan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH=$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH
eval "$(tmuxifier init -)"

zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

vim_ins_mode="%F{black}%K{yellow} INS %k%f"
vim_cmd_mode="%F{white}%K{red} CMD %k%f"
vim_vis_mode="%F{black}%K{blue} VIS %k%f"
vim_visline_mode="%F{black}%K{blue} VIL %k%f"
vim_rep_mode="%F{black}%K{green} REP %k%f"
vim_mode=$vim_ins_mode

function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      vim_mode=$vim_cmd_mode
    ;;
    $ZVM_MODE_INSERT)
      vim_mode=$vim_ins_mode
    ;;
    $ZVM_MODE_VISUAL)
      vim_mode=$vim_vis_mode
    ;;
    $ZVM_MODE_VISUAL_LINE)
      vim_mode=$vim_visline_mode
    ;;
    $ZVM_MODE_REPLACE)
      vim_mode=$vim_rep_mode
    ;;
  esac
}


bindkey -v

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/night-owl.omp.json)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GPG_TTY=$(tty)

export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH

export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmux/layouts"

eval "$(tmuxifier init -)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/nimalan/.lmstudio/bin"
# End of LM Studio CLI section

export PATH=~/.npm-global/bin:$PATH
