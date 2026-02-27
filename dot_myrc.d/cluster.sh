_cluster() { python3 "$HOME/dotfiles/bin/cluster" "$@"; }

# PTY and start only make sense on the cluster (srun required)
if command -v srun &>/dev/null; then
    myjob()            { _cluster pty "$@"; }
    start_remote_dev() { _cluster start "$@"; }
fi

# connect runs locally (no srun needed)
remotedev() { _cluster connect "$@"; }
