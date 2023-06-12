-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	print("packer not found!")
	return
end

-- have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	-- lua plugins that many plugins use
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")

	-- colorschemes
	use("folke/tokyonight.nvim")

	-- telescope
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.1", requires = { "nvim-lua/plenary.nvim" } })

	-- toggle terminal
	use("akinsho/toggleterm.nvim")

  -- nvim-tree
  use("nvim-tree/nvim-tree.lua")
  use("lewis6991/gitsigns.nvim", { tag = "release" })

	-- syntax highlighting
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- comment toggling with gc
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completion extension
	use("hrsh7th/cmp-path") -- path completion extension
	use("hrsh7th/cmp-cmdline") -- command line completion extension
	use("saadparwaiz1/cmp_luasnip") -- snippet completion extension
	use("hrsh7th/cmp-nvim-lsp") -- lsp completions extension

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of useful snippets

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/mason.nvim") -- simple to use language server installer
	use("williamboman/mason-lspconfig.nvim") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- LSP diagnostics and code actions

	-- copilot
	use("github/copilot.vim")

	-- harpoon
	use("theprimeagen/harpoon")

  -- debugging
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("folke/neodev.nvim")
  use("mxsdev/nvim-dap-vscode-js")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
