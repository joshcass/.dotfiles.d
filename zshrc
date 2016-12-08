###################### Aliases ##############################

# Bash aliases
alias dev="cd ~/dev"
alias study="cd ~/dev/2_study"
alias projects="cd ~/dev/1_projects"
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias wings="pmset noidle"
alias m="macs"
alias mm="macs ."

# Git aliases
alias gc="git checkout"
alias gb="git branch"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gh="git hist"
alias gf="git fetch"
alias gm="git merge"
alias gka="git commit -a"
alias gk="git commit"
alias gp="git push"
alias gl="git log"

# Ruby/Rails aliases
alias rt="rake test"
alias rs="rspec"
alias c="rails c"
alias ss="spring stop"
alias mg="rake db:migrate db:rollback && rake db:migrate db:test:prepare"
alias be="bundle exec"
alias bn="bundle"

# Elixir/Phoenix aliases
alias eli="elixir"

# fancy ls commands
# -l  long format
# -F  / after dirs, * after exe, @ after symlink
# -G  colorize
# -g suppress owner
# -o suppress group
# -h humanize sizes
# -q print nongraphic chars as question marks
alias l="ls -lFGgohq"
alias ls="ls -GFh"
alias la="ls -GFha"

####################### Prompt ##############################

# Determinte current branch if there is one
function parse_git_branch {
    branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    if [ "HEAD" = "$branch" ]; then
        echo "(no branch)"
    else
        echo "$branch"
    fi
}

# Determine branch state and return the appropriate color
# background and foreground versions
# array is (background_color foreground_color)
function parse_git_color {
    gstatus=`git status 2>/dev/null`
    if [[ $gstatus = "" ]]; then
        GIT_COLOR=("m" "")
    elif [[ ! $gstatus =~ "working tree clean" ]]; then
        GIT_COLOR=("101m" "91m")
    elif [[ $gstatus =~ "Your branch is ahead of" ]]; then
        GIT_COLOR=("43m" "33m")
    elif [[ $gstatus =~ "nothing to commit" ]]; then
        GIT_COLOR=("42m" "32m")
    else
        GIT_COLOR=("error" "error")
    fi
}

# prompt segment separator character
SEPARATOR="\ue0b0"

# set the color for the git segment
function git_segment {
    git_bg=${GIT_COLOR[1]}
    git_fg=${GIT_COLOR[2]}

    if [[ ! -z "$1" ]]; then
        echo "%{\033[${2:-37};$git_bg%]${1}%}\033[0m%{\033[${2:-$git_fg}%]${SEPARATOR%}%}\033[0m%]"
    fi
}

function time_segment {
    if [[ ! -z "$1" ]]; then
        echo "%{\033[${2:-37};105m%]${1}%}\033[0m%{\033[${2:-95};46m%]${SEPARATOR%}%}\033[0m%]"
    fi
}

function cwd_segment {
    git_bg=${GIT_COLOR[1]}

    if [[ ! -z "$1" ]]; then
        echo "%{\033[${2:-37};46m%]${1}%}\033[0m%{\033[${2:-36};$git_bg%]${SEPARATOR}%}\033[0m%]"
    fi
}

# put it all together
function build_prompt {
    # parse the git color and set variable
    parse_git_color

    # time
    ps1="$(time_segment " %D{%I:%M %p} ")"

    # cwd
    ps1="${ps1}$(cwd_segment " %~ ")"

    # git branch
    git_branch=`parse_git_branch`
    if [[ ! -z "$git_branch" ]]
    then
        ps1="${ps1}$(git_segment " $git_branch ")"
    fi

    NEWLINE=$'\n'

    ps1="${ps1}${NEWLINE}"

    # emoji prompt
    ps1="${ps1}🍺  "

    # set prompt output
    PS1="$ps1"
}

precmd() { build_prompt; }
