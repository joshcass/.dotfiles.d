# Git
abbr -ag gc git checkout
abbr -ag gb git branch
abbr -ag gs git status
abbr -ag gd git diff
abbr -ag ga git add
abbr -ag gh git hist
abbr -ag gf git fetch
abbr -ag gm git merge
abbr -ag gka git commit -a
abbr -ag gk git commit
abbr -ag gp git better-push
abbr -ag gl git log
abbr -ag gu git unwip
abbr -ag gr git reflog

# Shell
abbr -ag -- - 'cd -'
abbr -ag dev cd ~/dev
abbr -ag cdr cd '(git rev-parse --show-toplevel)'
abbr -ag ... cd ../..
abbr -ag .... cd ../../..
abbr -ag emr systemctl restart --user emacs
abbr -ag ems systemctl status --user emacs
abbr -ag dotfiles cd $DOTFILES

# Ruby/Rails
abbr -ag rs rspec
abbr -ag c rails c
abbr -ag ss spring stop
abbr -ag mg 'rails db:migrate db:rollback && rake db:migrate db:test:prepare'
abbr -ag be bundle exec
abbr -ag bn bundle
abbr -ag cu cucumber
