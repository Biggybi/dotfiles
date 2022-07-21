local lualine = require('lualine')

-- `dir_save`: workaround for dir disappearing in command-line
local dir_save = ''
function Get_curdir()
  local parent_dir = ''
  if vim.fn.bufname() then
    parent_dir = vim.fn.fnamemodify(vim.api.nvim_exec('pwd', true), ':t')
  end
  if parent_dir ~= '' then dir_save = parent_dir else parent_dir = dir_save end
  return {
    cur_dir = parent_dir,
    is_git_dir = vim.fn.isdirectory('.git') == 1 and true or false,
    tab_rhs_size = string.len(parent_dir) + 5
  }
end

local tab_rhs_size = 20
function Tab_size()
  local tabsize = math.floor((vim.o.columns - tab_rhs_size - 3) / vim.fn.tabpagenr("$")) - 2
  tabsize = math.min(tabsize, 40)
  return tabsize
end

local config = {
  options = {
    icons_enabled = false,
    theme = 'onehalfdark',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    symbols = { modified = '', readonly = '', unnamed = '[No Name]' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },

  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(s) return s:sub(1, 1) end,
        'filename',
      },
    },

    lualine_b = {
      {
        'branch',
        fmt = function(s)
          return vim.o.ft == 'help'
              and '%#SuliL2Ro#' .. vim.o.ft
              or Get_curdir().is_git_dir
              and '%#SuliL2Git#' .. s
              or '%#SuliL2Mod#' .. s
        end,
      },
    },

    lualine_c = {
      {
        function() return Get_curdir().cur_dir end,
        padding = { left = 1, right = 0 },
        color = function()
          if vim.bo.readonly then
            return 'SuliL3Ro'
          elseif vim.g.loaded_fugitive and vim.fn['fugitive#Head']() == "" then
            return 'SuliL3'
          end
          local amr = { 0, 0, 0 }
          if vim.g.loaded_gitgutter then
            amr = vim.fn['gitgutter#hunk#summary']('%')
          end
          return amr == { 0, 0, 0 } and 'SuliL3Mod' or 'SuliL3'
        end
      },
      {
        'filename',
        color = function()
          return vim.bo.modified and 'SuliL3Mod'
              or vim.bo.readonly and 'SuliL3Ro'
              or 'SuliL3'
        end,
      },
      {
        'diagnostics',
        color = 'SuliL3'
      }
    },

    lualine_x = { 'anzu#search_status' },
    lualine_y = { 'filetype' },
    lualine_z = { 'progress', '%4l:%-3v' }

  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'filetype' },
    lualine_y = {},
    lualine_z = {}
  },

  tabline = {

    lualine_a = {
      {
        'tabs',
        mode = 1,
        tabs_color = {
          active = 'lualine_b_normal',
          inactive = 'lualine_a_inactive',
        },
        color = { 'normal' },
        fmt = function(s)
          local tabsize = Tab_size()
          local paddchar = " "
          if s:len() > tabsize - 2 then
            local endchar = s:len() == tabsize - 1 and ' ' or '`'
            return s:sub(1, tabsize - 1) .. endchar .. '%#TabLineFill#'
          end
          local padd = tabsize - s:len()
          local left_padd = math.floor((padd - s:len() % 2) / 2)
          local left_padd_str = paddchar:rep(left_padd)
          local right_padd_str = paddchar:rep(tabsize - left_padd - s:len())
          return left_padd_str .. s .. right_padd_str .. '%#TabLineFill#'
        end,
        max_length = 400,
      }
    },

    lualine_b = { {} },
    lualine_c = { {} },
    lualine_x = { {} },

    lualine_y = {
      {
        padding = { '0' },
        function() return Get_curdir().cur_dir end,
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
        color = function() return Get_curdir().is_git_dir
              and 'SuliL2Git'
              or 'SuliL2'
        end
      }
    },

    lualine_z = {
      {
        'ObsessionStatus',
        fmt = function(s) return s == '[$]' and 'S' or '-' end,
      }
    }
  },

  extensions = {}

}

lualine.setup(config)
