vim.g.nightflyCursorColor = 1 -- set cursor color to nightfly
vim.g.nightflyTransparent = 1 -- set background to transparent

local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
	print("could not set colorscheme") -- print error if colorscheme not installed
	return
end

function ColorBackground()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorBackground()
