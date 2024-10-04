#!/usr/bin/env fish

function docker
    if [ $argv[1] = compose ]
        command docker-compose $argv[2..-1]
    else
        command docker $argv
    end
end
