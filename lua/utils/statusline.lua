local bo, fn, call = vim.bo, vim.fn, vim.call
local mode = require('feline.providers.vi_mode')
local gps = require('nvim-gps')
local luasnip = require('luasnip')

local components = { active = { {}, {}, {} } }

local modes = {
  ['n']    = 'NORMAL',
  ['no']   = 'OP    ',
  ['nov']  = 'OP    ',
  ['noV']  = 'OP    ',
  ['no'] = 'OP    ',
  ['niI']  = 'NORMAL',
  ['niR']  = 'NORMAL',
  ['niV']  = 'NORMAL',
  ['v']    = 'VISUAL',
  ['V']    = 'LINES ',
  ['']   = 'BLOCK ',
  ['s']    = 'SELECT',
  ['S']    = 'SELECT',
  ['']   = 'BLOCK ',
  ['i']    = 'INSERT',
  ['ic']   = 'INSERT',
  ['ix']   = 'INSERT',
  ['R']    = 'REPLACE',
  ['Rc']   = 'REPLACE',
  ['Rv']   = 'V-REPLACE',
  ['Rx']   = 'REPLACE',
  ['c']    = 'COMMAND',
  ['cv']   = 'COMMAND',
  ['ce']   = 'COMMAND',
  ['r']    = 'ENTER ',
  ['rm']   = 'MORE  ',
  ['r?']   = 'CONFIRM',
  ['!']    = 'SHELL ',
  ['t']    = 'TERM  ',
  ['nt']   = 'TERM  ',
  ['null'] = 'NONE  ',
}

local left_sep  = { str = ' ',   hl = { fg = 'line_bg', bg = 'bg0' } }
local right_sep = { str = '',  hl = { fg = 'line_bg', bg = 'bg0' } }

-- Help functions

local function has_file_type()
  local f_type = vim.bo.filetype
  if not f_type or f_type == '' then return false end
  return true
end

local function get_working_dir(shorten)
  if shorten == true then
    return fn.pathshorten(fn.fnamemodify(fn.getcwd(), ':~'))
  else
    return fn.fnamemodify(fn.getcwd(), ':p:~')
  end
end

local function get_icon_full()
  local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
  if has_devicons then
    local icon, iconhl = devicons.get_icon(fn.expand('%:t'), fn.expand('%:e'))
    if icon ~= nil then
      return icon, vim.fn.synIDattr(vim.fn.hlID(iconhl), 'fg')
    end
  end
end

local function get_icon(padding)
  local icon = select(1, get_icon_full()) or ''
  if not padding then
    return icon
  else
    return icon .. ' '
  end
end

local function get_icon_hl()
  return select(2, get_icon_full())
end

local function file_osinfo()
  local os = vim.bo.fileformat
  local icon
  if os == 'unix' then
    icon = ' '
  elseif os == 'mac' then
    icon = ' '
  else
    icon = ' '
  end
  return icon .. os
end

-- Sections
local active_left = components.active[1]
local active_mid = components.active[2]
local active_right = components.active[3]

------------------
-- Left section --
------------------

-- Vim mode
table.insert(active_left, {
  provider = function()
    return ' ' .. modes[vim.api.nvim_get_mode().mode] .. ' '
  end,
  hl = function()
    return { fg = 'bg', bg = mode.get_mode_color(), style = 'bold' }
  end,
  priority = 10,
})

-- Readonly indicator
table.insert(active_left, {
  provider = ' ',
  hl = { bg = 'line_bg' },
  enabled = function() return bo.readonly and bo.buftype ~= 'help' end,
  truncate_hide = true,
  priority = 7
})

-- Current working directory
table.insert(active_left, {
  provider = get_working_dir,
  short_provider = function () return get_working_dir(true) end,
  hl = function() return { fg = mode.get_mode_color(), bg = 'line_bg' } end,
  left_sep = '█',
  right_sep = { str = '',  hl = { fg = 'line_bg', bg = 'bg0' } },
  icon = ' ',
  truncate_hide = true,
  priority = 9
})

table.insert(active_left, {
  provider = ' ',
  hl = { fg = 'bg', bg = 'bg0' },
})

-- LSP client
table.insert(active_left, {
  provider = 'lsp_client_names',
  left_sep = ' ',
  riht_sep = ' ',
  hl = { fg = 'darkgray' },
  enabled = function() return next(vim.lsp.get_active_clients()) ~= nil end,
  icon = ' ',
  truncate_hide = true,
  priority = -1,
})

table.insert(active_left, {
  provider = 'diagnostic_errors',
  hl = { fg = 'error' },
})

table.insert(active_left, {
  provider = 'diagnostic_warnings',
  hl = { fg = 'warning' },
})

table.insert(active_left, {
  provider = 'diagnostic_info',
  hl = { fg = 'info' },
})

