vim.keymap.set("n", "<leader>cp", "<cmd>CopilotChatOpen<cr>", { desc = "Open Copilot Chat buffer" })

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "InsertEnter",
    tag = "v3.9.1",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      show_help = false,
      mappings = {
        close = {
          normal = "",
          insert = "",
        },
      },
    },
  },
}
