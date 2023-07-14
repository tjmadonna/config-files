local toggleterm = require("toggleterm")

toggleterm.setup({
  direction = "float",
  open_mapping = [[<c-\>]],
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

-- Lazy git
function Lazygit_toggle()
  lazygit:toggle()
end