table.insert(active_left, {
  provider = 'diagnostic_hints',
  hl = { fg = 'hint' },
})

--------------------
-- Middle section --
--------------------

-- GPS
gps.setup({ separator = '  ' })

table.insert(active_mid, {
  provider = gps.get_location,
  short_provider = function() return gps.get_location({ depth = 1 }) end,
  hl = { fg = 'darkgray' },
  enabled = function()
    return gps.is_available() and not luasnip.in_snippet()
  end,
  truncate_hide = true,
  priority = -1
})

-- Snippet indicator
table.insert(active_mid, {
  provider = 'snippet',
  hl = { fg = 'darkgray' },
  enabled = luasnip.in_snippet,
  icon = {
    str =' ',
    hl = { fg = 'blue' }
  },
})

-------------------
-- Right section --
-------------------

table.insert(active_right, {
  provider = 'git_diff_added',
  hl = { fg = 'green' },
  truncate_hide = true
})

table.insert(active_right, {
  provider = 'git_diff_changed',
  icon = '  ',
  hl = { fg = 'orange' },
  truncate_hide = true
})

table.insert(active_right, {
  provider = 'git_diff_removed',
  hl = { fg = 'red' },
  right_sep = '',
  truncate_hide = true
})

-- Git branch
table.insert(active_right, {
  provider = 'git_branch',
  right_sep = ' ',
  enabled = 'git_info_exists',
  icon = {
    str = '  ',
    hl = { fg = '#f34f29' },
  },
  truncate_hide = true,
  priority = 2
})

table.insert(active_right, {
  provider = '',
  hl = { fg = 'bg', bg = 'bg0' },
})

-- Filetype
table.insert(active_right, {
  provider = function() return ' ' .. bo.filetype end,
  left_sep = left_sep,
  right_sep = right_sep,
  hl = { bg = 'line_bg' },
  enabled = has_file_type,
  icon = function()
    return {
      str = get_icon(),
      hl = { fg = get_icon_hl(), bg = 'line_bg' },
      always_visible = true,
    }
  end,
  truncate_hide = true,
  priority = 1
})

-- File OS info
table.insert(active_right, {
  provider = file_osinfo,
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
  truncate_hide = true,
  priority = -1
})

-- File encoding
table.insert(active_right, {
  provider = 'file_encoding',
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
  truncate_hide = true,
  priority = -1
})

-- Copilot
table.insert(active_right, {
  provider = 'ﮧ ',
  hl = function() return { fg = mode.get_mode_color(), bg = 'line_bg' } end,
  left_sep = left_sep,
  right_sep = right_sep,
  enabled = function()
    return fn.exists('*copilot#Enabled') == 1 and call('copilot#Enabled') == 1
  end,
  truncate_hide = true
})

-- Clock
table.insert(active_right, {
  provider = function() return fn.strftime('%H:%M') end,
  hl = { bg = 'line_bg' },
  left_sep = left_sep,
  right_sep = right_sep,
  icon = function() return {
    str = ' ',
    hl = {
      fg = mode.get_mode_color(),
      bg = 'line_bg'
    }
  } end,
  truncate_hide = true
})

-- Cursor line and column
table.insert(active_right, {
  provider = function()
    return string.format('%2d:%-2d', fn.line('.'), fn.col('.'))
  end,
  short_provider = function()
    return string.format('%d:%-d', fn.line('.'), fn.col('.'))
  end,
  left_sep = function()
    return { str = ' ', hl = { fg = mode.get_mode_color(), bg = 'bg0' } }
  end,
  right_sep = function()
    return { str = '█', hl = { fg = mode.get_mode_color(), bg = 'bg0' } }
  end,
  hl = function()
    return { fg = 'line_bg', bg = mode.get_mode_color(), style = 'bold' }
  end,
  icon = ' ',
  priority = 9,
})

-----------
-- Setup --
-----------
local function setup(config)
  local plugin_setup = require('utils').plugin_setup
  local colors = require('configs.colorscheme').modes

  local mode_colors = {
    NORMAL        = colors.normal,
    OP            = colors.normal,
    INSERT        = colors.insert,
    COMMAND       = colors.command,
    VISUAL        = colors.visual,
    LINES         = colors.visual,
    BLOCK         = colors.visual,
    REPLACE       = colors.replace,
    TERM          = colors.term,
    ['V-REPLACE'] = 'magenta',
    ENTER         = 'orange',
    MORE          = 'orange',
    SELECT        = 'cyan',
    SHELL         = 'green',
    NONE          = 'gray',
  }

  if not config or not config.theme then
    error('No config and/or theme provided')
  else
    local theme = config.theme
    if config.modifications then
      theme = vim.tbl_extend('force', theme, config.modifications)
    end

    plugin_setup('feline', {
      theme = theme,
      components = components,
      vi_mode_colors = mode_colors,
      force_inactive = {}
    })
  end
end

return { setup = setup }
