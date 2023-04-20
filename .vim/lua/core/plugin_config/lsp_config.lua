require('mason').setup({})

require('mason-lspconfig').setup({
  ensure_installed = {},
})

local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  --
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'H', '<cmd>Lspsaga hover_doc<CR>', bufopts)
  vim.keymap.set('n', 'K', '<cmd>Lspsaga peek_definition<CR>', bufopts)
  vim.keymap.set('n', 'L', '<cmd>Lspsaga lsp_finder<CR>', bufopts)
  vim.keymap.set('n', '<Space>', '<cmd>Lspsaga code_action<CR>', bufopts)
end

-- See https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
lspconfig.bashls.setup({ on_attach = on_attach })
lspconfig.cssls.setup({ on_attach = on_attach })
lspconfig.cucumber_language_server.setup({ on_attach = on_attach })
lspconfig.dockerls.setup({ on_attach = on_attach })
lspconfig.graphql.setup({ on_attach = on_attach })
-- lspconfig.denols.setup { on_attach = on_attach }
lspconfig.html.setup({ on_attach = on_attach })
lspconfig.jsonls.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.ruby_ls.setup({ on_attach = on_attach })
lspconfig.theme_check.setup({ on_attach = on_attach, root_dir = lspconfig.util.find_git_ancestor })
lspconfig.tailwindcss.setup({ on_attach = on_attach })
lspconfig.tsserver.setup({ on_attach = on_attach })
lspconfig.vimls.setup({ on_attach = on_attach })
lspconfig.yamlls.setup({ on_attach = on_attach })

require('lspsaga').setup({
  symbol_in_winbar = {
    enable = false,
  },
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = false,
    virtual_text = true,
  },
})
