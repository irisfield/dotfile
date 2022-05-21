local bootstrap = false
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = vim.fn.stdpath("data") .. "/site/pack/packer/packer_compiled.lua"

-- automatically install the package manager
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  bootstrap = vim.fn.system({
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path
  })
  vim.cmd("packadd packer.nvim")
end

local exist, packer = pcall(require, "packer")
if not exist then
  return
end

-- packer configuration
packer.init({
  compile_path = compile_path,
  git = {
    clone_timeout = 500, -- timeout for git clones in seconds
    subcommands = {
      -- more efficient than packer's default
      fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
    },
  },
  max_jobs = 50, -- limit the number of simultaneous jobs
  display = {
    open_fn = function()
      -- open a popup window for packer's display
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return {
  packer = packer,
  bootstrap = bootstrap,
}
