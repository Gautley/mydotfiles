# oh my zsh:
export ZSH=/home/gautley/.oh-my-zsh
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# Lines configured by zsh-newuser-install:
unsetopt nomatch
unsetopt appendhistory autocd beep extendedglob notify
bindkey -e
zstyle :compinstall filename '/home/gautley/.zshrc'
autoload -Uz compinit
compinit

# Keybinds:
bindkey "^[[H" beginning-of-line         # Home
bindkey "^[[F" end-of-line               # End
bindkey "^[[3~" delete-char              # Del
bindkey '^[[5~' up-line-or-history       # PageUp
bindkey '^[[6~' down-line-or-history     # PageDown

function append_to_path()
{
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$PATH:$1"
    esac
}

alias diskusage="du -chad 1"
alias ll="ls -l"
alias llh="ls -lh"
alias l="ls"
alias pcregrep="pcregrep --color=auto"
alias errcho=">&2 echo"
alias keycodes="xmodmap -pke"

HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000

# Java setup:
if [ -d /opt/jdk* ]
then
    JAVA_HOME=`ls -d /opt/jdk*`
    PATH="$PATH:$JAVA_HOME/bin"
    export JAVA_HOME
fi

# Adding to PATH:
[[ -d ~/.bin ]] && append_to_path ~/.bin
[[ -d ~/.scripts ]] && append_to_path ~/.scripts

export PATH
export HISTFILE
export HISTSIZE
export SAVEHIST
export VISUAL=nvim
export EDITOR="$VISUAL"

function is_software_installed()
{
    # Checks if a software is installed. Only one parameter, Arch Linux only.
    # echoes 0 when the command was found.
    # echoes >0 when command wasn't an error occurred.
    # echoes 126 when command was found but couldn't be invoked.
    # echoes 127 when an iternal error occurred.

    if [ $# -ne 1 ]
    then
        errcho \
            "is_software_installed: error: Accepts only one parameter, not $#."
        return 1
    fi
    
    command -v "$1" > /dev/null
    echo $?
}

function search_software()
{
    # Search for a software name in Pacman
    if [ $(is_software_installed pacman) -ne 0 ]
    then
        errcho "This function requires pacman."
        errcho "Not in Arch?"
        return 1
    fi

    [[ "$EUID" != 0 ]] &&\
        echo "Requires sudo to sync database ... "
    sudo pacman -Fy
    
    if [ $? -ne 0 ]
    then
        errcho "An error occurred. Abort."
        return 1
    else
        columns=`tput cols`
        i=0
        dashes=""
        while [ $i -lt $columns ]
        do
            dashes="$dashes-"
            i=`expr $i + 1`
        done
        echo "$dashes"
    fi

    for arg in "$@"
    do
        pacman -Fs "$arg"
    done
}

function translate_english_to_portuguese()
{
    if [ $(is_software_installed trans) -ne 0 ]
    then
        errcho "This function requires the software \'translate-shell\'."
        return 1
    fi

    if [ $# -ne 1 ]
    then
        errcho "Only one argument needed."
        return 1
    fi

    trans -b en: "$1" :pt
}

function translate_portuguese_to_english()
{
    if [ $(is_software_installed trans) -ne 0 ]
    then
        errcho "This function requires the software \'translate-shell\'."
        return 1
    fi

    if [ $# -ne 1 ]
    then
        errcho "Only one argument needed."
        return 1
    fi

    trans -b pt: "$1" :en
}

function speak_in_english()
{
    if [ $(is_software_installed trans) -ne 0 ]
    then
        errcho "This function requires the software \'translate-shell\'."
        return 1
    fi

    if [ $# -ne 1 ]
    then
        errcho "Only one argument needed."
        return 1
    fi

    trans -speak -s en "$1" 1>/dev/null
}


function meaning_of_english_word()
{
    if [ $(is_software_installed trans) -ne 0 ]
    then
        errcho "This function requires the software \'translate-shell\'."
        return 1
    fi

    if [ $# -ne 1 ]
    then
        errcho "Only one argument needed."
        return 1
    fi

    trans -d -s en "$1" | less -R
}

function download_last_video_from_youtube_channel()
{
    if [ $# -ne 1 ]
    then
        errcho "Usage: download_last_video_from_youtube_channel YOUTUBE_USER"
        return 1
    fi

    URL="https://www.youtube.com/user"
    USER="$1"
    URL="$URL/$USER/videos"

    VIDEO_PATH=~"/video/youtube/$USER"

    [[ ! -e "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl "$URL" --max-downloads 1 -o "$VIDEO_PATH/%(title)s.%(ext)s"
}

function download_last_video_from_youtube_channel_as_mp3()
{
    if [ $# -ne 1 ]
    then
        errcho "Usage: download_last_video_from_youtube_channel_as_mp3 YOUTUBE_USER"
        return 1
    fi

    URL="https://www.youtube.com/user"
    USER="$1"
    URL="$URL/$USER/videos"

    VIDEO_PATH=~"/video/youtube/$USER"

    [[ ! -e "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl\
        --extract-audio\
        --audio-format mp3\
        --audio-quality 0\
        "$URL"\
        --max-downloads 1\
        -o "$VIDEO_PATH/%(title)s.%(ext)s"
}

function download_all_videos_from_youtube_channel()
{
    if [ $# -ne 1 ]
    then
        errcho "Usage: download_all_videos_from_youtube_channel YOUTUBE_USER"
        return 1
    fi

    URL="https://www.youtube.com/user"
    USER="$1"
    URL="$URL/$USER/videos"

    VIDEO_PATH=~"/video/youtube/$USER"

    [[ ! -e "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl "$URL" -o "$VIDEO_PATH/%(title)s.%(ext)s"
}

function download_first_video_from_youtube_search()
{
    if [ $# -ne 1 ]
    then
        errcho "Usage: download_first_video_from_youtube_search SEARCH"
        return 1
    fi

    URL="https://www.youtube.com"
    SEARCH="$1"

    VIDEO_PATH=~"/video/youtube/$SEARCH"

    [[ ! -e "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl\
        "ytsearch1: $SEARCH"\
        -o "$VIDEO_PATH/%(title)s.%(ext)s"\
        --max-downloads 1
}
