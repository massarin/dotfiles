# Sourced by .zshrc and .bashrc; local.sh (untracked) holds secrets and machine overrides
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
for f in ~/.shell/*.sh; do
    [ "$f" != ~/.shell/init.sh ] && source "$f"
done
