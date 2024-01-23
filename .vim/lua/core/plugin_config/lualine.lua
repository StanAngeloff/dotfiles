local normal = {
  a = { fg = '#e4e4e4', bg = '#3a3a3a', gui = 'NONE' },
  b = { fg = '#e4e4e4', bg = '#4e4e4e' },
  c = { fg = '#eeeeee', bg = '#262626' },
}

local theme = {
  normal = normal,
  insert = normal,
  visual = normal,
  replace = normal,
  inactive = {
    a = { fg = '#666666', bg = normal.a.bg, gui = 'NONE' },
  },
}

require('lualine').setup({
  options = {
    theme = theme,
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      'mode',
      { "%{&spell ? '󰓆  ' : ''}", draw_empty = false, padding = 0 },
      { "%{&paste ? '󰆒  ' : ''}", draw_empty = false, padding = 0 },
    },
    lualine_b = {
      {
        'branch',
      },
      {
        'diff',
        diff_color = {
          added = 'LuaLineDiffAdd',
          modified = 'LuaLineDiffChange',
          removed = 'LuaLineDiffDelete',
        },
      },
      {
        'diagnostics',
        diagnostics_color = {
          error = 'LuaLineDiagnosticError',
          warn = 'LuaLineDiagnosticWarn',
          info = 'LuaLineDiagnosticInfo',
          hint = 'LuaLineDiagnosticHint',
        },
      },
    },
    lualine_c = {
      {
        'filename',
        path = 1, -- 1: Relative path
      },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})

vim.cmd([[
  hi LuaLineDiffAdd     guifg=#74ff74 guibg=#4e4e4e
  hi LuaLineDiffDelete  guifg=#ff7474 guibg=#4e4e4e
  hi LuaLineDiffChange  guifg=#ccaa00 guibg=#4e4e4e

  hi LuaLineDiagnosticError  guifg=#c01020 guibg=#4e4e4e
  hi LuaLineDiagnosticWarn   guifg=#ffcc00 guibg=#4e4e4e
  hi LuaLineDiagnosticInfo   guifg=#ff00ff guibg=#4e4e4e
  hi LuaLineDiagnosticHint   guifg=#66777f guibg=#4e4e4e
]])

local bufferline = require('bufferline')

bufferline.setup({
  options = {
    mode = 'tabs',
    numbers = 'none',
    style_preset = {
      bufferline.style_preset.minimal,
      bufferline.style_preset.no_italic,
    },
    indicator = {
      style = 'none',
    },
    tab_size = 1,
    max_name_length = 32,
    max_prefix_length = 24,
    modified_icon = '∗',
    diagnostics = false,
    color_icons = false,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = false,
    separator_style = { '', '' },
    always_show_bufferline = true,
    left_trunc_marker = '←',
    right_trunc_marker = '→',
  },

  highlights = {
    fill = {
      bg = '#262626',
    },
    background = {
      fg = '#666666',
      bg = '#262626',
    },
    tab = {
      fg = '#666666',
      bg = '#262626',
    },
    modified = {
      fg = '#666666',
      bg = '#262626',
    },
    duplicate = {
      fg = '#464646',
      bg = '#262626',
    },
    buffer_selected = {
      fg = '#e4e4e4',
      bg = '#3a3a3a',
      bold = false,
      italic = false,
    },
    modified_selected = {
      fg = '#e4e4e4',
      bg = '#3a3a3a',
      bold = false,
      italic = false,
    },
    duplicate_selected = {
      fg = '#848484',
      bg = '#3a3a3a',
    },
    indicator_selected = {
      fg = '#e4e4e4',
      bg = '#3a3a3a',
    },
    trunc_marker = {
      fg = '#888888',
      bg = '#262626',
    },
  },
})
