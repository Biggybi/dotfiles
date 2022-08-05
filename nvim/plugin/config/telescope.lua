local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-f>"] = function(s) vim.cmd [[normal <right>]] end,
        ["<c-b>"] = function(s) vim.cmd [[normal <left>]] end,
        -- ["<c-f>"] = actions.move_backward,
        ["<Esc>"] = actions.close
      },
    },
    file_ignore_patterns = { "node_modules", "%.out" },
    prompt_prefix = "> ",
  }
}

require("telescope").load_extension "file_browser"
