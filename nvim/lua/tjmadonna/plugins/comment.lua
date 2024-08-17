return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
	},
	config = function()
		local comment = require("Comment")

    -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
    require("ts_context_commentstring").setup({})

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		comment.setup({
			-- for commenting tsx and jsx files
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})
	end,
}
