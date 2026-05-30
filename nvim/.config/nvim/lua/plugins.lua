return {
  {
    'nvim-lspconfig',
    lazy = false,
    config = function()
      -- LSP Configuration - pyright for Python files
      vim.lsp.config('pyright', {
        cmd = { vim.fn.expand('$HOME/.local/share/uv/tools/pyright/bin/pyright-langserver'), '--stdio' },
        filetypes = { 'python' },
        root_markers = { '.git', 'pyproject.toml', 'requirements.txt', '.venv' },
        settings = {
          python = {
            pythonPath = '.venv/bin/python',
          },
        },
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'python',
        callback = function()
          vim.lsp.enable('pyright')
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf

          vim.keymap.set('n', 'gd', vim.lsp.buf.definition,       { buffer = bufnr, desc = 'Go to definition' })
          vim.keymap.set('n', 'gr', vim.lsp.buf.references,       { buffer = bufnr, desc = 'Find references' })
          vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol,  { buffer = bufnr, desc = 'Document symbols' })
          vim.keymap.set('n', 'K',  vim.lsp.buf.hover,            { buffer = bufnr, desc = 'Hover' })

          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,               { buffer = bufnr, desc = 'Rename' })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,          { buffer = bufnr, desc = 'Code action' })
          vim.keymap.set('n', '<leader>dl', vim.diagnostic.open_float,        { buffer = bufnr, desc = 'Show diagnostic line' })
          vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,         { buffer = bufnr, desc = 'Previous diagnostic' })
          vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,         { buffer = bufnr, desc = 'Next diagnostic' })
        end,
      })
    end,
  },
  {
    'ibhagwan/fzf-lua',
    lazy = false,
    config = function()
      require('fzf-lua').setup({
        fzf_colors = true,
        keymap = {
          fzf = {
            ['ctrl-j'] = 'down',
            ['ctrl-k'] = 'up',
            ['down'] = 'down',
            ['up'] = 'up',
          },
        },
      })
    end,
  },
  {
    'nvim-mini/mini.completion',
    lazy = false,
    config = function()
      require('mini.completion').setup {}
    end,
  },
  {
    'stevearc/quicker.nvim',
    lazy = false,
    config = function()
      require('quicker').setup {}
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require('gitsigns').setup {}
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'sphamba/smear-cursor.nvim',
    lazy = false,
    config = function()
      require('smear_cursor').setup({
        -- when switching buffer
        smear_between_buffers = true,

        -- between lines
        smear_between_neighbor_lines = true,

        -- when scrolling buffers
        scroll_buffer_space = true,

        -- Set to true if your font supports legacy computing symbols (block unicode symbols).
        -- Smears will blend better on all backgrounds.
        legacy_computing_symbols_support = true,

        -- insert mode
        smear_insert_mode = false,

        -- 【性能优化】调整运动参数让拖尾更丝滑
        stiffness = 0.85,                    -- 头部移动速度 (默认0.6)
        trailing_stiffness = 0.6,           -- 尾部跟随速度 (默认0.45)
        damping = 0.9,                      -- 阻尼系数 (默认0.85)
        distance_stop_animating = 0.5,      -- 提前终止动画，避免长跳转拖尾
        trailing_exponent = 2.5,            -- 尾部分布指数 (默认3.0)

        -- 插入模式专用优化
        stiffness_insert_mode = 0.5,
        trailing_stiffness_insert_mode = 0.3,
        damping_insert_mode = 0.95,

        -- 视觉效果增强
        cursor_color = '#89ddff',           -- 鲜艳青蓝色
        color_levels = 20,                  -- 颜色渐变级别 (默认16)
        gamma = 2.0,                        -- 色彩伽马校正 (默认2.2)
        gradient_exponent = 1.1,            -- 纵向梯度指数 (默认1.0)
        max_length = 28,                    -- 最大拖尾长度 (默认25)

        -- 性能平衡
        time_interval = 15,                 -- 动画帧间隔毫秒 (默认17)
      })
    end,
  },
  -- File Tree Plugin
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- Optional: for file icons
    },
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 30,
          side = 'left',
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = true,
        },
      })
      vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { bg = 'none' })
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            flavour = 'mocha',
            transparent_background = true,
            term_colors = true
        })
        vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    'akinsho/bufferline.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('bufferline').setup({
            options = {
                mode = 'buffers',
                numbers = 'ordinal',
                close_command = 'bdelete! %d',
                right_mouse_command = 'bdelete! %d',
                diagnostics = 'nvim_lsp',
                offsets = {
                    { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' },
                },
            },
        })
        vim.keymap.set('n', ']b', ':BufferLineCycleNext<CR>', { desc = 'Next buffer' })
        vim.keymap.set('n', '[b', ':BufferLineCyclePrev<CR>', { desc = 'Prev buffer' })
        vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { desc = 'Pick buffer' })
        vim.keymap.set('n', '<leader>bq', ':bdelete<CR>', { desc = 'Close buffer' })
        vim.keymap.set('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', { desc = 'Buffer 1' })
        vim.keymap.set('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', { desc = 'Buffer 2' })
        vim.keymap.set('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', { desc = 'Buffer 3' })
        vim.keymap.set('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', { desc = 'Buffer 4' })
        vim.keymap.set('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', { desc = 'Buffer 5' })
        vim.keymap.set('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', { desc = 'Buffer 6' })
        vim.keymap.set('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', { desc = 'Buffer 7' })
        vim.keymap.set('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', { desc = 'Buffer 8' })
        vim.keymap.set('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', { desc = 'Buffer 9' })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('harpoon').setup({})
        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')
        vim.keymap.set('n', '<leader>a', function() mark.add_file() end, { desc = 'Harpoon add file' })
        vim.keymap.set('n', '<leader>m', function() ui.toggle_quick_menu() end, { desc = 'Harpoon menu' })
        vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end, { desc = 'Harpoon file 1' })
        vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end, { desc = 'Harpoon file 2' })
        vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end, { desc = 'Harpoon file 3' })
        vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end, { desc = 'Harpoon file 4' })
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        char = {
          enabled = true,
          jump_labels = true,
          keys = { 'f', 'F', 't', 'T', ';', ',' },
          label = { exclude = 'hjkliardc' },
        },
      },
    },
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install { 'python', 'lua', 'vim', 'bash', 'c', 'markdown' }
    end,
  },
  {
    'mfussenegger/nvim-lint',
    lazy = false,
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            sh = { 'shellcheck' },
            python = { 'ruff' },
        }
        vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
  },
  {
    'stevearc/conform.nvim',
    lazy = false,
    config = function()
        require('conform').setup({
            formatters_by_ft = {
                python = { 'ruff_format' },
            },
            format_on_save = false,
        })
        vim.keymap.set('n', '<leader>cf', function()
            require('conform').format({ async = true })
        end, { desc = 'Format code' })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    lazy = false,
    dependencies = {
      'mfussenegger/nvim-dap-python',
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
      },
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      require('dap-python').setup(vim.fn.expand('~/.local/bin/debugpy-adapter'))

      dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '--interpreter=dap', '--quiet' },
      }
      dap.configurations.c = {
        {
          name = 'Launch',
          type = 'gdb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtBeginningOfMain = true,
        },
      }
      dap.configurations.cpp = dap.configurations.c

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = 'scopes',      size = 0.25 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'stacks',      size = 0.25 },
              { id = 'watches',     size = 0.25 },
            },
            position = 'right',
            size = 40,
          },
          {
            elements = {
              { id = 'console', size = 1 },
            },
            position = 'bottom',
            size = 10,
          },
        },
      })
      vim.api.nvim_set_hl(0, 'DapUINormal', { bg = '#181825' })
      vim.api.nvim_set_hl(0, 'DapUIEndOfBuffer', { bg = '#181825' })

      require('nvim-dap-virtual-text').setup({ commented = true })

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      -- dap.listeners.before.event_terminated['dapui_config'] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited['dapui_config'] = function()
      --   dapui.close()
      -- end
    end,
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      require('auto-session').setup({
        log_level = 'error',
      })
    end,
  },
}
