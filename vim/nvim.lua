--- ~/.vim/nvim.lua: Additional runtime configuration for `nvim`

-- Diagnostics

vim.diagnostic.config {
  virtual_text = false,
  float = {
    focusable = false, border = 'rounded', header = '', prefix = '• ',
  },
}

-- Language Server Protocol

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = 'rounded' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { border = 'rounded' }
)

-- nvim-lspconfig

local ok, lspconfig = pcall(require, 'lspconfig')
if ok then
  lspconfig.clangd.setup{}
end
