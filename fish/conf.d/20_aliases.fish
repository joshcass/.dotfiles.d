alias pbcopy='xsel --clipboard --input'
alias G="rg -i"
alias aset="asdf"
alias tf="terraform"
alias yay="paru"

alias nodebuild="asdf nodejs nodebuild"

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

alias awslocal="AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test AWS_DEFAULT_REGION=us-east-1 aws --endpoint-url=http://127.0.0.1:4566"
