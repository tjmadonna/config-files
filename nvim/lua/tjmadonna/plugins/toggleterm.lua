local toggleterm_setup, toggleterm = pcall(require, "toggleterm")
if not toggleterm_setup then
	print("toggleterm not found!")
	return
end

toggleterm.setup({
	direction = "float",
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

-- Lazy git
function lazygit_toggle()
  lazygit:toggle()
end
