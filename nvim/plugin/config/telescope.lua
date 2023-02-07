local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<c-f>"] = function() vim.cmd [[normal <right>]] end,
        ["<c-b>"] = function() vim.cmd [[normal <left>]] end,
        ["<Esc>"] = actions.close
      },
    },
    file_ignore_patterns = { "node_modules", "%.out" },
    prompt_prefix = "> ",
  }
}

require("telescope").load_extension "file_browser"
