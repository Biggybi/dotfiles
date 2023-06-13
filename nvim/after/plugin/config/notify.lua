local notify = require 'notify'
notify.setup({
  background_colour = "NotifyBackground",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  -- minimum_width = 50,
  max_width = vim.api.nvim_get_option('columns') / 3,
  render = "minimal",
  stages = "fade_in_slide_out",
  timeout = 4000,
  top_down = false
})
