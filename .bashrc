export PATH="$HOME/.local/bin:$PATH"

# Source every *.sh in ~/.shell, gitignored ones too (secrets, per-machine settings)
for f in ~/.shell/*.sh; do source "$f"; done

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:"${HOME}/.juliaup/bin":*)
        ;;

    *)
        export PATH="${HOME}/.juliaup/bin"${PATH:+:${PATH}}
        ;;
esac
# Tab completion for juliaup and julia channel selection
[ -f "${HOME}/.julia/juliaup/completions/bash.sh" ] && source "${HOME}/.julia/juliaup/completions/bash.sh"

# <<< juliaup initialize <<<
