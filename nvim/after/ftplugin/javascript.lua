local opt = vim.opt
opt.colorcolumn = "100"
opt.formatoptions:remove({ "c", "r", "o" }) -- Stop newline continution of comments
opt.tabstop = 4
opt.shiftwidth = 4
