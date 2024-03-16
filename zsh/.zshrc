# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export ANOTHER_PATH=/Users/baylen/.cargo/bin/

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"


# PATH variables
export PATH="$PATH:$HOME/Scripts/"

# Other Environment variables
export EDITOR="nvim"
export W3M_DIR=".config/w3m"


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
plugins=(git zsh-autosuggestions pass)

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

alias mkdir="mkdir -pv"
alias ls="ls -h --color=auto"
alias cp="cp -i"

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/git/dotfiles/ --work-tree=$HOME'

alias irc='irssi'
alias irssi='irssi --config=~/.config/irssi/config --home=~/.config/irssi'
alias rsh='source ~/.config/zsh/.zshrc'
alias news='newsraft'
alias yt='ytfzf'
alias email='neomutt'
alias mutt='neomutt'
alias trans='transmission-cli'
alias lazyvim='nvim'
alias vi='nvim'
alias miami='sshpass -p $(pass Miami) ssh romanebm@ceclnx01.cec.miamioh.edu'
alias up='cd ..'
alias pass='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'
alias pw='~/Scripts/fzfpw/fzfpw.sh'

alias doppler='mpv https://radar.weather.gov/ridge/standard/KILN_loop.gif --loop --no-osc'

url() {
    # Reset
    local color_Off='\033[0m'       # Text Reset
    local BLUE='\033[0;34m'         # Blue
    local UNDERLINE='\033[4m'
    local copy_mode=false
    if [ "$1" = "-c" ]; then
        copy_mode=true
    fi

    # Path to the bookmarks file
    local BOOKMARKS_FILE="$HOME/Documents/bookmarks.txt"

    # Extract lines not starting with '#' using grep, and pass them to fzf
    local selected_line=$(grep -v '^#' "$BOOKMARKS_FILE" | fzf --prompt="Select a bookmark: ")

    # Check if a line was selected
    if [ -n "$selected_line" ]; then
        # Extract the URL from the selected line
        local selected_url=$(echo "$selected_line" | cut -d' ' -f1)

        if $copy_mode; then

            echo "$selected_url" | pbcopy
            echo -e "URL copied to clipboard: ${UNDERLINE}${BLUE}$selected_url"
        else
            # Open the selected URL in Firefox, redirecting both stdout and stderr to /dev/null
            open "$selected_url" >/dev/null 2>&1 & disown
            echo -e "url: opening ${UNDERLINE}${BLUE}$selected_url"
        fi
    fi
}

pzf() {
  local selected_password

  # Use fzf to interactively select a password
  selected_password=$(pass ls | fzf --prompt="Select a password: ")

  # Check if a password is selected
  if [ -n "$selected_password" ]; then
    # Use pass to show the password and copy it to the clipboard
    pass show -c "$selected_password"
    echo "Password for $selected_password copied to clipboard."
  else
    echo "No password selected."
  fi
}
# Open Bookmarks in Librewolf
op() {
    local selected_url
    selected_url=$(grep -v '^#' ~/Documents/bookmarks.txt | grep 'https://' | sort | fzf -e --prompt='Open a URL: ' | cut -d' ' -f1)

    # If the selection is empty (zsh is closed before a selection is made), the URL will not be opened.
    if [ -n "$selected_url" ]; then
        librewolf "$selected_url"
    fi
}

# Edit File - fzf menu file picker for nvim
ef() {
    local selected_file

    # If a search query is provided, use it with find and fzf
    if [ -n "$1" ]; then
        selected_file=$(find ~ -type f -not -path '*/.git/*' -maxdepth 5 2>/dev/null | fzf -e --query="$1" --prompt='Edit a file: ')
    else
        # If no search query is provided, use find without filtering
        selected_file=$(find ~ -type f -not -path '*/.git/*' -maxdepth 5 2>/dev/null | fzf -e --prompt='Edit a file: ')
    fi

    # If the selection is empty (zsh is closed before a selection is made), the file will not be opened.
    if [ -n "$selected_file" ]; then
        nvim "$selected_file"
    fi
}

# Quick Play
qp() {
    local selected_file

    # If a search query is provided, use it with find and fzf
    if [ -n "$1" ]; then
        selected_file=$(find /Volumes/music/ -type f -not -path '*/.git/*' -name '*.flac' -maxdepth 5 2>/dev/null | fzf -e --query="$1")
    else
        # If no search query is provided, use find without filtering
        selected_file=$(find /Volumes/music/ -type f -not -path '*/.git/*' -name '*.flac' -maxdepth 5 2>/dev/null | fzf -e)
    fi

    echo "$selected_file"
    
    if [ -n "$selected_file" ]; then
        mpv "$selected_file" --no-video
    else
        echo "No file selected."
    fi
}

movie() {
    local selected_file

    if [ -n "$1" ]; then
        selected_file=$(find /Volumes/video/ -name ".mkv" -type f -not -path '*/.git/*' -maxdepth 5 2>/dev/null | fzf -e --query="$1")
    else
        selected_file=$(find /Volumes/video/ -name "*.mkv" -type f -not -path '*/.git/*' -maxdepth 5 2>/dev/null | fzf -e)
    fi

    echo "$selected_file"
    
    if [ -n "$selected_file" ]; then
        mpv "$selected_file" --osc
    else
        echo "No file selected."
    fi
}
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackage
bp() {
  local inst=$(brew search "$@" | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackage
beer() {
  local inst=$(brew search "*" | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}
fman() {
    man -k . | fzf --prompt='Select a manual: ' | awk '{print $1}' | xargs -r man
}

fcd() {
  local dir
  dir=$(fd --type d | fzf +m) # Use fd for faster directory listing, install it with `brew install fd` or `sudo apt-get install fd-find`

  if [ -n "$dir" ]; then
    cd "$dir"
    fzf_cd
  fi
}

nav() {
  local dir
  while true; do
    dir=$(find . -maxdepth 1 -type d -print | sed 's|^\./||' | fzf +m --height 40% --layout=reverse --border)
    
    if [ -z "$dir" ]; then
      break
    fi
    
    cd "$dir"
  done
}

cal() {
    # Download the updated iCal file
    echo "Downloading Canvas calendar..."
    URL="https://miamioh.instructure.com/feeds/calendars/user_hhQvoPihNHeT9ZEOI1azxQPgmbohdBbZRVYQEZ7J.ics"
    OUTPUT_FILE="~/.config/canvas.ics"
    curl -o "$OUTPUT_FILE" "$URL"

    # Purge existing Calcurse data
    echo "Purging existing calcurse data..."
    calcurse -D

    # Import the updated iCal file
    calcurse-import -i "$OUTPUT_FILE"

    # Launch Calcurse
    calcurse

}

killer() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
