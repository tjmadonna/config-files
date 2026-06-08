-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- use kj to exit insert mode
keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode" })

-- clear search highlights
keymap.set("n", "<Leader>nh", "<Cmd>nohl<CR>", { desc = "Clear search highlights", silent = true })

-- toggle listchars
keymap.set("n", "<Leader>lt", "<Cmd>setlocal list!<CR>", { desc = "Toggle listchars" })

-- move block of code
keymap.set("v", "J", "<Cmd>m '>+1<CR>gv=gv", { desc = "Move block of code down" })
keymap.set("v", "K", "<Cmd>m '<-2<CR>gv=gv", { desc = "Move block of code up" })

-- append below line to current line with a space
keymap.set("n", "J", "mzJ`z", { desc = "Append below line to current line with a space" })

-- half page jumping with cursor in same spot
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump half a page down while keeping cursor in same spot" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump half a page up while keeping cursor in same spot" })

-- keep search term in middle when searching
keymap.set("n", "n", "nzzzv", { desc = "Keep search term in middle when searching" })
keymap.set("n", "N", "Nzzzv", { desc = "Keep search term in middle when searching" })

-- search and replace word under cursor
keymap.set("n", "<Leader>sr", "<Cmd>%s/<C-r><C-w>//g<left><left>", { desc = "Search and replace word under cursor" })
keymap.set("v", "<Leader>sr", "<Esc><Cmd>%s/\\%V<C-r><C-w>//g<left><left>", { desc = "Search and replace word under cursor" })

-- copy, paste over something but maintain copied text
keymap.set("x", "<Leader>p", '"_dP', { desc = "Copy and paste over something but maintain copied text" })

keymap.set({ "n", "v" }, "<Leader>d", '"_d', { desc = "Delete To Void Register" })

-- copy to system clipboard
keymap.set("n", "<Leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("v", "<Leader>y", '"+y', { desc = "Copy to system clipboard" })

-- don't use Q
keymap.set("n", "Q", "<Nop>")

-- window sizing
keymap.set("n", "<C-w><C-k>", "<Cmd>resize -3<CR>", { desc = "Resize Window Up", noremap = true, silent = true })
keymap.set("n", "<C-w><C-j>", "<Cmd>resize +3<CR>", { desc = "Resize Window Down", noremap = true, silent = true })
keymap.set("n", "<C-w><C-h>", "<Cmd>vertical resize +3<CR>", { desc = "Resize Window Left", noremap = true, silent = true })
keymap.set("n", "<C-w><C-l>", "<Cmd>vertical resize -3<CR>", { desc = "Resize Window Right", noremap = true, silent = true })

-- tmux-sessionizer
keymap.set("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux-sessionizer", noremap = true, silent = true })
