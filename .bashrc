[ -f ~/.shell/init.sh ] && source ~/.shell/init.sh

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
