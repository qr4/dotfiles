# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh"

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
plugins=(
  git
  repo
  python
  brew
  history-substring-search
  vagrant
  tmux
  encode64
  history
  jsontools
  docker
  vi-mode
  zsh-fzf-history-search
  macos
  urltools
  web-search
  zsh-autosuggestions
)

include() { [[ -f "$1" ]] && source "$1" }

include $ZSH/oh-my-zsh.sh

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


#include ~/.shell_prompt.sh

# Customize to your needs...

export PATH=$HOME/.local/bin:$PATH export CODE=~/code

# mac python bug
export DYLD_FORCE_FLAT_NAMESPACE=1 export HOST_IP_ADDRESS=127.0.0.1

# Announce 256 bit color support
export TERM=xterm-256color #[ -n "$TMUX" ] && export TERM=screen-256color

# Set correct locales
export LC_ALL=en_US.UTF-8 export LANG=en_US.UTF-8

# Set the GIT_EDITOR
export GIT_EDITOR=nvim

export GRADLE_USER_HOME=$HOME/.gradle

# Good old netcat
alias nc=netcat

alias mkdir=mkdir -p

alias python=python3

alias ls=exa
alias l='exa --header --long --group --accessed --modified --created -lah'
alias ll='exa --header --long --group --accessed --modified --created -ah'
alias lt='exa --tree --level=3 --long'

# Less gdb output
alias gdb='gdb -q'

# Use C++14 standard by default
alias g++='g++ --std=c++14'
alias clang++='clang++ --std=c++14'

# neovim rulez
alias vim=nvim

alias e='emacsclient -t'
alias ev='emacsclient -nc'
# Clear pacman cache: Only keep the latest version of every installed package in the cache
alias clearcache='sudo paccache -r -k 1; sudo paccache -r -u -k 0'

alias git-cola='env PYTHONPATH= git-cola'

alias tx='tmuxinator'

# Easy access to a z3 environment (OS X only)
alias z3py='PYTHONPATH=/usr/local/Cellar/z3/4.4.0/lib/python2.7/dist-packages/ ipython2'

#alias gprr='git submodule update --init --recursive --rebase --remote && git pull -r'
alias gpr='git pull -r --autostash'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp='git push origin HEAD:refs/for/master'
alias gpl='git push origin HEAD:refs/for/master | tee /dev/stderr |  grep -o "https:.*" | cut -d" " -f1 | pbcopy'

