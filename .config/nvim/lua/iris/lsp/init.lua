local exist, lspconfig = pcall(require, "lspconfig")
if not exist then
  return
end

require("iris.lsp.null-ls")
require("iris.lsp.installer")
require("iris.lsp.handlers").setup()

lspconfig.jdtls.setup({})
