local opt = vim.opt
opt.colorcolumn = "80"
opt.formatoptions:remove({ "c", "r", "o" }) -- Stop newline continution of comments
