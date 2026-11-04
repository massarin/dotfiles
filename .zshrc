# Source every *.sh in ~/.shell, gitignored ones too (secrets, per-machine settings)
for f in ~/.shell/*.sh; do source "$f"; done

export PATH="$HOME/.local/bin:$PATH"
eval "$(direnv hook zsh)"


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

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/loco/.juliaup/bin' $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "/Users/loco/.julia/juliaup/completions/zsh.zsh" ] && source "/Users/loco/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<
