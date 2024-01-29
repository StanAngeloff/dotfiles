local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

parser_config.liquid = {
  filetype = 'liquid',
  install_info = {
    url = 'https://github.com/Shopify/tree-sitter-liquid.git',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'astro',
    'bash',
    'css',
    'dockerfile',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'liquid',
    'lua',
    'make',
    'markdown',
    'php',
    'toml',
    'tsx',
    'typescript',
    'vim',
  },
  sync_install = false,
  ignore_install = {},

  highlight = {
    enable = true,
    disable = {},
    -- See https://github.com/lewis6991/spellsitter.nvim#usage
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = false,
    -- keymaps = {
    --   init_selection = 'gnn',
    --   node_incremental = 'grn',
    --   scope_incremental = 'grc',
    --   node_decremental = 'grm',
    -- },
  },

  indent = {
    enable = true,
  },

  textobjects = {
    select = {
      enable = true,

      lookahead = true,
      include_surrounding_whitespace = false,

      keymaps = {
        ['ic'] = '@comment.outer',
      },
    },
  },
})

vim.filetype.add({
  extension = {
    astro = 'astro',
  },
})

vim.treesitter.language.register('liquid', 'liquid')

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  -- Turn on regex syntax highlighting for these extensions.
  -- This eliminates issues with spell checking.
  pattern = { '*.js', '*.jsx', '*.mjs', '*.cjs', '*.ts', '*.tsx' },
  callback = function() vim.cmd('syntax on') end,
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
