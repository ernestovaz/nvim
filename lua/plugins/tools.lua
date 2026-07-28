return {
  {
    -- obsidian vault integration
    'obsidian-nvim/obsidian.nvim',
    opts = {
      lazy = true,
      workspaces = {
        {
          name = "vault",
          path = "~/vault",
        },
      },
      disable_frontmatter = true,
      ui = { enable = false },
    },
  },

  -- floating terminal window (:FloatermToggle)
  { 'voldikss/vim-floaterm' },

  -- live markdown preview in browser (:LivedownToggle)
  { 'shime/vim-livedown' },
}
