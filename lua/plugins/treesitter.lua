return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'elixir' },
        auto_install = false,

        highlight = { enable = true },
        indent = { enable = true },

        -- incremental selection: start with <C-space>, grow with repeated <C-space>
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },

        -- textobjects: select, move between, and swap functions/classes/parameters
        textobjects = {
          select = {
            enable = true,
            -- jump forward to the textobject automatically (like targets.vim)
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@class.outer',
              [']]'] = '@function.outer',
            },
            goto_next_end = {
              [']M'] = '@class.outer',
              [']['] = '@function.outer',
            },
            goto_previous_start = {
              ['[m'] = '@class.outer',
              ['[['] = '@function.outer',
            },
            goto_previous_end = {
              ['[M'] = '@class.outer',
              ['[]'] = '@function.outer',
            },
          },
          swap = {
            enable = true,
            -- swap function parameters with <leader>a / <leader>A
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },
}
