vim.keymap.set({ "n" }, "<leader>rr", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
-- -- Action:      Show treesitter capture group for textobject under cursor.
-- bindkey("n",    "<C-e>",
--     function()
--         local result = vim.treesitter.get_captures_at_cursor(0)
--         print(vim.inspect(result))
--     end,
--     { noremap = true, silent = false }
-- )

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- null_ls.builtins.code_actions.eslint_d,
    -- null_ls.builtins.completion.eslint_d,
    -- null_ls.builtins.hover.eslint,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.prettier_d,
    null_ls.builtins.diagnostics.eslint_d,
  },
})

-- local prettier = require("prettier")
-- prettier.setup {
--   bin = 'prettierd',
--   filetypes = {
--     "css",
--     "javascript",
--     "javascriptreact",
--     "typescript",
--     "typescriptreact",
--     "json",
--     "scss",
--     "less"
--   }
-- }

local lsp_set_mappings = function(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '[w', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']w', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>fo', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('v', '<leader>fo', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_highlight_cursor_symbol = function(client, bufnr)
  -- highlight symbol under cursor
  if not client.server_capabilities.documentHighlightProvider then return end
  vim.api.nvim_create_augroup('lsp_document_highlight', {
    clear = false
  })
  vim.api.nvim_clear_autocmds({
    buffer = bufnr,
    group = 'lsp_document_highlight',
  })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = 'lsp_document_highlight',
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    group = 'lsp_document_highlight',
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

require("mason").setup({
  ui = {
    check_outdated_packages_on_open = true,
    border = "rounded",
    icons = {
      package_installed = "●",
      package_pending = "◍",
      package_uninstalled = "○"
    },
  },
})

require('mason-lspconfig').setup({
  ensure_installed = {
    -- 'tsserver',
    -- 'eslint',
    -- 'sumneko_lua',
  },
})

local lsp_navic = function(client, bufnr)
  -- vim.cmd("echom 'naviiiiiiiiiiiic:'")
  if not client.server_capabilities.documentSymbolProvider
      or not vim.lsp then
    return
  end
  -- vim.cmd[[echom "attach"]]
  require("nvim-navic").attach(client, bufnr)
end

local lsp_attach = function(client, bufnr)
  lsp_navic(client, bufnr)
  lsp_set_mappings(bufnr)
  lsp_highlight_cursor_symbol(client, bufnr)
end

-- apply setup
local lsp_servers = require('mason-lspconfig').get_installed_servers()
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')

-- do hover 'K' borders
-- local border = {
--   { "┌", "FloatBorder" },
--   { "─", "FloatBorder" },
--   { "┐", "FloatBorder" },
--   { "│", "FloatBorder" },
--   { "┘", "FloatBorder" },
--   { "─", "FloatBorder" },
--   { "└", "FloatBorder" },
--   { "│", "FloatBorder" },
-- }

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup {
      root_dir = lspconfig.util.find_git_ancestor,
      on_attach = lsp_attach,
      capabilities = lsp_capabilities,
      flags = { debounce_text_change = 300 },
      cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      handlers = handlers
    }
  end,
  -- -- Next, you can provide targeted overrides for specific servers.
  -- -- For example, a handler override for the rust_analyzer:
  -- ["rust_analyzer"] = function()
  --   require("rust-tools").setup {}
  -- end
}

-- diagnostic display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  float = true,
  -- underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- diagnostic signcolumn signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- column diagnostic as colors
vim.cmd [[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl=DiagnosticLineNrHint
]]

-- -- do hover 'K' borders
-- local border = {
--   { "╭", "FloatBorder" },
--   { "─", "FloatBorder" },
--   { "╮", "FloatBorder" },
--   { "│", "FloatBorder" },
--   { "╯", "FloatBorder" },
--   { "─", "FloatBorder" },
--   { "╰", "FloatBorder" },
--   { "│", "FloatBorder" },
-- }

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- virtual text prefix character
vim.diagnostic.config({
  virtual_text = {
    prefix = ' ' -- Could be  ⵗ ☰ ❙ ❝◉ ◎ ● ▎❚ ⌷ x■ ▢ ◽◾◆ ◇ ▰ ▱ ▶ ▷ ▸ ▹ ◊ ⧫ ♢
  }
})

-- local lsp_highlight_cursor_symbol = function(client, bufnr)
--   -- highlight symbol under cursor
--   if not client.server_capabilities.documentHighlightProvider then return end
--   vim.api.nvim_create_augroup('lsp_document_highlight', {
--     clear = false
--   })
--   vim.api.nvim_clear_autocmds({
--     buffer = bufnr,
--     group = 'lsp_document_highlight',
--   })
--   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--     group = 'lsp_document_highlight',
--     buffer = bufnr,
--     callback = vim.lsp.buf.document_highlight,
--   })
--   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
--     group = 'lsp_document_highlight',
--     buffer = bufnr,
--     callback = vim.lsp.buf.clear_references,
--   })
-- end

