function pyon --wraps='set -U tide_right_prompt_items python cmd_duration; tide reload' --wraps='set -U tide_right_prompt_items python rust go node cmd_duration; tide reload' --description 'alias pyon=set -U tide_right_prompt_items python cmd_duration; tide reload'
    set -U tide_right_prompt_items python cmd_duration; tide reload $argv
end
