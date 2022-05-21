local plugin_table = {
  -- Self-update
  { "wbthomason/packer.nvim" },

  -- Colorschemes
  { "rebelot/kanagawa.nvim" },

  -- Dependencies
  { "nvim-lua/plenary.nvim" }, -- library of lua functions (telescope)
  { "kyazdani42/nvim-web-devicons" }, -- collection of icons (nvim-tree)

  -- Aesthetic
  { "nvim-lualine/lualine.nvim" },

  -- Utilities
  { "windwp/nvim-autopairs" },
  { "numtoStr/Comment.nvim" }, -- syntax aware
  { "lewis6991/gitsigns.nvim" },
  { "kyazdani42/nvim-tree.lua" }, -- file explorer
  { "nvim-telescope/telescope.nvim" }, -- fuzzy finder
  { "akinsho/toggleterm.nvim" },

  -- LSP Related
  { "neovim/nvim-lspconfig" }, -- configurations for the neovim's built-in lsp
  { "williamboman/nvim-lsp-installer" }, -- simple to use language server installer
  { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
  {
    "nvim-treesitter/nvim-treesitter", -- syntax highlighting
    run = ":TSUpdate",
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" }, -- context aware
  { "simrat39/rust-tools.nvim" }, -- enable additional rust-analyzer features (inlay hints, etc)

  -- Completions Related
  { "L3MON4D3/LuaSnip" }, -- snippet engine
  { "hrsh7th/nvim-cmp" }, -- completion engine

  -- Completions Sources:
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Consider trying the plugins in the mini.nvim collection.
  -- Many plugins here replace many of my current ones.
  -- {
  --   "echasnovski/mini.nvim",
  --   branch = "stable",
  -- },
}

local exist, pack = pcall(require, "iris.packer")
if not exist then
  print("The plugin manager 'packer.nvim' is not installed. Plugins could not be loaded.")
  return
end

return pack.packer.startup(function(use)
  for _, plugin in ipairs(plugin_table) do
    use(plugin)
  end
  if pack.bootstrap then
    pack.packer.sync()
    print("Please restart neovim for changes to take effect.")
    vim.wait(2500, function()
      return false
    end)
  end
end)