docker_cleanup() {
  docker rm -v $(docker ps --filter status=exited -q) && docker rmi $(docker images --filter dangling=true -q)
}
#
# Uncompresses raw zlib compressed data.
#
# usage: unzlib [files]
#
# example: curl http://127.0.0.1/raw_zlib_stuff | unzlib
#          unzlib .git/objects/*/*
#
unzlib() {
  if [ $# -eq 0 ]; then
    # read from stdin
    cat <(printf "\x1f\x8b\x08\x00\x00\x00\x00\x00") - | gzip -dcq
    return 0
  fi

  for file in "$@"; do
      if [ $# -gt 1 ]; then
         if [ $file != $1 ]; then
             # print newline
             echo "\n"
         fi
         echo ">>>> $file <<<<"
     fi

    # add gzip magic and pipe to gunzip
    printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" | cat - $file | gzip -dcq
  done
}
gppr() {
  set -ux
  CUR_BRANCH=`git rev-parse --abbrev-ref HEAD`
  REMOTE_MAIN_BRANCH=`git symbolic-ref refs/remotes/origin/HEAD --short`

  git stash --all
  git branch -D xxxxxx || true
  git checkout -b xxxxxx
  git reset --hard $REMOTE_MAIN_BRANCH
  git cherry-pick $CUR_BRANCH
  git push origin HEAD:$1 --force
  git checkout $CUR_BRANCH
  git branch -D xxxxxx
  git stash pop
}

#
# Decode jwt
#
# usage: jwt_decode <JWT>
#
jwt_decode() {
  jq -R 'split(".") | .[1] | @base64d | fromjson' <<< "$1"
}

#
# Extract various archive formats
#
# usage: extract <file>
#
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#
# Highlights every occurande of the search pattern while displaying the whole content
#
# usage: cmd | highlight search_pattern
#        highlight search_pattern file
#
highlight() {
  grep -E "$|$1" --color $2
}

#
# Interface to the OS clipboard (Linux only)
#
# usage: clip           # show clipboard content
#        clip <file>    # copy file content to clipboard
#        cmd | clip     # copy output of cmd to clipboard
#
clip() {
  if [[ -t 0  && -z "$1" ]]; then
    # output contents of clipboard
    xclip -out -selection clipboard
  elif [[ -n "$1" ]]; then
    # copy file contents to clipboard
    xclip -in -selection clipboard < "$1"
  else
    # read from stdin
    xclip -in -selection clipboard
  fi
}

#
# cat with syntax highlighting
#
# usage: scat file1 file2 ...
#
scat() {
  for arg in "$@"; do
    pygmentize -g "$arg" 2> /dev/null || cat "$arg"
  done
}

#
# Create a new directory and cd into it
# Similar to "mkdir xxx && cd $_"
#
mkcd() {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

#
# Share files using transfer.io
#
# Uploads the provided file or data (if being piped to) to https://transfer.sh and puts the resulting URL into the OS clipboard.
#
# usage:
#   transfer <file>
#   some_command | transfer filename.txt
#
transfer() {
  if [ $# -eq 0 ]; then
    echo "No arguments specified. Usage:\ntransfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
    return 1
  fi

  file=$1
  tmpfile=$(mktemp -t transferXXX)
  basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g')

  if [ -t 0 ]; then
    # stdin is a terminal, so assume the user wants to upload a local file/directory (as opposed to piping the data to this function).
    if [ ! -e $file ]; then
      echo "File $file doesn't exists."
      return 1
    fi

    if [ -d $file ]; then
      # zip directory content and transfer.
      zipfile=$(mktemp -t transferXXX.zip)
      cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
      curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
      rm -f $zipfile
    else
      # transfer file.
      curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
    fi
  else
    # stdin is not a terminal. Presumably someone is piping something to us, so upload that.
    curl --progress-bar --upload-file - "https://transfer.sh/$basefile" >> $tmpfile
  fi

  cat $tmpfile
  # Put resulting URL (without trailing whitespace) into the OS clipboard (OS X only)
  cat $tmpfile | tr -d '\n\r' | pbcopy
  rm -f $tmpfile
}

# open files in finder
o() {
  [[ -z $1 ]] && open . || open $*
}

init_worktree() {
  set -x
  if [ $# -eq 0 ]; then
    echo "No arguments specified. Usage:\ntinit_worktree <REMOTE_URL>"
    return 1
  fi

  take $1;
  git checkout -b worktree_root
  git rm -rf ./
  git commit -m"init"
}

worktree_add_existing() {
  git worktree add --track -b $1 $1 origin/$1 && cd $1
}

worktree_add_new() {
  if [ `git rev-parse --verify origin/master 2> /dev/null` ]; then
    git worktree add --track -b $1 $1 origin/master && cd $1
  else
    git worktree add --track -b $1 $1 origin/main && cd $1
  fi
} 

p() {
    DIR=$(sh -c "find $CODE -maxdepth 3 -type d" | fzf)
#    DIR=$(sh -c "find $CODE -maxdepth 3 -type d" | sk)
    if [ ! -z "$DIR" ]; then
      cd "$DIR"
    fi
}

g1ep() {
  read x
  echo "$x"
  rg $@
}

REPEAT() {
  delay=$1
  shift
  while true;
  do
    date
    echo "Executing: $@"
    eval $@
    echo -e '\n\n'
    echo sleeping for $delay seconds...
    sleep $delay || return
  done
}

andCount() {
  x=$(mktemp)
  tee "$x"
  echo -n "number of lines: "
  wc -l < "$x"
}

watcher() {
  dir = $1
  shift
  while true;
  do
    watch -d -t -g "ls -lR ${dir} | sha1sum" && `eval $@`;
  done;
}

open_ports() {
  netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print cred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"
}

SKIM_CTRL_T_COMMAND='rg --files --no-ignore --glob "!.git/*"'

export GOPATH="$HOME/go"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/Cellar/golangci-lint/1.27.0/bin/:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/bin/:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$HOME/code/vw/flutter/bin:$PATH"
export PATH="$HOME/code/privat/rust-analyzer:$PATH"
export PATH="$HOME/.asdf/shims:$PATH"
export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
export PATH="$HOME/.asdf/installs/nodejs/16.13.0/bin:$PATH"
export PATH="/usr/local/opt/ffmpeg@2.8/bin:$PATH"
export PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/:$PATH"
export PATH="/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/:$PATH"
export KAFKA_REPO="$HOME/code/peek_cloppenburg/confluent-kafka-topology"
export EDITOR="nvim"


export CLOUDSDK_PYTHON=
export GOOGLE_APPLICATION_CREDENTIALS=

export GOARCH=amd64
export CGO_ENABLED=1
export JAVA_HOME=$HOME/.local/share/rtx/installs/java/openjdk-18

include ~/.zshrc_private
include /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
include /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
include /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

fortune | cowsay | lolcat
#zprof

export PNPM_HOME="~/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export DYLD_LIBRARY_PATH=/Users/vitalihenne/code/privat/dungeons_and_diagrams/dist/lib
export PMIP_CBC_LIBRARY=/Users/vitalihenne/code/privat/dungeons_and_diagrams/dist/lib/libCbc.dylib

# emacs lsp
#export LSP_USE_PLISTS=true

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(direnv hook zsh)"
eval "$(ssh-agent)" 
[ -s "/opt/homebrew/bin/rtx" ] && eval "$(/opt/homebrew/bin/rtx activate zsh)"
