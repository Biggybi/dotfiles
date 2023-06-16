local lualine = require('lualine')

vim.g.qf_disable_statusline = true

local function qf_is_loc()
  -- filewinid DOES exist
  return vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
end

local function get_location()
  local linecolumn = '%5l:%-3v'
  local curline    = vim.fn.line('.')
  local lastline   = vim.fn.line('$')
  local percent    = curline == 1 and 'Top'
      or curline == lastline and 'Bot'
      or string.format('%2d', math.floor(curline / lastline * 100)) .. '%%'
  return percent .. linecolumn
end

-- Extension: Quickfix
local extension_quickfix = {
  sections = {
    lualine_a = { {
      'mode',
      fmt = function(s) return s:sub(1, 1) end,
    } },
    lualine_b = { {
      function() return qf_is_loc() and 'Location List' or 'Quickfix List' end,
      color = 'SuliQf',
    } },
    lualine_c = { {
      function()
        return qf_is_loc()
            -- title DOES exist
            and vim.fn.getloclist(0, { title = 0 }).title
            or vim.fn.getqflist({ title = 0 }).title
      end,
      color = 'SuliQfTitle',
    } },
    lualine_x = { {} },
    lualine_y = { {} },
    lualine_z = { function() return vim.fn.line('.') .. '/' .. vim.fn.line('$') end }
  },
  inactive_sections = {
    lualine_a = { { function() return ' ' end, color = 'SuliQfNC' } },
    lualine_b = { {
      function() return qf_is_loc()
            and 'Location List'
            or 'Quickfix List'
      end,
      color = 'SuliQfNC',
    } },
    lualine_c = { {
      function()
        return qf_is_loc()
            -- title DOES exist
            and vim.fn.getloclist(0, { title = 0 }).title
            or vim.fn.getqflist({ title = 0 }).title
      end,
      color = 'SuliQfTitleNC',
    } },
    lualine_x = { {} },
    lualine_y = { {} },
    lualine_z = { {
      function() return vim.fn.line('.') .. '/' .. vim.fn.line('$') end,
      color = 'SuliQfNC'
    } }
  },
  theme = {
    active = {
      visual = { a = 'SuliCmd', b = 'SuliL3' },
    },
    -- inactive = {
    --   normal = { a = 'SuliQfNC', b = 'SuliL3', c = '' },
    --   a = 'SuliQf', b = 'SuliQf', c = 'SuliQf',
    --   x = 'SuliQf', y = 'SuliQf', z = 'SuliQf'
    -- }
  },
  filetypes = { 'qf' },
}

require('lualine').setup { extensions = { extension_quickfix } }

local function is_special_buffer()
  -- local specials = { 'qf', 'help', 'man' }
  local specials = { 'help', 'man', 'fugitive' }
  for _, ft in pairs(specials) do
    if ft == vim.o.filetype then
      return true
    end
  end
  return false
end

local function git_info()

  if vim.b.lualine_info then return vim.b.lualine_info end

  local cur_dir = ''
  if vim.fn.bufname() then
    cur_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  end
  local is_submodule = false
  if vim.fn.isdirectory('.git') == 1 then
    is_submodule = false
  elseif vim.fn.filereadable('.git') == 1 then
    is_submodule = string.match(vim.fn.readfile('.git', '', 1)[1], '^gitdir:') ~= nil
  end
  vim.b.lualine_info = {
    bufname = vim.fn.bufname(),
    cur_dir = cur_dir,
    is_git = vim.fn.isdirectory('.git') == 1,
    is_submodule = is_submodule,
    tab_rhs_size = string.len(cur_dir) + 5
  }
  return vim.b.lualine_info
end

local tab_rhs_size = 20
local tab_size_max = 40
local tab_obsession_size = 3

function Tab_size()
  local tabsize =
      (vim.o.columns - tab_rhs_size - tab_obsession_size)
      / vim.fn.tabpagenr("$")
  tabsize = math.min(tabsize, tab_size_max)
  return tabsize - 2
end

