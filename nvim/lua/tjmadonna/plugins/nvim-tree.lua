local tree_setup, tree = pcall(require, "nvim-tree")
if not tree_setup then
	print("nvim-tree not found!")
	return
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

tree.setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		custom = {
			"node_modules",
			".DS_Store",
		},
	},
})
