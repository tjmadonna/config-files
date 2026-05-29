local opt = vim.opt_local
opt.colorcolumn = "140"
opt.tabstop = 2
opt.shiftwidth = 2
opt.formatoptions:remove({ "c", "r", "o" }) -- Stop newline continution of comments
