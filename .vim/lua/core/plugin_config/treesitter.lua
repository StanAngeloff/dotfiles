local parsers = require('nvim-treesitter.parsers').get_parser_configs()

parsers.liquid = {
  filetype = 'liquid',
  install_info = {
    url = 'https://github.com/Shopify/tree-sitter-liquid-ii.git',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}

require('nvim-treesitter.configs').setup({
  ensure_installed = {
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
    -- 'phpdoc',
    'tsx',
    'typescript',
    'vim',
  },
  sync_install = false,
  ignore_install = {},

  highlight = {
    enable = true,
    disable = {
      'css',
    },
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
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

local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername

ft_to_parser.liquid = 'liquid'