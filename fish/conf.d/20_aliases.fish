# Shell aliases
alias pbcopy='xsel --clipboard --input'
alias m="emacsclient -c -n"
alias mm="emacsclient -c -n ."
alias say="spd-say"
alias grep="grep --color=auto"
# alias -g G="| grep -i"

# fancy ls commands
# -l  long format
# -F  / after dirs, * after exe, @ after symlink
# -g suppress owner
# -o suppress group
# -h humanize sizes
# -q print nongraphic chars as question marks
alias ll="ls -lFhqa --color=auto"
alias ls="ls -Fh --color=auto"
alias la="ls -Fha --color=auto"
