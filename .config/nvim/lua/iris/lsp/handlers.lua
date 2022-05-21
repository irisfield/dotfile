-- any anything prefix with an M will be returned at the end
local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable in-line diagnostic (prefer as floating window)
    underline = false, -- underline the text with diagnostic errors
    severity_sort = true,
    update_in_insert = true,
    signs = {
      active = signs,
    },
    -- the floating window for diagnostic
    float = {
      focusable = false,
      style = "minimal",
      source = "always",
      border = "rounded",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local buf_set_keymap = vim.api.nvim_buf_set_keymap
  buf_set_keymap(bufnr, "n", ",h", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",D", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",f", "<cmd> Format<CR>", opts) -- from null-ls
  buf_set_keymap(bufnr, "n", ",h", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",R", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",c", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",p", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap(bufnr, "n", ",n", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  --buf_set_keymap(bufnr, "n", ",l", '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]])
end

-- show diagnostic popup on CursorHold
vim.cmd([[
autocmd CursorHold <buffer> lua vim.diagnostic.open_float()
]])

M.on_attach = function(client, bufnr)
  -- disable document_formatting for servers conflicting with null_ls
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local exist, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if exist then
  M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

return M
