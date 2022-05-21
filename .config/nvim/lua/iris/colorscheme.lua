-- Colorscheme must get called after plugins are loaded or it will break new installs.
vim.cmd [[
try
  colorscheme kanagawa
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
