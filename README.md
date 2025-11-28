# Neovim Python & ML Setup (Cyberdream Theme)

Cross-platform (Windows + Linux) developer setup focused on Python / ML, JSON/YAML/TOML, testing, debugging, and GitHub Copilot with automated tool installation. Theme: `cyberdream`.

## 1. Install Neovim

Windows (PowerShell):

```
winget install Neovim.Neovim
```

Linux (Debian/Ubuntu):

```
sudo apt update
sudo apt install -y neovim
```

Fedora/RHEL:

```
sudo dnf install -y neovim
```

Arch:

```
sudo pacman -S neovim
```

## 2. System Dependencies

Debian/Ubuntu:

```
sudo apt install -y git curl build-essential ripgrep fd-find python3 python3-venv python3-pip nodejs npm
```

Fedora:

```
sudo dnf install -y git curl @development-tools ripgrep fd-find python3 python3-virtualenv python3-pip nodejs npm
```

Windows (PowerShell):

```
winget install Git.Git
winget install BurntSushi.ripgrep.MSVC
winget install Sharkdp.fd
winget install OpenJS.NodeJS
```

Ensure Python & Node:

```
python -V
node -v
```

Node >= 18 recommended for Copilot.

## 3. Clone / Sync Config

Linux:

```
mkdir -p ~/.config
cp -r /path/to/this/nvim ~/.config/nvim
```

Windows default location already at `%LOCALAPPDATA%/nvim`.
To sync from Linux to Windows or vice versa, copy entire directory.

## 4. First Launch

Open Neovim:

```
nvim
```

Lazy.nvim will auto install plugins. Close and reopen Neovim after initial sync if needed.

## 5. Python Tooling (Automated)

Mason auto-installs dev tools (black, isort, ruff, debugpy, mypy, jq, stylua, yamlfmt, mdformat). No need to pip install them in every conda env.

Just open Neovim and wait for Mason Tool Installer to finish (background). Check with:

```bash
:Mason
```

You only need per-project packages (numpy, pandas, etc.) inside each project environment.

Create/select environment:

```bash
conda create -n myproj python=3.11
conda activate myproj
pip install numpy pandas scipy scikit-learn matplotlib seaborn jupyter ipython pytest
```

In Neovim run:

```bash
:VenvSelect
```

This binds LSP, formatting, debug to that environment while global tools stay managed by Mason.

## 6. Key Feature Summary

- LSP: pyright, ruff, lua, json (SchemaStore), yaml, docker, markdown, toml.
- Formatting pipeline: `ruff_fix` + `ruff_format` then fallback to `black`/`isort`. Trigger with `<leader>cf`.
- Testing: `neotest` `<leader>tt` (nearest), `<leader>tf` (file), `<leader>ts` summary.
- Debugging: F5/F10/F11/F12, `<leader>db` breakpoint, `<leader>du` DAP UI.
- Copilot: `<C-J>` to accept.
- REPL / Cells: `<leader>rr` selection, `<leader>rs` line, `<leader>rf` file, `<leader>rc` close.
- Venv: `:VenvSelect` (`<leader>cv`).
- Theme: Cyberdream auto-loaded.

## 7. Common Leader Shortcuts

- Files: `<leader>ff` find, `<leader>fg` grep.
- LSP: `gd` definition, `gr` references, `K` hover, `<leader>rn` rename, `<leader>ca` code action.
- Diagnostics: `[d` / `]d` previous/next, `<leader>e` float.

## 8. Updating

Treesitter parsers:

```bash
:TSUpdate
```

Plugins (lazy):

```bash
:Lazy sync
```

Mason tools:

```bash
:Mason
```

## 9. Troubleshooting

- Tools missing: open `:Mason` and ensure Mason Tool Installer finished. Run `:MasonToolsUpdate` if needed.
- Copilot auth: `:Copilot setup`.
- Python path: verify `:VenvSelect` or `:echo exepath('python3')`.
- Formatting order: ruff fix/format then black/isort. Disable ruff formatting by removing its entries in `plugins/lsp.lua` conform config.

## 10. Extending

Add new plugin spec file under `lua/plugins/*.lua` returning a table of specs. Lazy auto-loads these.

---

Enjoy your cross-platform automated Neovim ML/Python setup!
