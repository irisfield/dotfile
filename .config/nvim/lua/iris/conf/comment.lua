local exist, comment = pcall(require, "Comment")
if not exist then
  return
end

comment.setup {
  padding = true, -- add a space between leader and comment
  toggler = {
    -- mappings for normal and visual modes
    line = "gcc", -- single line comment
    block = "gbc" -- multiple lines comment
  },
  extra = {
    above = "gc0", -- add comment on the line above
    below = "gco", -- add comment on the line below
    eol = "gcA", -- add comment at the end of line
  },
  pre_hook = function(ctx)
    local present, tscc = pcall(require, "ts_context_commentstring.utils")
    if not present then
      return
    end
    local U = require "Comment.utils"

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = tscc.get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = tscc.get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
}
