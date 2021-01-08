
#----------------------------------------------------------------------
#                       EXPORT SECRET KEY & PATH
#----------------------------------------------------------------------
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH=~/bin:$PATH

# Ignore warning dreprecated in rails
# export RUBYOPT='-W:no-deprecated'
export PATH=$PATH:$HOME/dotnet
export DOTNET_ROOT=$HOME/dotnet
export PATH=$HOME/.dotnet/tools:$PATH


export EMAIL_USER="<my email>"
export EMAIL_PASS="<my password email>"

# Set up default text editor open in terminal
# I use neovim
export EDITOR="nvim"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/home/<my username>/.deno/bin:$PATH"

export VISUAL=nvim

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

#----------------------------------------------------------------------
#                       GENERAL
#----------------------------------------------------------------------
# Awesome theme for zsh terminal --> need use with Nerd font
# For nerd font: I use Meslo nerd font
# Find all nerdfont at: https://www.nerdfonts.com/font-downloads
ZSH_THEME="agnoster"
plugins=(git)
source $ZSH/oh-my-zsh.sh


bindkey '^[OM' autosuggest-accept
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#----------------------------------------------------------------------
#                       CONSTANTS
#----------------------------------------------------------------------
# Constant word: shortcut to open quickly theses folders
WORK=/mnt/workspace
WGIT=$WORK/01-Gits
WJS0=$WGIT/01-JavaScript
WNODE=$WJS0/NODEJS
WREACT=$WJS0/REACT
WJS=$WJS0/JAVASCRIPT


#----------------------------------------------------------------------
#                       ALIASES
#----------------------------------------------------------------------
# Alias to open quickly in terminal
# Key for nvim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias ec="$EDITOR $HOME/.zshrc"
alias ev="$EDITOR $HOME/.config/nvim/init.vim"
alias evp="$EDITOR $HOME/.config/nvim/plugins.vim"
alias evg="$EDITOR $HOME/.config/nvim/general.vim"
alias evm="$EDITOR $HOME/.config/nvim/mappings.vim"

# source ~/.zshrc
alias sc="source $HOME/.zshrc"

# Docker
alias docker-rails-postgresql="docker-compose run app rails new . --force --no-deps --database=postgresql"
alias dr="docker-compose run web"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcb="docker-compose up --build"

# Git
alias gs="git status"
alias gp="git push"
alias gr="git remote -v"
alias gc="git commit -m"
alias railsp="rails assets:precompile RAILS_ENV=production"
alias hp="heroku run RAILS_ENV=production rake assets:precompile"
alias rails-reset-css="rake tmp:cache:clear && rails server"
export GH_EMAIL_TOKEN=<a token for travis gem>
alias dcw="docker-compose run web"


#----------------------------------------------------------------------
#                       Functions
#----------------------------------------------------------------------
# Funtions not important
# let's be nice to our terminal
function pls() {
	if [ "$1" ]; then
		sudo $@
	else
		sudo "$BASH" -c "$(history -p !!)"
	fi
}

# Pipe bat to less
    function lat()
    {
        bat --color=always $1 | less
    }

# Web Baby
    URLprefix="http://www."
    function web()
    {
        open "$URLprefix$@" -a "Google Chrome"
    }

# Browsersync alias
function webdev()
    {
        browser-sync start --server --files ./*
    }

# CD && LS all at once
    cd() { builtin cd "$@" && ls;}

# This will open manpages in preview!
    function preman()
    {
        man -t $@ | open -f -a "preview"
    }

# Open in google
    function google()
    {
        open $@ -a "Google Chrome"
    }

# Open in firefox
    function firefox()
    {
        open $@ -a "Firefox"
    }

# Notion script
    function notion()
    {
         pipenv run python /Users/Gmo/Blog/notion_scripts.py -f $@
    }

# Tmux create session
    function tnew()
    {
         tmux new-session -s $@
    }

# Tmux script to rename window
    function tname()
    {
         tmux rename-window $@
    }

# ----------------------------------------
# Cool features
# Shorten directory path for terminal
prompt_dir() {
  #prompt_segment blue $CURRENT_FG '%~'
  prompt_segment blue $CURRENT_FG '%2~'
}
# link help: https://shandou.medium.com/how-to-shorten-zsh-prompt-oh-my-zsh-14185f3e7ab7




#-----------------------------------------------------------------------
#                 ADD MORE PLUGINS
#-----------------------------------------------------------------------
# Plugin for oh-my-zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/<my username>/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath+=${ZDOTDIR:-~}/.zsh_functions
