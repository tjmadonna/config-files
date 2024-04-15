return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    local keymap = vim.keymap -- for conciseness
    local toggle_opts = {
      border = "rounded",
      title_pos = "center",
      ui_width_ratio = 0.6,
    }

    keymap.set("n", "<leader>ht", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })

    keymap.set("n", "<leader>hh", function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
    end, { desc = "Open harpoon window" })

    keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Add current file to harpoon" })

    for i = 1, 9 do
      keymap.set("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end, { desc = "Select harpoon item " .. i })
    end

    keymap.set("n", "<leader>hp", function()
      harpoon:list():prev()
    end, { desc = "Select previous harpoon item" })

    keymap.set("n", "<leader>hn", function()
      harpoon:list():next()
    end, { desc = "Select next harpoon item" })

    harpoon:extend({
      UI_CREATE = function(cx)
        keymap.set("n", "<C-v>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })
        keymap.set("n", "<C-s>", function()
          harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr })
        keymap.set("n", "<C-c>", function()
          harpoon.ui:close_menu()
        end, { buffer = cx.bufnr })
      end,
    })
  end,
}
