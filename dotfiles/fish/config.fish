# terminal-wakatime setup
set -gx PATH "$HOME/.wakatime" $PATH
terminal-wakatime init fish | source

# runs hyfetch at the start of interactive shells
if status is-interactive
    hyfetch
end

set -g fish_greeting
