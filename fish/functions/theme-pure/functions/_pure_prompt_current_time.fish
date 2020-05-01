function _pure_prompt_current_time \
    --description 'Print current time'

    set --local time_color (_pure_set_color $pure_color_warning)
    set --local current_time (date +%H:%M)

    echo "$time_color$current_time"
end
