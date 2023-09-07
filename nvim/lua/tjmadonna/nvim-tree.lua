local colors = require("tjmadonna.gruvbox")

vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = colors.dark3 })

local function title(path)
	-- local cwd = vim.fn.getcwd(0)
	local cwd = path
	local dir = vim.fn.split(cwd, "/")
	return vim.fn.toupper(dir[#dir])
end

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-c>", api.tree.close, opts("Close"))
end

require("nvim-tree").setup({
	on_attach = on_attach,
	sort_by = "case_sensitive",
	view = {
		signcolumn = "no",
		width = "15%",
	},
	renderer = {
		root_folder_label = title,
		icons = {
			show = {
				file = true,
				folder = false,
				folder_arrow = true,
				git = true,
				modified = true,
			},
		},
	},
	filters = {
		custom = {
      "^env$",
      "^venv$",
      "^.pytest_cache$",
      "^.next$",
      "^node_modules$",
      "^.git$",
      "^obj$",
      ".DS_Store",
    },
	},
	git = {
		ignore = false,
	},
})
