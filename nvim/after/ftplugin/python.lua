local opt = vim.opt
opt.colorcolumn = "88"
opt.formatoptions:remove({ "c", "r", "o" }) -- Stop newline continution of comments
