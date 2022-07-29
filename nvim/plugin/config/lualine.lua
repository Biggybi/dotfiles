local lualine = require('lualine')

-- `dir_save`: workaround for dir disappearing in command-line
local dir_save = ''
function GitInfo()
  if vim.b.lualine_info then
    return vim.b.lualine_info
  end
  local curdir = ''
  if vim.fn.bufname() then
    curdir = vim.fn.fnamemodify(vim.api.nvim_exec('pwd', true), ':t')
  end
  if curdir ~= '' then dir_save = curdir else curdir = dir_save end
  local is_submodule = false
  if vim.fn.isdirectory('.git') == 1 then is_submodule = false
  elseif vim.fn.filereadable('.git') == 1 then
    is_submodule = string.match(vim.fn.readfile('.git', '', 1)[1], '^gitdir:') and true or false
  end
  vim.b.lualine_info = {
    cur_dir = curdir,
    is_git = vim.fn.isdirectory('.git') == 1 and true or false,
    is_submodule = is_submodule,
    tab_rhs_size = string.len(curdir) + 5
  }
  return vim.b.lualine_info
end

function GitModified()
  local git_status = vim.g.loaded_fugitive
      and vim.fn['gitgutter#hunk#summary']('%')
      or { 0, 0, 0 }
  print(git_status[1], git_status[2], git_status[3])
  return string.match(table.concat(git_status), "000") == '' and false or true
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
      inactive = { a = 'Suli00' },
    }
  },

  -- normal = {
  --   a = { 'SuliL1' },
  --   b = { 'SuliL2' },
  -- },

  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(s) return s:sub(1, 1) end,
        -- 'filename',
      },
    },

    lualine_b = {
      {
        'branch',
        color = function(s)
          return s == '' and s
              or vim.o.ft == 'help' and ''
              or GitInfo().is_git == true and 'SuliL2Git'
              or GitInfo().is_submodule == true and 'SuliL2Sub'
              or 'SuliL3Mod'
        end,
        filetype_names = {
          TelescopePrompt = 'Telescope',
          dashboard = 'Dashboard',
          packer = 'Packer',
          fzf = 'FZF',
          alpha = 'Alpha',
          qf = 'Coucou i\'m a qf',
          help = ''
        }, -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )
      },
    },

    lualine_c = {
      {
        function() return ' ' .. GitInfo().cur_dir .. ' ' end,
        padding = { left = 0, right = 0 },
        color = function()
          if vim.bo.readonly then
            return 'SuliL3Ro'
          end
          local git_status = vim.g.loaded_fugitive
              and vim.fn['gitgutter#hunk#summary']('%')
              or { 0, 0, 0 }
          local gitmod = string.match(table.concat(git_status), '000') == '000'
          return GitInfo().is_submodule and gitmod == true and 'SuliL3Sub'
              or GitInfo().is_submodule and gitmod == false and 'SuliL3SubMod'
              or GitInfo().is_git and gitmod == true and 'SuliL3Git'
              or GitInfo().is_git and gitmod == false and 'SuliL3GitMod'
              or 'SuliL3'
        end
      },

      {
        'filename',
        color = function()
          return vim.bo.modified and 'SuliL4Mod'
              or vim.bo.readonly and 'SuliL4Ro'
              or 'SuliL4'
        end,
      },
      {
        'diagnostics',
        color = 'SuliL4'
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

    lualine_b = {},
    lualine_c = {},
    lualine_x = {},

    lualine_y = {
      {
        padding = { '0' },
        function() return GitInfo().cur_dir end,
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
          return GitInfo().is_git and 'SuliL2Git'
              or GitInfo().is_submodule and 'SuliL2Sub'
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

local my_extension = {
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'mode' },
    lualine_c = { 'mode' }
  },
  filetypes = { 'quickfix' }
}
require('lualine').setup { extensions = { my_extension } }

lualine.setup(config)
