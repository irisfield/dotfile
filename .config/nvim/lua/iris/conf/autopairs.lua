local exist, npairs = pcall(require, "nvim-autopairs")
if not exist then
  return
end

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" }, -- run ":echo &ft" to get filetype
  fast_wrap = {
    map = "<M-a>", -- alt + e
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

-- hook autopairs into cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local cmp_exist, cmp = pcall(require, "cmp")
if not cmp_exist then
  return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
