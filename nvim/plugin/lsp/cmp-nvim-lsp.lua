require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
  }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.ccls.setup {
  capabilities = capabilities,
}

require'lspconfig'.pyright.setup {
  capabilities = capabilities,
}

require'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
}
-- require'lspconfig'.sumneko_lua.setup{}
