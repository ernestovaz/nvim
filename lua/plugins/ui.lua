return {
  {
    -- colorscheme (loaded first via priority 1000)
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            CursorLineSign = { fg = colors.flamingo },
          }
        end,
      })
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    -- breadcrumb navigation bar (shows current code context via LSP)
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',
    opts = {
      lsp = {
        auto_attach = true,
      },
    },
  },

  {
    -- statusline with navic breadcrumbs in section x
    'nvim-lualine/lualine.nvim',
    dependencies = 'SmiteshP/nvim-navic',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_x = { { "navic" } },
      },
    },
  },

  {
    -- indentation guides on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '┊',
      },
      whitespace = {
        remove_blankline_trail = true,
      },
    },
  },

  {
    -- highlight current line and line number after brief pause
    'ya2s/nvim-cursorline',
    opts = {
      cursorline = {
        enable = true,
        number = true,
        timeout = 200,
      },
    },
  },

  {
    -- popup showing available keybindings as you type
    'folke/which-key.nvim',
    opts = {
      delay = 2000,
    },
  },

  {
    -- distraction-free writing mode
    'folke/zen-mode.nvim',
    opts = {
      plugins = {
        options = {},
      },
    },
  },
}
