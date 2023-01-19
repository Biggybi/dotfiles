vim.keymap.set({ "n" }, "<leader>rr", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>")
-- -- Action:      Show treesitter capture group for textobject under cursor.
-- bindkey("n",    "<C-e>",
--     function()
--         local result = vim.treesitter.get_captures_at_cursor(0)
--         print(vim.inspect(result))
--     end,
--     { noremap = true, silent = false }
-- )

require("mason").setup({
  ui = {
    check_outdated_packages_on_open = true,
    border = "solid",
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
  }
})

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

-- do hover 'K' borders
local border = {
  { "┌", "FloatBorder" },
  { "─", "FloatBorder" },
  { "┐", "FloatBorder" },
  { "│", "FloatBorder" },
  { "┘", "FloatBorder" },
  { "─", "FloatBorder" },
  { "└", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- virtual text prefix character
vim.diagnostic.config({
  virtual_text = {
    prefix = '● ' -- Could be❙ ❝◉ ◎ ● ▎❚ ⌷ x■ ▢ ◽◾◆ ◇ ▰ ▱ ▶ ▷ ▸ ▹ ◊ ⧫ ♢
  }
})

local set_mappings = function(bufnr)
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_attach = function(client, bufnr)
  set_mappings(bufnr)
  lsp_highlight_cursor_symbol(client, bufnr)
end

-- apply setup
local lsp_servers = require('mason-lspconfig').get_installed_servers()
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
for _, server_name in ipairs(lsp_servers) do
  lspconfig[server_name].setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
    flags = { debounce_text_change = 300 }
  })
end

local cmp = require 'cmp'

-- λ  ∞  ⚙                                        
--                                             
--   n                                          
--                                             
--                 卑 謹 鉶 ﬥ  ﬦ  ﭨ  ﰟ  ﰩ  ﲹ  ﳒ  ﵂        𝝣
-- ⟚

local kind_icons = {
  Text = " ",
  Method = " ",
  Function = "ʩ ",
  Constructor = " ",
  Field = " ",
  Variable = "𝞌 ",
  Class = "ﴯ ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = "℃  ",
  Value = "𝞐 ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = ""
}

require("nvim-web-devicons").set_icon {
  file = {
    icon = kind_icons['File'],
    color = "#428850",
    cterm_color = "65",
    name = "file"
  },
  zsh = {
    icon = kind_icons['File'],
    color = "#ffffff",
    cterm_color = "65",
    name = "zsh"
  },
  bash = {
    icon = kind_icons['File'],
    color = "#ffffff",
    cterm_color = "65",
    name = "bash"
  },
  markdown = {
    icon = kind_icons['File'],
    color = "#ffffff",
    cterm_color = "65",
    name = "md"
  },
  md = {
    icon = kind_icons['File'],
    color = "#ffffff",
    cterm_color = "65",
    name = "markdown"
  },
}

local cmp_border = { "┌", "─", "┐", "│", "┘", "─", "└", "│", }

cmp.setup({
  formatting = {
    mode = "text_symbol",
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  PreselectMode = 2,
  -- window = {
  --   -- completion = cmp.config.window.bordered(),
  --   -- documentation = cmp.config.window.bordered(),
  --   completion.border = cmp_border,
  --   documentation.border = cmp_border,
  -- },
  window = {
    completion = {
      border = 'single',
      style = 'winhighlight',
      cmp_border
    },
    documentation = {
      border = 'single',
      style = 'winhighlight',
    },
  },
  cmp_select = { behavior = cmp.SelectBehavior.Select },
  mapping = {
    ['<c-d>'] = cmp.mapping.scroll_docs(4),
    ['<c-u>'] = cmp.mapping.scroll_docs(-4),
    ['<c-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<c-o>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ['<c-space>'] = function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        cmp.complete()
      end
    end,
    ['<c-k>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end,
    ['<c-j>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    { name = 'ultisnips' }, -- For ultisnips users.
    { name = 'path' },
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- -- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--     { name = 'ultisnips' },
--   }, {
--       { name = 'buffer' },
--     })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline({}),
  -- mapping = cmp.mapping.preset.cmdline({
  --   ['<tab>'] = function(fallback)
  --     if cmp.visible() then
  --       cmp.confirm({ select = true })
  --     else
  --       cmp.complete()
  --     end
  --   end,
  --   ['<C-Space>'] = function(fallback)
  --     if cmp.visible() then
  --       cmp.confirm({ select = true })
  --     else
  --       cmp.complete()
  --     end
  --   end,
  -- }),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
