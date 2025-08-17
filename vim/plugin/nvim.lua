--- ~/.vim/nvim.lua: Additional runtime configuration for `nvim`

-- Diagnostic

vim.diagnostic.config {
  jump = {
    wrap = vim.api.nvim_get_option_value('wrapscan', {}),
  },
  float = {
    border = 'rounded', focusable = false, header = '', prefix = '• ',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
  virtual_text = false,
}

-- -- Synchronize vim.diagnostic.jump(wrap = ...) with &wrapscan
-- vim.api.nvim_create_autocmd('OptionSet', {
--   pattern = { 'wrapscan' },
--   group = vim.api.nvim_create_augroup('diagnostic', { clear = true }),
--   callback = function()
--     vim.diagnostic.config { jump = { wrap = vim.v.option_new } }
--   end,
-- })

-- Map ]d, [d, ]D, and [D to vim.diagnostic.jump() in n, x, and o modes
for mode, float in pairs { n = true, x = false, o = false } do
  vim.keymap.set(mode, ']d', function()
    -- vim.diagnostic.jump { count = vim.v.count1, float = float }
    vim.diagnostic.goto_next {
      count = vim.v.count1, float = float, wrap = vim.o.wrapscan
    }
  end, { desc = 'Jump to the next diagnostic in the current buffer' })

  vim.keymap.set(mode, '[d', function()
    -- vim.diagnostic.jump { count = -vim.v.count1, float = float }
    vim.diagnostic.goto_prev {
      count = vim.v.count1, float = float, wrap = vim.o.wrapscan
    }
  end, { desc = 'Jump to the previous diagnostic in the current buffer' })

  vim.keymap.set(mode, ']D', function()
    -- local count = 2 ^ 32 - 1
    -- vim.diagnostic.jump { count = count, float = float, wrap = false }

    local count = 2 ^ 32 - 1
    vim.diagnostic.goto_next { count = count, float = float, wrap = false }
  end, { desc = 'Jump to the last diagnostic in the current buffer' })

  vim.keymap.set(mode, '[D', function()
    -- local count = -(2 ^ 32)
    -- vim.diagnostic.jump { count = count, float = float, wrap = false }

    local count = 2 ^ 32 - 1
    vim.diagnostic.goto_prev { count = count, float = float, wrap = false }
  end, { desc = 'Jump to the first diagnostic in the current buffer' })
end

vim.keymap.set('n', '<Space>e', function()
  vim.diagnostic.open_float()
end, { desc = 'Show diagnostics under the cursor' })

vim.keymap.set('n', 'sd', function()
  vim.diagnostic.open_float()
end, { desc = 'Show diagnostics under the cursor' })

-- Language Server Protocol

-- Set window defaults for hover() and signature_help()
for _, name in ipairs { 'hover', 'signature_help' } do
  local defaults = { border = 'rounded', focusable = false }
  local origin = vim.lsp.buf[name]
  vim.lsp.buf[name] = function(opts)
    return origin(vim.tbl_extend('force', defaults, opts or {}))
  end
end

vim.keymap.set('n', 'grn', function()
  vim.lsp.buf.rename()
end, { desc = 'vim.lsp.buf.rename()' })

vim.keymap.set({ 'n', 'x' }, 'gra', function()
  vim.lsp.buf.code_action()
end, { desc = 'vim.lsp.buf.code_action()' })

vim.keymap.set('n', 'grr', function()
  vim.lsp.buf.references()
end, { desc = 'vim.lsp.buf.references()' })

vim.keymap.set('n', 'gri', function()
  vim.lsp.buf.implementation()
end, { desc = 'vim.lsp.buf.implementation()' })

vim.keymap.set('n', 'grt', function()
  vim.lsp.buf.type_definition()
end, { desc = 'vim.lsp.buf.type_definition()' })

vim.keymap.set('n', 'gO', function()
  vim.lsp.buf.document_symbol()
end, { desc = 'vim.lsp.buf.document_symbol()' })

vim.keymap.set({ 'i', 's' }, '<C-S>', function()
  vim.lsp.buf.signature_help()
end, { desc = 'vim.lsp.buf.signature_help()' })

vim.keymap.set('n', 'grd', function()
  vim.lsp.buf.declaration()
end, { desc = 'vim.lsp.buf.definition()' })

vim.keymap.set('n', 'grD', function()
  vim.lsp.buf.declaration()
end, { desc = 'vim.lsp.buf.declaration()' })

-- nvim-lspconfig

local ok, lspconfig = pcall(require, 'lspconfig')
if ok then
  lspconfig.clangd.setup {}
end

-- nvim-treesitter

local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if ok then
  treesitter.setup {
    highlight = { enable = true },
  }
end
