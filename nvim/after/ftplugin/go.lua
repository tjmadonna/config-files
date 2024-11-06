local opt = vim.opt
opt.colorcolumn = "120"
opt.formatoptions:remove({ "c", "r", "o" }) -- Stop newline continution of comments
opt.tabstop = 4
opt.shiftwidth = 4
