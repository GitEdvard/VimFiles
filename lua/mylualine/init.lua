find_current_class_name = require('python.mypythonlsp').find_current_class_name
find_current_method_name = require('python.mypythonlsp').find_current_method_name

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc_suggested_from_source(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

-- require'lualine'.setup {
--   lualine_a = {
--     {'mode', fmt=trunc_suggested_from_source(80, 4, nil, true)},
--     {'filename', fmt=trunc_suggested_from_source(90, 30, 50)},
--     {function() return require'lsp-status'.status() end, fmt=trunc(120, 20, 60)}
--   }
-- }

local function trunc()
  return function(str)

    -- local statusline = require'lualine'.statusline(true)
    -- statusline = statusline:gsub("%%#(.-)#", " ")
    -- statusline = statusline:gsub("%%<", "")
    -- statusline = statusline:gsub("%%=", "")
    -- if string.len(statusline) > vim.fn.winwidth(0) then
    --   return ''
    -- end

    -- local statusline = vim.api.nvim_eval_statusline(vim.o.statusline, {})
    -- if string.find(statusline.str, "<") then
    --   return ''
    -- end
    return str
  end
end

local current_theme = require('lualine.themes.auto')

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {{'mode', prio=1}},
    lualine_b = {{'branch', prio=1}},
    lualine_c = {{
      'filename',
      file_status = true,
      newfile_status = false,
      path = 1,
      prio = 1,
    }},
    lualine_x = {{find_current_class_name, prio=1, color = {fg = "#608B4E"}}, {find_current_method_name, prio=1, color = {fg = "#608B4E"}}, {'encoding'}, {'fileformat'}, {'filetype'}},
    lualine_y = {{'progress', prio = 1}},
    lualine_z = {{'location', prio = 1}}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'tabs',
        max_length = vim.fn.winwidth(0),
        mode = 1,
        -- this is adapted for PaperColor
        tabs_color = {
          active   = { fg = '#000000', bg = '#eeeeee', gui = 'bold' },
          inactive = { fg = '#888888', bg = '#d0d0d0' },
        },
      },
    },
    lualine_b = {},
    lualine_c = {
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

