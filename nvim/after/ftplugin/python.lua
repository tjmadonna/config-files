local opt = vim.opt_local
opt.colorcolumn = "88,100"
opt.formatoptions:remove({ "c", "r", "o" }) -- Stop newline continution of comments
