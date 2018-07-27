#!/bin/bash

# checks to see where the repo came from and sets
# the email accordingly

remote=`git remote -v | awk '/\(push\)$/ {print $2}'`
email=hello@joshcass.com # default

if [[ $remote == *github.com:bonusly* ]]; then
    email=josh@bonus.ly
fi

echo "Configuring user.email as $email"
git config user.email $email
