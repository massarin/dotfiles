export PATH="$HOME/.local/bin:$PATH"

# Source every *.sh in ~/.shell, gitignored ones too (secrets, per-machine settings)
for f in ~/.shell/*.sh; do source "$f"; done

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/Users/loco/.juliaup/bin:*)
        ;;

    *)
        export PATH=/Users/loco/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac
# Tab completion for juliaup and julia channel selection
[ -f "/Users/loco/.julia/juliaup/completions/bash.sh" ] && source "/Users/loco/.julia/juliaup/completions/bash.sh"

# <<< juliaup initialize <<<
