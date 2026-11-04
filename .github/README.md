# dotfiles

Some files in my HOME.

- [`CLAUDE.md`](https://raw.githubusercontent.com/massarin/dotfiles/refs/heads/main/.claude/CLAUDE.md)
- `.zshrc` and `.bashrc` source every `.shell/*.sh`
- keep secrets and per-machine settings in a `.shell/*.sh` file excluded by `.gitignore`.


> [!NOTE]
> On macOS, the Keychain via `security` keeps keys encrypted instead of in a plaintext file
> on other Unix systems use [`pass`](https://www.passwordstore.org/).

Store a key (prompts for it, so it stays out of shell history):

```zsh
security add-generic-password -s openai -a "$USER" -w
```

Load it in `.shell/local.sh`:

```zsh
export OPENAI_API_KEY=$(security find-generic-password -s openai -w)
```
