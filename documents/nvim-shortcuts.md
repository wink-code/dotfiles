# Neovim Shortcuts

Leader key: `<Space>`

## General

| Key | Mode | Description |
|-----|------|-------------|
| `jk` | Insert | Exit to normal mode |
| `<C-s>` | Normal | Save file |
| `<C-j>` | Normal | 5 lines down |
| `<C-k>` | Normal | 5 lines up |
| `<Esc>` | Terminal | Exit terminal mode |

## Window / Split

| Key | Description |
|-----|-------------|
| `Alt+h/j/k/l` | Navigate between windows |
| `<leader>wv` | Split vertical |
| `<leader>ws` | Split horizontal |
| `<leader>wc` | Close current window |

## File Navigation

| Key | Description |
|-----|-------------|
| `<leader>e` | Toggle nvim-tree (file tree) |
| `<leader>ff` | Fzf-Lua: find files |
| `<leader>fg` | Fzf-Lua: live grep |
| `<leader>fb` | Fzf-Lua: buffers |
| `<leader>fh` | Fzf-Lua: help tags |
| `<leader>fc` | Fzf-Lua: command history |
| `]b` | Next buffer (bufferline) |
| `[b` | Previous buffer (bufferline) |
| `<leader>bp` | Pick buffer (bufferline) |
| `<leader>bq` | Close buffer |

## Quick Jump (Flash)

| Key | Mode | Description |
|-----|------|-------------|
| `s` | Normal/Visual/Operator | Search + label jump |
| `S` | Normal/Visual/Operator | Treesitter-aware jump |
| `r` | Operator-pending | Remote flash |
| `R` | Operator-pending/Visual | Treesitter search |

## Harpoon (Bookmark Files)

| Key | Description |
|-----|-------------|
| `<leader>a` | Add current file to marks |
| `<leader>m` | Toggle quick menu |
| `<leader>1` ~ `<leader>4` | Jump to marked file 1–4 |

## Editing

| Key | Mode | Description |
|-----|------|-------------|
| `<C-/>` | Normal/Visual | Toggle comment (language-aware) |
| `<Tab>` | Visual | Indent and reselect |
| `<S-Tab>` | Visual | Dedent and reselect |
| `<leader>cf` | Normal | Format code (conform.nvim + ruff) |

## Folding (Treesitter)

| Key | Description |
|-----|-------------|
| `zc` | Close fold |
| `zo` | Open fold |
| `za` | Toggle fold |
| `zM` | Close all folds |
| `zR` | Open all folds |
| `zj` / `zk` | Jump to next / previous fold |

## LSP (Python via pyright)

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gs` | Document symbols |
| `K` | Hover info |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |

## Git (gitsigns)

| Key | Description |
|-----|-------------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |

## Diagnostics

| Key | Description |
|-----|-------------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>dl` | Show diagnostic detail |
