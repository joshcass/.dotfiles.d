# Take you to the dir of a file in a gem. e.g. `2gem rspec`
function 2gem
    cd (dirname (gem which $argv))
end
