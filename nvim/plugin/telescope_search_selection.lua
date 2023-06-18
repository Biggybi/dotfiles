local function getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})
  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

local keymap = vim.keymap.set
local telescope_builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local opts = { noremap = true, silent = true }

keymap('n', '<leader>fr', '<cmd>Telescope live_grep theme=dropdown<cr>', opts)
keymap('v', '<leader>fr', function()
  local text = getVisualSelection()
  telescope_builtin.live_grep(
    themes.get_dropdown{ default_text = text }
  )
end, opts)
