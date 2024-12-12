require('mason').setup({})

require('mason-lspconfig').setup({
  ensure_installed = {},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  --
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'H', '<cmd>Lspsaga hover_doc<CR>', bufopts)
  vim.keymap.set('n', 'K', '<cmd>Lspsaga peek_type_definition<CR>', bufopts)
  vim.keymap.set('n', 'L', '<cmd>Lspsaga peek_definition<CR>', bufopts)
  vim.keymap.set('n', '<Space>', '<cmd>Lspsaga code_action<CR>', bufopts)

  vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', bufopts)
  vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', bufopts)

  -- Too noisy.
  -- vim.cmd([[
  --   autocmd CursorHold <buffer> lua require('lspsaga.diagnostic.show'):show_diagnostics({ line = true, args = { '++unfocus' } })
  -- ]])
end

-- See https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
lspconfig.astro.setup({ on_attach = on_attach })
lspconfig.bashls.setup({ on_attach = on_attach })
lspconfig.cssls.setup({
  on_attach = on_attach,
  settings = {
    css = {
      lint = {
        unknownAtRules = 'ignore',
      },
    },
  },
})
lspconfig.cucumber_language_server.setup({ on_attach = on_attach })
-- lspconfig.curlylint.setup({ on_attach = on_attach })
lspconfig.dockerls.setup({ on_attach = on_attach })
lspconfig.graphql.setup({ on_attach = on_attach })
lspconfig.denols.setup({
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
  single_file_support = false,
})
lspconfig.html.setup({ on_attach = on_attach })
lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.ruby_lsp.setup({ on_attach = on_attach })
lspconfig.theme_check.setup({ on_attach = on_attach, root_dir = lspconfig.util.find_git_ancestor })
lspconfig.tailwindcss.setup({ on_attach = on_attach })
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  root_dir = function (filename)
    local denolsFiles = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')(filename);
    if denolsFiles then
      return nil;
    end
    return lspconfig.util.root_pattern('package.json')(filename);
  end,
  single_file_support = false,
})
lspconfig.vimls.setup({ on_attach = on_attach })
lspconfig.yamlls.setup({
  on_attach = on_attach,
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use SchemaStore.nvim and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})

require('lspsaga').setup({
  definition = {
    keys = {
      edit = '<CR>',
      vsplit = 'v',
      split = 'i',
      tabe = 't',
      quit = 'q',
    },
  },
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

require('ts-error-translator').setup()