local config = {
  options = {
    refresh = {
      statusline = 400,
      tabline = 400,
      winbar = 1000,
    },
    icons_enabled = false,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    symbols = { modified = '', readonly = '', unnamed = '[No Name]' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
    theme = {
      normal   = { a = 'SuliL1', b = 'SuliL2', d = '' },
      insert   = { a = 'SuliInsert' },
      visual   = { a = 'SuliVisual' },
      replace  = { a = 'SuliReplace' },
      command  = { a = 'SuliCmd' },
      inactive = {
        a = 'Suli00', b = 'Suli00',
        x = 'Suli00', y = 'Suli00', z = 'Suli00'
      }
    }
  },

  sections = {
    lualine_a = { {
      'mode',
      fmt = function(s) return s:sub(1, 1) end,
      -- 'filename',
    } },

    lualine_b = { {
      'branch',
      color = function(s)
        return s == '' and s
            or git_info().is_git and 'SuliL2Git'
            or git_info().is_submodule and 'SuliL2Sub'
            or ''
      end,
      fmt = function(s)
        return vim.g.loaded_fugitive == 0 and ''
            or vim.fn.bufname() == '' and ''
            or s == '' and vim.fn.FugitiveHead() or s
      end,
      cond = function() return not is_special_buffer() end,
    } },

    lualine_c = { {
      -- git branch
      function() return vim.g.loaded_fugitive == 0 and ''
            or vim.fn.bufname() == '' and ' [No Name]'
            or ' ' .. git_info().cur_dir .. ' '
      end,
      padding = { left = 0, right = 0 },
      color = function() if is_special_buffer() then return 'SuliL3Ro' end
        local git_status = vim.g.loaded_fugitive
            and vim.fn['gitgutter#hunk#summary']('%')
            or { 0, 0, 0 }
        local gitmod = string.match(table.concat(git_status), '000') ~= '000'
        return git_info().is_submodule and not gitmod and 'SuliL3Sub'
            or git_info().is_submodule and gitmod and 'SuliL3SubMod'
            or git_info().is_git and not gitmod and 'SuliL3Git'
            or git_info().is_git and gitmod and 'SuliL3GitMod'
            or 'SuliL3'
      end
    }, {
      -- bufname
      function() return vim.fn.bufname() end,
      color = function()
        return vim.bo.modified and 'SuliL4Mod'
            or vim.bo.readonly and 'SuliL4Ro'
            or is_special_buffer() and 'SuliL4Ro'
            or 'SuliL4'
      end,
      padding = { left = 1, right = 1 },
    } },

    lualine_x = { {
      'anzu#search_status',
      color = 'SuliL3',
      fmt = function(s) return s ~= '' and s:match('[%d/]+') or '' end,
      padding = { left = 1, right = 1 },
    }, {
      'diagnostics',
      color = 'SuliL3',
      diagnostics_color = {
        -- Same values as the general color option can be used here.
        error = 'SuliDiagErr',
        warn  = 'SuliDiagWarn',
        info  = 'SuliDiagInfo',
        hint  = 'SuliDiagHint',
      },
      colored = true, -- Displays diagnostics status in color if set to true.
    } },
    lualine_y = { 'filetype' },
    lualine_z = { function() return get_location() end }
  },

  inactive_sections = {
    lualine_a = { { function() return ' ' end, color = 'SuliNC' } },
    lualine_b = { {
      'branch',
      color = function(s)
        local info = vim.b.lualine_info
        return s == '' or info == nil and 'SuliNC'
            or info.is_git and 'SuliNCGit'
            or info.is_submodule and 'SuliNCSub'
            or ''
      end,
      fmt = function(s)
        return vim.g.loaded_fugitive == '' and ''
            or vim.fn.bufname() == 0 and ''
            or s == '' and vim.fn.FugitiveHead()
            or s
      end,
      cond = function() return not is_special_buffer() end,
    } },
    lualine_c = { {
      -- file path
      function()
        if not vim.g.loaded_fugitive then return '' end
        if vim.o.ft == 'help' then
          local color = '%#SuliNCRo#'
          local folder = vim.fn.fnamemodify(vim.fn.bufname(), ':h:t')
          return color .. folder
        end
        if vim.fn.bufname() == '' then return '[No Name]' end
        local bufnr = vim.fn.bufnr()
        local gitpath = vim.fn.FugitiveExtractGitDir(bufnr)
        local project = vim.fn.fnamemodify(gitpath, ':h:t')
        local subproject = vim.fn.fnamemodify(gitpath, ':t')
        local curdir = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':p:h:t')
        local isgit = gitpath:match('.git$') ~= nil
        local issub = gitpath:match('.git/module') ~= nil

        local git_status = vim.g.loaded_fugitive
            and vim.fn['gitgutter#hunk#summary'](bufnr)
            or { 0, 0, 0 }
        local gitmod = string.match(table.concat(git_status), '000') ~= '000'
        local color = isgit and not gitmod and '%#SuliNCGit#'
            or isgit and gitmod and '%#SuliNCGitMod#'
            or issub and not gitmod and '%#SuliNCSub#'
            or issub and gitmod and '%#SuliNCGitMod#'
            or is_special_buffer() and '%#SuliNCRo#'
            or '%#SuliNC#'

        return isgit and color .. project
            or issub and color .. subproject
            or color .. curdir

      end,
    }, {
      -- bufname
      function()
        if vim.o.ft == 'help' then
          return vim.fn.fnamemodify(vim.fn.bufname(), ':t')
        end
        local gitpath = vim.g.loaded_fugitive == 0 and ''
            or vim.fn.FugitiveExtractGitDir(vim.fn.bufnr()) or ''
        local isgit = gitpath:match('.git$') ~= nil
        local issub = gitpath:match('.git/module') ~= nil
        if issub or isgit then
          return vim.fn.matchstr(
            vim.fn.expand('%:p'),
            vim.fn.FugitiveWorkTree() .. '/\\zs.*'
          )
        end
        local path = vim.b.lualine_info.bufname
        return isgit and path
            or issub and path
            or vim.fn.fnamemodify(path, ':t')
      end,
      color = function()
        return vim.bo.modified and 'SuliNCMod'
            or vim.bo.readonly and 'SuliNCRo'
            or is_special_buffer() and 'SuliNCRo'
            or 'SuliNC'
      end
    } },

    lualine_x = { { 'filetype', color = 'SuliNC' } },
    lualine_y = {},
    lualine_z = {}
  },

  tabline = {

    lualine_a = { {
      'tabs',
      mode = 1,
      tabs_color = {
        active = 'TabLineSel',
        inactive = 'TabLine',
      },
      fmt = function(s)
        local tabsize = Tab_size()
        local paddchar = " "
        if s:len() > tabsize - 2 then
          local endchar = s:len() == tabsize - 1 and ' ' or '`'
          return s:sub(1, tabsize - 1) .. endchar .. '%#TabLineFill#'
        end
        local padd = tabsize - s:len()
        local adjust = (tabsize - s:len()) % 2 == 0 and 1 or 0
        local left_padd = math.floor(padd / 2) - adjust
        local left_padd_str = paddchar:rep(left_padd)
        local right_padd_str = paddchar:rep(tabsize - left_padd - s:len())
        return left_padd_str .. s .. right_padd_str .. '%#TabLineFill#'
      end,
      max_length = 9999999,
    } },

    lualine_b = {},
    lualine_c = {},
    lualine_x = {},

    lualine_y = { {
      padding = { left = 0, right = 0 },
      function() return git_info().cur_dir end,
      fmt = function(s)
        local paddchar = " "
        if s:len() > tab_rhs_size - 2 then
          local endchar = s:len() == tab_rhs_size - 1 and ' ' or '`'
          return ' ' .. s:sub(1, tab_rhs_size - 2) .. endchar
        end
        local padd = tab_rhs_size - s:len()
        local left_padd = math.floor((padd - s:len() % 2) / 2)
        local left_padd_str = paddchar:rep(left_padd)
        local right_padd_str = paddchar:rep(tab_rhs_size - left_padd - s:len())
        return left_padd_str .. s .. right_padd_str
      end,
      color = function()
        return git_info() == nil and 'SuliL2'
            or git_info().is_git and 'SuliL2Git'
            or git_info().is_submodule and 'SuliL2Sub'
            or 'SuliL2'
      end
    } },

    lualine_z = { {
      'ObsessionStatus',
      fmt = function(s) return s == '[$]' and 'S' or '-' end,
    } }
  },
}

lualine.setup(config)
