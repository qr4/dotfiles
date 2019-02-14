# Path to your oh-my-zsh installation.
#export ZSH=/Users/qr4/.oh-my-zsh
#Path to your oh-my-zsh configuration.
#zmodload zsh/zprof

include () {
    [[ -f "$1" ]] && source "$1"
}


export DYLD_FORCE_FLAT_NAMESPACE=1

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="gnzh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  git
  pipenv
  mercurial
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
  osx
  urltools
  web-search
  git
  zsh-syntax-highlightning
  zsh-autosuggestions
)

[[ -d $HOME/.oh-my-zsh ]] && ZSH=$HOME/.oh-my-zsh
[[ -d /usr/share/oh-my-zsh ]] && ZSH=/usr/share/oh-my-zsh

include $HOME/.oh-my-zsh/oh-my-zsh.sh
include /usr/share/oh-my-zsh/oh-my-zsh.sh
include ~/.shell_prompt.sh

# Customize to your needs...

export PATH=$HOME/.local/bin:$PATH
export CODE=/Users/qr4/code

# mac python bug
export DYLD_FORCE_FLAT_NAMESPACE=1
export HOST_IP_ADDRESS=127.0.0.1

# Announce 256 bit color support
export TERM=xterm-256color
#[ -n "$TMUX" ] && export TERM=screen-256color

# Set correct locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set the GIT_EDITOR
export GIT_EDITOR=vim

# Good old netcat
alias nc=netcat

alias ls=exa
alias l='exa --header --long --group --accessed --modified --created -lah'
alias ll='exa --header --long --group --accessed --modified --created -ah'
alias lt='exa --tree --level=2 --long'

# Less gdb output
alias gdb='gdb -q'

# Use C++14 standard by default
alias g++='g++ --std=c++14'
alias clang++='clang++ --std=c++14'

# neovim rulez
#alias vim=nvim

alias e='emacsclient -t'
alias ev='emacsclient -nc'
# Clear pacman cache: Only keep the latest version of every installed package in the cache
alias clearcache='sudo paccache -r -k 1; sudo paccache -r -u -k 0'

alias git-cola='env PYTHONPATH= git-cola'

# Easy access to a z3 environment (OS X only)
alias z3py='PYTHONPATH=/usr/local/Cellar/z3/4.4.0/lib/python2.7/dist-packages/ ipython2'

alias gprr='git submodule update --init --recursive --rebase --remote && git pull -r'
alias gpr='git pull -r'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp='git push origin HEAD:refs/for/master'
alias gpl='git push origin HEAD:refs/for/master | tee /dev/stderr |  grep -o "https:.*" | cut -d" " -f1 | pbcopy'

# cleanup docker
alias docker_cleanup="docker rm -v $(docker ps --filter status=exited -q) && docker rmi $(docker images --filter dangling=true -q)"

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

p() {
#    DIR=$(sh -c "find $CODE -maxdepth 3 -type d" | fzy -l 30)
    DIR=$(sh -c "find $CODE -maxdepth 3 -type d" | fzf)
    if [ ! -z "$DIR" ]; then
      cd "$DIR"
    fi
}

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"


include ~/zsh_private
include /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
include /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#zprof
