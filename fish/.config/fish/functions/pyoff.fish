function pyoff --wraps='set -U tide_right_prompt_items cmd_duration; tide reload' --description 'alias pyoff=set -U tide_right_prompt_items cmd_duration; tide reload'
    set -U tide_right_prompt_items cmd_duration; tide reload $argv
end