-- local barbecue_theme_keys = {
--   normal = "BarbecueNormal",
--   ellipsis = "BarbecueEllipsis",
--   separator = "BarbecueSeparator",
--   modified = "BarbecueModified",
--   dirname = "BarbecueDirname",
--   basename = "BarbecueBasename",
--   context = "BarbecueContext",
--   context_file = "BarbecueContextFile",
--   context_module = "BarbecueContextModule",
--   context_namespace = "BarbecueContextNamespace",
--   context_package = "BarbecueContextPackage",
--   context_class = "BarbecueContextClass",
--   context_method = "BarbecueMethod",
--   context_property = "BarbecueProperty",
--   context_field = "BarbecueField",
--   context_constructor = "BarbecueConstructor",
--   context_enum = "BarbecueEnum",
--   context_interface = "BarbecueInterface",
--   context_function = "BarbecueFunction",
--   context_variable = "BarbecueVariable",
--   context_constant = "BarbecueConstant",
--   context_string = "BarbecueString",
--   context_number = "BarbecueNumber",
--   context_boolean = "BarbecueBoolean",
--   context_array = "BarbecueArray",
--   context_object = "BarbecueObject",
--   context_key = "BarbecueKey",
--   context_null = "BarbecueNull",
--   context_enum_member = "BarbecueEnumMember",
--   context_struct = "BarbecueStruct",
--   context_event = "BarbecueEvent",
--   context_operator = "BarbecueOperator",
--   context_type_parameter = "BarbecueTypeParameter",
-- }
-- local barbecue_link_hl = function()
--   local barbecue_theme = {}
--   for group, hlgroup in pairs(barbecue_theme_keys) do
--     -- print(group, hlgroup)
--     if hlgroup and hlgroup.len then
--       local color = vim.api.nvim_get_hl_by_name(hlgroup, false)
--       -- print(color.foreground)
--       if color and color.len then barbecue_theme[group] = color end
--     end
--     -- barbecue_theme += vim.api.nvim.nvim_get_hl_by_name(, true)
--   end
--   return barbecue_theme
-- end
-- barbecue_link_hl()
-- -- refresh barbecue colors with colorscheme
-- vim.api.nvim_create_autocmd({"ColorScheme"}, {
--   pattern = {"*"},
--   -- callback = function() require('barbecue').setup({
--   --   theme = barbecue_link_hl()
--   -- })
--   -- end
--   callback = function() barbecueSetup() end
-- })

local barbecueSetup = function()
  require("barbecue").setup({
    -- theme = barbecue_link_hl(),
    exclude_filetypes = {
      "",
      "netrw",
      "help",
      "gitcommit",
      "terminal",
    },
    exclude_buftype = { "", "help" },
    attach_navic = false,
    -- create_autocmd = false, -- prevent barbecue from updating itself automatically
    -- theme = {
    --   normal = { bg = vim.api.nvim_get_hl_by_name("SuliNC", true).background },
    --   -- these highlights represent the _text_ of three main parts of barbecue
    --   -- dirname = { fg = "#737aa2" },
    --   basename = { bold = false },
    --   context = {},
    -- }
  })
end
barbecueSetup()

-- vim.api.nvim_create_autocmd({
--   "ColorScheme"
--   -- "CursorMoved"
--   -- "TabEnter"
--   -- "WinResized",
--   -- "BufWinEnter",
--   -- "WinEnter",
--   -- "BufEnter",
--   -- "CursorHold",
--   -- "InsertLeave",
--   -- -- include these if you have set `show_modified` to `true`
--   -- "BufWritePost",
--   -- "TextChanged",
--   -- "TextChangedI",
-- }, {
--   group = vim.api.nvim_create_augroup("barbecue.updater", {}),
--   callback = function()
--     require("barbecue.ui").update()
--   end,
-- })

-- local lsp_navic = function(client, bufnr)
--   -- vim.cmd("echom 'naviiiiiiiiiiiic:'")
--   if not client.server_capabilities.documentSymbolProvider
--       or not vim.lsp then
--     return
--   end
--   -- vim.cmd[[echom "attach"]]
--   require("nvim-navic").attach(client, bufnr)
-- end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

-- local lsp_attach = function(client, bufnr)
--   lsp_navic(client, bufnr)
--   lsp_set_mappings(bufnr)
--   lsp_highlight_cursor_symbol(client, bufnr)
-- end

-- local handlers =  {
--   ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
--   ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
-- }

-- -- apply setup
-- local lsp_servers = require('mason-lspconfig').get_installed_servers()
-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local cmp = require('cmp_nvim_lsp')
-- local lspconfig = require('lspconfig')

-- for _, server_name in ipairs(lsp_servers) do
--   -- if server_name == "tsserver" then
--   --   lspconfig[server_name].setup({
--   --     -- on_attach = lsp_attach,
--   --     settings = {
--   --       documentFormatting = false,
--   --       documentInlayhint = false,
--   --     },
--   --     documentInlayHint = false,
--   --     flags = { debounce_text_change = 300 },
--   --     handlers = {["textDocument/InlayHint"] = ''},
--   --   })
--   -- else
--   -- print("lsp settup", server_name)
--   lspconfig[server_name].setup({
--     on_attach = lsp_attach,
--     capabilities = lsp_capabilities,
--     flags = { debounce_text_change = 300 },
--     cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
--     -- handlers=handlers
--   })
--   -- end
-- end

-- lspconfig.tsserver.setup({
--     on_attach = function(client, bufnr)
--         client.resolved_capabilities.document_formatting = false
--     end,
-- })

if lspconfig.tsserver then
  lspconfig.tsserver.setup({
    cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client)
      client.server_capabilities.document_formatting = false
      client.server_capabilities.diagnostic = false
    end,
  })
end

-- if lspconfig.eslint then
--   lspconfig.eslint.setup({
--     cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
--     on_attach = function(client)
--       client.server_capabilities.document_formatting = false
--       client.server_capabilities.diagnostic = false
--     end,
--   })
-- end

-- local cmp = require 'cmp'

local lspsaga = require("lspsaga")
lspsaga.setup({
  symbol_in_winbar = {
    enable = false,
  },
  ui = {
    code_action = "⁈",
  }
})

require 'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}
