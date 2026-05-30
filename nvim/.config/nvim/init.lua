--===========================
-- Set <space> as the leader key
-- See `:h mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.have_nerd_font = true

-- OPTIONS
-- See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:h option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

vim.o.number = true -- Show line numbers in a column.
vim.o.showmode = true

-- Show line numbers relative to where the cursor is.
-- Affects the 'number' option above, see `:h number_relativenumber`.
vim.o.relativenumber = true

vim.o.mouse = 'n'

vim.o.undofile = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UIEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:h 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 10 -- Keep this many screen lines above/below the cursor.
vim.o.list = true -- Show <tab> and trailing spaces.

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true

-- KEYMAPS
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- vim.keymap.set('n', '<Esc>', '<cmd>hlsearch<CR>')
-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')



vim.o.splitright = true
-- AUTOCOMMANDS (EVENT HANDLERS)
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`


-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- USER COMMANDS: DEFINE CUSTOM COMMANDS
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print the git blame for the current line' })


-- Lazy.nvim setup
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require('lazy').setup('plugins', {
  -- You can add lazy.nvim options here if needed
  -- For example:
  -- defaults = { lazy = true },
  -- install = { colorscheme = { 'habamax' } },
  -- checker = { enabled = true }, -- automatically check for plugin updates
  -- performance = {
  --   rtp = {
  --     -- disable some builtin plugins when using lazy.nvim
  --     disabled_plugins = {
  --       'gzip',
  --       'matchit',
  --       'matchparen',
  --       'netrwPlugin',
  --       'tarPlugin',
  --       'tohtml',
  --       'tutor',
  --       'zipPlugin',
  --     },
  --   },
  -- },
})
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- nvim-tree
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {
      noremap = true,
      silent = true,
      desc = "Toggle file tree",
    })
    -- fzf-lua
    vim.keymap.set('n', '<leader>ff', require('fzf-lua').files,           { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', require('fzf-lua').live_grep,       { desc = 'Grep project' })
    vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers,         { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader><leader>', require('fzf-lua').buffers,   { desc = 'Switch buffer' })
    vim.keymap.set('n', '<leader>fh', require('fzf-lua').helptags,        { desc = 'Find help' })
    vim.keymap.set('n', '<leader>fc', require('fzf-lua').command_history, { desc = 'Command history' })

    -- gitsigns
    vim.keymap.set('n', ']c', require('gitsigns').next_hunk,     { desc = 'Next hunk' })
    vim.keymap.set('n', '[c', require('gitsigns').prev_hunk,     { desc = 'Prev hunk' })
    vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { desc = 'Preview hunk' })
    vim.keymap.set('n', '<leader>hb', require('gitsigns').blame_line,   { desc = 'Blame line' })
    vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk<CR>',       { desc = 'Stage hunk' })
    vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>',       { desc = 'Reset hunk' })

    -- diagnostics
    vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,         { desc = 'Previous diagnostic' })
    vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,         { desc = 'Next diagnostic' })
    vim.keymap.set('n', '<leader>dl', vim.diagnostic.open_float,        { desc = 'Show diagnostic' })

    -- split
    vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split vertical' })
    vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = 'Split horizontal' })
    vim.keymap.set('n', '<leader>wc', '<C-w>c', { desc = 'Close window' })

    -- nvim-dap debugging
    vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
    vim.keymap.set('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Conditional breakpoint' })
    vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Continue' })
    vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = 'Step into' })
    vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end, { desc = 'Step out' })
    vim.keymap.set('n', '<leader>ds', function() require('dap').step_over() end, { desc = 'Step over' })
    vim.keymap.set('n', '<leader>dt', function() require('dapui').toggle() end, { desc = 'Toggle DAP UI' })
    vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'Open REPL' })

    vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Continue' })
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'Step over' })
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'Step into' })
    vim.keymap.set('n', '<S-F11>', function() require('dap').step_out() end, { desc = 'Step out' })
    vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
  end,
})

-- The rest of your configuration (keymaps, options, etc.) goes here.

-- LSP diagnostic settings
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 200
vim.opt.showcmd = true

--1. basic config
--===========================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

--==========================
--2. key mapping
--==========================
vim.keymap.set('i','jk','<Esc>',{noremap=true, silent=true})
vim.keymap.set('n','<C-s>',':w<CR>',{noremap=true, silent=true})
vim.keymap.set('n','<C-j>','5j',{noremap=true, silent=true})
vim.keymap.set('n','<C-k>','5k',{noremap=true, silent=true})

--==========================
--3. folding (treesitter, Neovim built-in)
--==========================
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
  end,
})
vim.o.foldlevel = 99

--==========================
--4. indent like VS Code (Tab/Shift+Tab in visual mode)
--==========================
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent and reselect' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Dedent and reselect' })

--==========================
--5. toggle comment (Ctrl+/) like VS Code
--==========================
vim.keymap.set('n', '<C-/>', 'gcc', { remap = true, desc = 'Toggle comment line' })
vim.keymap.set('v', '<C-/>', 'gc',  { remap = true, desc = 'Toggle comment selection' })
