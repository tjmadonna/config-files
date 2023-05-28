vim.g.mapleader = " "

local keymap = vim.keymap

--------------------
-- General Keymaps
----------------------

-- use kj to exit insert mode
keymap.set("i", "kj", "<esc>")

-- open the project viwer
-- keymap.set("n", "<leader>pv", ":Ex<cr>")
keymap.set("n", "<leader>pv", ":NvimTreeToggle<cr>")

-- find string in current working directory as you type
keymap.set("n", "<leader>ps", "<cmd>Telescope live_grep<cr>")

-- move block of code
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append below line to current line with a space
keymap.set("n", "J", "mzJ`z")

-- half page jumping with cursor in same spot
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search term in middle when searching
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- copy, paste over something but maintain copied text
keymap.set("x", "<leader>p", '"_dP')

-- delete to void register
keymap.set("n", "<leader>d", '"_d')
keymap.set("v", "<leader>d", '"_d')

-- copy to system clipboard
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')

-- don't use Q
keymap.set("n", "Q", "<nop>")

-- create a small tmux pane
keymap.set("n", "<leader>tj", "<cmd>silent !tmux split-window -vl 10<CR>")
keymap.set("n", "<leader>tl", "<cmd>silent !tmux split-window -hl 40<CR>")

-- switch project using tmux
-- keymap.set("n", "<C-f>", "<cmd>silent !tmux tmux-sessionizer<CR>")

-- harpoon keymaps
keymap.set("n", "<leader>pe", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>")
keymap.set("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
keymap.set("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
keymap.set("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
keymap.set("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
keymap.set("n", "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>")
keymap.set("n", "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>")
keymap.set("n", "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(7)<CR>")
keymap.set("n", "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(8)<CR>")

-- git keymaps
keymap.set("n", "<leader>gg", "<cmd>Git<CR>")
keymap.set("n", "<leader>gv", "<cmd>GV<CR>")
keymap.set("n", "<leader>gf", "<cmd>GV!<CR>")
keymap.set("n", "<leader>gd", "<cmd>GV!<CR>")

-- dap keymaps
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<leader>b", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>B", function()
	require("dap").set_breakpoint()
end)
-- vim.keymap.set("n", "<leader>lp", function()
-- 	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
-- end)
vim.keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end)
vim.keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end)
vim.keymap.set("n", "<leader>dc", function()
	require("dap").terminate()
end)
vim.keymap.set({ "n", "v" }, "<leader>dh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<leader>dp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.sidebar(widgets.frames).toggle()
end)
vim.keymap.set("n", "<leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.sidebar(widgets.scopes).toggle()
end)
vim.keymap.set("n", "<leader>du", function()
	local widgets = require("dap.ui.widgets")
	widgets.sidebar(widgets.scopes).toggle()
end)
