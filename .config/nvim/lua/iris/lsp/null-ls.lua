local exist, null_ls = pcall(require, "null-ls")
if not exist then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local indentwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")

null_ls.setup({
  debug = false,
  sources = {
    formatting.black,
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    formatting.stylua.with({ extra_args = { "--indent-type", "spaces", "--indent-width", indentwidth } }),
    diagnostics.flake8,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
        augroup LspFormatting
          autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])
    end
  end,
})
