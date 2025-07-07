# Source Pure prompt defaults
source $HOME/.dotfiles.d/conf.d/config/fish/functions/pure/conf.d/pure.fish

# Pure prompt default overrides
# Base colors
set --universal pure_color_secondary magenta
set --universal pure_color_success green

# Git
set --universal pure_color_git_unpulled_commits pure_color_secondary
set --universal pure_color_git_unpushed_commits pure_color_secondary
set --universal pure_color_git_branch pure_color_info
set --universal pure_color_git_dirty pure_color_danger
set --universal pure_color_git_stash pure_color_warning

# Show system time
set --universal pure_show_system_time true
set --universal pure_color_system_time pure_color_warning
