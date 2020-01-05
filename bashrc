# ==============================================================================
#
# ~/.bashrc
#
# Author: Ivan Bogachev <sfi0zy@gmail.com>, 2018-2019
#
# ==============================================================================



# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac



#-------------------------------------------------------------------------------
# Custom command prompt
#-------------------------------------------------------------------------------
# ✓ [08:45 AM] sfi0zy:x201e ~ $
#
# 1. Result of execution of the previous command (success [GREEN] / error [RED])
# 2. Current time [SAME COLOR AS #1]
# 3. Username [RED]
# 4. Hostname [YELLOW]
# 5. Working directory [BLUE]

PS1="\$(if [[ \$? == 0 ]]; then \
        echo \"\[\033[01;32m\]\342\234\223\"; \
    else \
        echo \"\[\033[01;31m\]\342\234\227 error:\$?\"; \
    fi) [\@] \[\033[01;31m\]\u\[\033[01;00m\]:\[\033[01;33m\]\h\[\033[01;34m\] \w $\[\033[00m\] "



#-------------------------------------------------------------------------------
# History settings
#-------------------------------------------------------------------------------

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# See HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Append to the history file, don't overwrite it
shopt -s histappend

# Save and reload history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"



#-------------------------------------------------------------------------------
# Exports
#-------------------------------------------------------------------------------

# Use vim as default text editor
export EDITOR=vim



#-------------------------------------------------------------------------------
# UI
#-------------------------------------------------------------------------------

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize



#-------------------------------------------------------------------------------
# Others
#-------------------------------------------------------------------------------

# Use >| instead of > for rewrite file with redirected stream
set -o noclobber



#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------

# Files
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ls='ls --color=auto'
alias ll='ls -lAhF'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# Replacements
alias diff='vimdiff'
alias top='htop'

# Bash
alias bash-reload='source ~/.bashrc'

# NPM
alias npm-list-global-packages='npm list -g --depth=0'
alias npm-list-global-updates='npm outdated -g --depth=0'
alias npm-update-globals='npm update -g'

# APT
alias apt-update-all='sudo apt update && sudo apt upgrade'
alias apt-remove-unused='sudo apt autoremove'
alias apt-list-packages='apt-mark showmanual'

# System
alias save-etc='sudo etckeeper commit'
alias etc-history='cd /etc && sudo gitk && cd -'
alias status='uname -sr && date && sensors | grep Core && free -h'

# Network
alias check-internet-connection='ping 8.8.8.8 -c 5'
alias share-this-directory='http-server & lt --port 8080'

# Useful tools
alias random-string='cat /dev/urandom | tr -cd "a-f0-9" | head -c 32'

# Others
alias grep='grep --color=auto'



#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------

function backup-documents() {
    zip -r --encrypt ~/backup_$(date '+%Y-%j').zip ~/Documents -x *node_modules* \
    && notify-send "The backup #$(date '+%Y-%j') has been created. It's time to copy it."
}

function pdf-extract-pages() {
    pdftk $1 cat $2 output $3
}

function pdf-concat() {
    pdftk $1 cat output $2
}

function convert-jpg-to-pdf-a4() {
    pdfjam --paper a4paper --outfile $2 $1
}

function convert-to-progressive-jpg() {
    convert -strip -interlace Plane -quality 80 $1 $2
}

function clocks() {
    printf "MSK " && TZ=":Europe/Moscow"       date "+%_I:%M %p %A"
    printf "SV  " && TZ=":America/Los_Angeles" date "+%_I:%M %p %A"
}


#-------------------------------------------------------------------------------
# PATH MANIPULATIONS
#-------------------------------------------------------------------------------

# Add Ruby Gems from ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# Add snap packages
export PATH="$PATH:/snap/bin"



#-------------------------------------------------------------------------------
# CUSTOM TERMINAL TITLES
#-------------------------------------------------------------------------------
# ! This script is tested in Elementary OS Hera with default terminal only.
#
# This script adds titles for tabs in terminal with the current working
# directory and the last executed command (without sudo, cd and other
# non-informative parts of it).

PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\$(print_terminal_tab_title)\a\]$PS1"

last_command=""


print_terminal_tab_title () 
{
    directory_for_title=""

    if [ "$PWD" == "$HOME" ]; then
        directory_for_title="Home"
    elif [ "$PWD" == "/" ]; then
        directory_for_title="/"
    else
        directory_for_title="${PWD##*/}"
    fi


    command_for_title=""

    if [[ "$last_command" == "" ]]; then
        echo "$directory_for_title"
        return
    elif [[ "$last_command" == sudo* ]]; then
        command_for_title="${last_command:5}"
        command_for_title="${command_for_title%% *}"
    else
        command_for_title="${last_command%% *}"
    fi

    printf "%s: %s" "$directory_for_title" "$command_for_title"
}


update_terminal_tab_title()
{
    case "$BASH_COMMAND" in 
        *\033]0*|update_*|echo*|printf*|clear*|cd*)
            last_command=""
        ;;
        *)
            last_command="${BASH_COMMAND}"
            printf "\033]0;%s\007" "$1"
        ;;
    esac
}

preexec_functions+=(update_terminal_tab_title)

