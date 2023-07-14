vim.g.mapleader = " "

local keymap = vim.keymap

---------------------
-- General Keymaps --
---------------------

-- use kj to exit insert mode
keymap.set("i", "kj", "<esc>")

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

keymap.set("n", "<leader>d", '"_d', { desc = "Delete To Void Register" })
keymap.set("v", "<leader>d", '"_d', { desc = "Delete To Void Register" })

-- copy to system clipboard
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')

-- don't use Q
keymap.set("n", "Q", "<nop>")

-- Telescope
keymap.set("n", "<leader>ff", "<Cmd>Telescope find_files hidden=true<CR>", { desc = "Find Files" })
keymap.set("n", "<leader>fg", "<Cmd>Telescope git_files<CR>", { desc = "Find Git Files" })
keymap.set("n", "<leader>fs", "<Cmd>Telescope live_grep<CR>", { desc = "Find String" })
keymap.set("n", "<leader>fS", ":Telescope grep_string<CR>", { desc = "Find String Under Cursor" })
keymap.set("n", "<leader>fk", "<Cmd>Telescope keymaps<CR>", { desc = "Find Keymaps" })
keymap.set("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Find Buffers" })
keymap.set("n", "<leader>fw", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace Word Under Cursor" })

-- Toggle term
keymap.set("n", "<leader>gg", "<Cmd>lua Lazygit_toggle()<CR>", { desc = "Open LazyGit", noremap = true, silent = true })

-- NvimTree
keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>")

-- Buffer line
keymap.set("n", "<leader>bp", "<Cmd>BufferLineCyclePrev<CR>")
keymap.set("n", "<leader>bn", "<Cmd>BufferLineCycleNext<CR>")
keymap.set("n", "<leader>bd", "<Cmd>bd<CR>")

keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
keymap.set("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
keymap.set("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
keymap.set("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
keymap.set("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")

-- Dap
keymap.set("n", "<leader>dd", "<Cmd>lua require('dapui').toggle()<CR>")
keymap.set("n", "<leader>dh", "<Cmd>lua require('dap.ui.widgets').hover()<CR>")
keymap.set("n", "<leader>db", "<Cmd>DapToggleBreakpoint<CR>")
keymap.set("n", "<leader>dc", "<Cmd>DapContinue<CR>")
keymap.set("n", "<leader>dt", "<Cmd>DapTerminate<CR>")
keymap.set("n", "<leader>dS", "<Cmd>DapScopesExpand<CR>")
keymap.set("n", "<leader>dB", "<Cmd>DapBreakpointsExpand<CR>")
keymap.set("n", "<leader>dT", "<Cmd>DapStacksExpand<CR>")

keymap.set("n", "<F5>", "<Cmd>DapContinue<CR>")
keymap.set("n", "<F6>", "<Cmd>DapTerminate<CR>")
keymap.set("n", "<F1>", "<Cmd>DapStepOver<CR>")
keymap.set("n", "<F2>", "<Cmd>DapStepInto<CR>")
keymap.set("n", "<F3>", "<Cmd>DapStepOut<CR>")
