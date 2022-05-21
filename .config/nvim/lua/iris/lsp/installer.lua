local exist, lsp_installer = pcall(require, "nvim-lsp-installer")
if not exist then
  return
end

local servers = {
  "bashls",
  "jdtls",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
}

for _, name in pairs(servers) do
  local found, server = lsp_installer.get_server(name)
  if found then
    if not server:is_installed() then
      server:install()
    end
  end
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead.
-- lsp_installer.on_server_ready(function(server)
--   local opts = {
--     on_attach = require("iris.lsp.handlers").on_attach,
--     capabilities = require("iris.lsp.handlers").capabilities,
--   }
--
--   if server.name == "jdtls" then
--     local jdtls_opts = require("iris.lsp.settings.jdtls")
--     opts = vim.tbl_deep_extend("force", jdtls_opts, opts)
--   end
--
--   if server.name == "pyright" then
--     local pyright_opts = require("iris.lsp.settings.pyright")
--     opts = vim.tbl_deep_extend("force", pyright_opts, opts)
--   end
--
--   if server.name == "rust_analyzer" then
--     local rust_analyzer_opts = require("iris.lsp.settings.rust_analyzer")
--     opts = vim.tbl_deep_extend("force", rust_analyzer_opts, opts)
--   end
--
--   if server.name == "sumneko_lua" then
--     local sumneko_opts = require("iris.lsp.settings.sumneko_lua")
--     opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
--   end
--
--   -- This setup() function is exactly the same as lspconfig's setup function.
--   -- See (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
--   server:setup(opts)
-- end)
