# chezmoi

Minimal dotfiles managed with [chezmoi](https://chezmoi.io), shared across macOS and Linux/cluster.

## Install

```bash
git clone https://github.com/massarin/chezmoi.git ~/.local/share/chezmoi
~/.local/share/chezmoi/install.sh
```

Installs chezmoi if absent, then applies all dotfiles. On first run it prompts:
- **Is this a cluster/HPC machine?** — enables SLURM functions, skips macOS-specific config
- **Cluster SSH hostname** (local only) — defaults to `lam`

Re-apply after changes:
```bash
chezmoi apply
```

## Structure

```
dot_myrc              → ~/.myrc          (sources all of .myrc.d/)
dot_myrc.d/
  aliases.sh          shell aliases
  venv.sh             avenv / mkvenv
  utils.sh            file_info
  cluster.sh          myjob / remotedev wrappers
bin/cluster           cluster session manager (Python)
dot_zshrc.tmpl        → ~/.zshrc
dot_bashrc.tmpl       → ~/.bashrc
```

## Editing

**Add an alias or function** — edit the relevant file in `dot_myrc.d/`:
```bash
$EDITOR ~/.local/share/chezmoi/dot_myrc.d/aliases.sh
chezmoi apply   # or just: source ~/.myrc
```

**Add a new topic** — create `dot_myrc.d/mytopic.sh`; it's sourced automatically.

**Shell RC changes** (PATH, env vars) — edit `dot_zshrc.tmpl` or `dot_bashrc.tmpl`.
Use `{{ if .isCluster }}...{{ end }}` for cluster-only blocks.

## Cluster

```bash
remotedev jupyter          # start (or reuse) Jupyter on a compute node + tunnel
remotedev vscode           # same for VS Code
remotedev --new jupyter    # force a new session
myjob                      # interactive PTY session (srun --pty bash)
myjob --gpu                # with GPU (default: a40:1)
myjob --gpu a100:2 32 8    # GPU type:count, 32 cores, 8h
```

Sessions are reused by default via `~/.remotedev/<type>.json`.
Override cluster host: `CLUSTER_HOST=myhost remotedev jupyter`
