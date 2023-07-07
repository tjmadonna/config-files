local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v2.x",
  --   dependencies = { 
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "lewis6991/gitsigns.nvim",
  --     "MunifTanjim/nui.nvim",
  --   }
  -- },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
  },
  {
    "akinsho/toggleterm.nvim"
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    "nvim-treesitter/nvim-treesitter", run = ":TSUpdate"
  },
  {
    "hrsh7th/nvim-cmp",               -- autocompletion
    dependencies = {
      "hrsh7th/cmp-buffer",           -- buffer completion extension
      "hrsh7th/cmp-path",             -- path completion extension
      "hrsh7th/cmp-cmdline",          -- command line completion extension
      "saadparwaiz1/cmp_luasnip",     -- snippet completion extension
      "hrsh7th/cmp-nvim-lsp",         -- lsp completions extension
      "L3MON4D3/LuaSnip",             -- snippet engine
      "rafamadriz/friendly-snippets", -- a bunch of useful snippets
    }
  },
  {
    "github/copilot.vim",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    }
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    }
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
	    "folke/neodev.nvim",
	    "mxsdev/nvim-dap-vscode-js",
    },
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure()
    end
  },
})
