return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    { "windwp/nvim-ts-autotag", lazy = true },
  },
  config = function()
    require("nvim-treesitter").setup()
    require("nvim-ts-autotag").setup()

    -- Start native treesitter
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
