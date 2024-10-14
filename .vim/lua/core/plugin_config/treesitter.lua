local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

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

require('treesitter-context').setup({
  enable = true,
  max_lines = 10,
  min_window_height = 0,
  line_numbers = false,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
})

vim.filetype.add({
  extension = {
    astro = 'astro',
  },
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  -- Turn on regex syntax highlighting for these extensions.
  -- This eliminates issues with spell checking.
  pattern = { '*.js', '*.jsx', '*.mjs', '*.cjs', '*.ts', '*.tsx' },
  callback = function() vim.cmd('syntax on') end,
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
