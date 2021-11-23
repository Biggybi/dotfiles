local cmp = require'cmp'

local press = function(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },

  mapping = {
    ["<C-Space>"] = cmp.mapping(function(fallback)
      if cmp.get_selected_entry() == nil and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
        -- cmp.mapping.complete()
      elseif cmp.get_selected_entry() == nil then
        cmp.select_next_item()
      elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
      else
        fallback()
      end
    end, {
    "i",
    "s",
    "c",
  }),
  ["<c-j>"] = cmp.mapping(function(fallback)
    if cmp.visible() == 0 then
      cmp.select_next_item()
    elseif cmp.get_selected_entry() == nil then
      cmp.select_next_item()
    elseif cmp.visible() then
      cmp.select_next_item()
    else
      fallback()
    end
  end, {
  "i",
  "s",
  -- "c",
}),
["<c-k>"] = cmp.mapping(function(fallback)
  if cmp.get_selected_entry() == nil then
    cmp.select_prev_item()
  elseif cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end, {
"i",
"s",
-- "c",
  }),
  ["<c-f>"] = cmp.mapping(function(fallback)
    if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
      press("<ESC>:call UltiSnips#JumpForwards()<CR>")
    else
      fallback()
    end
  end, {
  "i",
  "s",
}),
["<c-b>"] = cmp.mapping(function(fallback)
  if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
    press("<ESC>:call UltiSnips#JumpBackwards()<CR>")
  else
    fallback()
  end
end, {
"i",
"s",
  }),
  ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-e>'] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
},

sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'ultisnips' }, -- For ultisnips users.
  { name = 'buffer' },
})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
    { name = 'cmdline' },
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }
