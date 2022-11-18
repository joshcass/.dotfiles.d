set --global pure_version 4.3.1 # For bug report and tag-after-merge workflow

# Base colors
set --universal pure_color_primary blue
set --universal pure_color_secondary magenta
set --universal pure_color_info cyan
set --universal pure_color_mute brblack
set --universal pure_color_success green
set --universal pure_color_normal normal
set --universal pure_color_danger red
set --universal pure_color_light white
set --universal pure_color_warning yellow
set --universal pure_color_dark black

# Prompt
set --universal pure_symbol_prompt "❯"
set --universal pure_symbol_reverse_prompt "❮" # used for VI mode
set --universal pure_color_prompt_on_error pure_color_danger
set --universal pure_color_prompt_on_success pure_color_success

# Current Working Directory
set --universal pure_color_current_directory pure_color_primary

# Git
set --universal pure_enable_git true
set --universal pure_symbol_git_unpulled_commits "⇣"
set --universal pure_symbol_git_unpushed_commits "⇡"
set --universal pure_symbol_git_dirty "*"
set --universal pure_symbol_git_stash "≡"
set --universal pure_color_git_unpulled_commits pure_color_secondary
set --universal pure_color_git_unpushed_commits pure_color_secondary
set --universal pure_color_git_branch pure_color_info
set --universal pure_color_git_dirty pure_color_danger
set --universal pure_color_git_stash pure_color_warning

# Remote info (user@hostname) for SSH and containers (Docker/LXC)
set --universal pure_color_hostname pure_color_mute
set --universal pure_color_at_sign pure_color_mute
set --universal pure_color_username_normal pure_color_mute
set --universal pure_color_username_root pure_color_light

# Number of running jobs
set --universal pure_show_jobs false
set --universal pure_color_jobs pure_color_normal

# Show system time
set --universal pure_show_system_time true
set --universal pure_color_system_time pure_color_warning

# Virtualenv for Python
set --universal pure_color_virtualenv pure_color_mute

# Print current working directory at the beginning of prompt
# true (default):   current directory, git, user@hostname (ssh-only), command duration
# false:            user@hostname (ssh-only), current directory, git, command duration
set --universal pure_begin_prompt_with_current_directory true

# Show exit code of last command as a separate prompt character (cf. https://github.com/sindresorhus/pure/wiki#show-exit-code-of-last-command-as-a-separate-prompt-character)
# false - single prompt character, default
# true - separate prompt character
set --universal pure_separate_prompt_on_error false

# Max execution time of a process before its run time is shown when it exits
set --universal pure_threshold_command_duration 5
set --universal pure_show_subsecond_command_duration false
set --universal pure_color_command_duration pure_color_warning

# VI mode indicator
# true (default):  indicate a non-insert mode by reversing the prompt symbol (❮)
# false:           indicate vi mode with [I], [N], [V]
set --universal pure_reverse_prompt_symbol_in_vimode true

# Title
set --universal pure_symbol_title_bar_separator -

# Check for new release on startup
set --universal pure_check_for_new_release false

# Prefix prompt when logged in as root
set --universal pure_show_prefix_root_prompt false
set --universal pure_symbol_prefix_root_prompt "#"
set --universal pure_color_prefix_root_prompt pure_color_danger

# Compact mode
set --universal pure_enable_single_line_prompt false

# Detect when running in container (e.g. docker, podman, LXC/LXD)
set --universal pure_enable_container_detection true
