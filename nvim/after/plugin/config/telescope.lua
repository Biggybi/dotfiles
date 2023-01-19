require("telescope").load_extension("ui-select")
require("telescope").load_extension("undo")
require("telescope").setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└", }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    },
    ["undo"] = {
      use_delta = true,
      use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
      side_by_side = true,
      diff_context_lines = vim.o.scrolloff,
      entry_format = "state #$ID, $STAT, $TIME",
      mappings = {
        i = {
          -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
          -- you want to replicate these defaults and use the following actions. This means
          -- installing as a dependency of telescope in it's `requirements` and loading this
          -- extension from there instead of having the separate plugin definition as outlined
          -- above.
          ["<cr>"]   = require("telescope-undo.actions").yank_additions,
          ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
          ["<C-cr>"] = require("telescope-undo.actions").restore,
        }
      }
    }
  }
})
