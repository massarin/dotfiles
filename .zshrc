# Colorful ls on mac
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/loco/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/loco/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/loco/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/loco/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(direnv hook zsh)"
[ -f ~/.shell/init.sh ] && source ~/.shell/init.sh
