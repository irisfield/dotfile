-- For available settings, please refer to:
-- (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua)
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- get the language server to recognize the `vim` global
      },
      workspace = {
        library = {
          -- make the server aware of the following paths
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      telemetry = { enable = false },
    },
  },
}
