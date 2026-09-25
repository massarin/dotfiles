_cluster() { python3 "$HOME/bin/cluster" "$@"; }

# PTY and start only make sense on the cluster (srun required)
if command -v srun &>/dev/null; then
    myjob()            { _cluster pty "$@"; }
    start_remote_dev() { _cluster start "$@"; }
fi

# connect runs locally (no srun needed)
remotedev() { _cluster connect "$@"; }

# easy cli
srun_lam() {
  local cmd="bash"
  local cpus=16 gpus=0 mem="32G" time="02:00:00"

  while [[ $# -gt 0 ]]; do
    case $1 in
      -c|--cpus)  cpus=$2;  shift 2 ;;
      -g|--gpus)  gpus=$2;  shift 2 ;;
      -m|--mem)   mem=$2;   shift 2 ;;
      -t|--time)  time=$2;  shift 2 ;;
      *)          cmd="$*"; break   ;;
    esac
  done

  local gpu_flag=""
  [[ $gpus -gt 0 ]] && gpu_flag="--gres=gpu:$gpus"

  ssh -t lam "
    node=\$(squeue --me --noheader --format='%N' --states=RUNNING | head -1)
    if [[ -z \"\$node\" ]]; then
      echo 'No running allocation, requesting one...'
      node=\$(salloc --no-shell --cpus-per-task=$cpus $gpu_flag --mem=$mem --time=$time 2>&1 | grep -oP 'node\K\S+' | head -1)
    fi
    echo \"Jumping to \$node\"
    ssh -t \"\$node\" 'cd $(pwd) && $cmd'
  "
}
