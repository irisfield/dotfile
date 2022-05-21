local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  -- Refer to (https://github.com/nvim-treesitter/nvim-treesitter#supported-languages).
  ensure_installed = {
    "bash",
    "c",
    -- "css",
    "comment",
    -- "commonlisp",
    "html",
    "http",
    "java",
    "json",
    "lua",
    "make",
    "python",
    "regex",
    "rust",
    "toml",
    "yaml",
  },
  sync_install = false, -- synchronously install the parsers specified in `ensure_installed`
  ignore_install = { "" }, -- list of parsers not to install
  autopairs = { enable = true },
  highlight = {
    enable = true, -- false will disable the extension
    disable = { "" }, -- list of languages to exclude from treesitter
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
