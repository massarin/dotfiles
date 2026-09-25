# dotfiles

My home directory is the repo: `~/.git`, with `~/.gitignore` as an allowlist. Syncing is `git pull` / `git commit` / `git push` from `~`.

Check out my [`AGENTS.md`](https://raw.githubusercontent.com/massarin/dotfiles/refs/heads/main/.config/opencode/AGENTS.md)

## Install

```bash
cd ~
git init -b main
git remote add origin git@github.com:massarin/dotfiles.git
git fetch origin
git reset --hard origin/main   # overwrites tracked files already in ~, back them up first
git branch -u origin/main
```

Then put secrets in `~/.shell/local.sh` (untracked), e.g. `export GITHUB_TOKEN=...`.

## Layout

```
.zshrc  .bashrc             shell-specific hooks, then source .shell/init.sh
.shell/init.sh              PATH, then sources every .shell/*.sh
.shell/aliases.sh           aliases
.shell/venv.sh              avenv / mkvenv
.shell/utils.sh             file_info, lazygit, wgetpdf
.shell/cluster.sh           myjob / remotedev / srun_lam, srun-only parts guarded by command -v
.shell/local.sh             untracked: secrets and machine overrides
bin/cluster                 cluster session manager (Python)
.config/opencode/AGENTS.md  global agent instructions
.config/opencode/agents/    subagents, shared with Claude Code
.config/opencode/skills/    skills, shared with Claude Code
.claude/{CLAUDE.md,agents,skills}   committed symlinks into .config/opencode
```

## Rules

- New file to track: add a `!path` line to `~/.gitignore`, otherwise git ignores it silently.
- Agent frontmatter: no `tools:` line, opencode v2 rejects the agent: restrict via opencode `permissions:` instead.
- `settings.json` / `opencode.json` stay per machine, untracked: schemas differ between CLIs.
- Any dir under `~` without its own `.git` resolves to this repo: run `git init` in new projects.

## Cluster

```bash
remotedev jupyter          # start (or reuse) Jupyter on a compute node + tunnel
remotedev vscode           # same for VS Code
remotedev --new jupyter    # force a new session
myjob                      # interactive PTY session (srun --pty bash)
myjob --gpu                # with GPU (default: a40:1)
myjob --gpu a100:2 32 8    # GPU type:count, 32 cores, 8h
```

Sessions are reused via `~/.remotedev/<type>.json`. Override host: `CLUSTER_HOST=myhost remotedev jupyter`
