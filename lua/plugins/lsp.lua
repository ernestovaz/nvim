return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      -- lsp progress indicator in the bottom right
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      -- better lua_ls integration for neovim config/api
      'folke/neodev.nvim',
    },
    config = function()
      -- neodev must be set up before lspconfig so lua_ls picks up neovim types
      require('neodev').setup()

      -----------------------------------------------------------
      -- on_attach: keymaps that only activate when an LSP is connected
      -----------------------------------------------------------
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- refactoring
        nmap('<leader>rn', vim.lsp.buf.rename, 'rename')
        nmap('<leader>ca', vim.lsp.buf.code_action, 'code action')

        -- navigation
        nmap('gd', vim.lsp.buf.definition, 'goto definition')
        nmap('gr', require('telescope.builtin').lsp_references, 'goto references')
        nmap('gI', vim.lsp.buf.implementation, 'goto implementation')
        nmap('gD', vim.lsp.buf.declaration, 'goto declaration')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'type definition')

        -- symbols
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'document symbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'workspace symbols')

        -- documentation
        nmap('<C-m>', vim.lsp.buf.hover, 'hover documentation')
        nmap('<C-S-S>', vim.lsp.buf.signature_help, 'signature documentation')

        -- workspace management
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'workspace add folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'workspace remove folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'workspace list folders')

        -- buffer-local :Format command
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'format current buffer with LSP' })
      end

      -----------------------------------------------------------
      -- servers: add entries here to auto-install via mason
      -----------------------------------------------------------
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- tsserver = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      -----------------------------------------------------------
      -- capabilities & mason: wire everything together
      -----------------------------------------------------------
      -- broadcast nvim-cmp's additional completion capabilities to all servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          }
        end,
      }
    end,
  },
}
