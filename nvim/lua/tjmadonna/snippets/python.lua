local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
	s("docnumpy", {
		t({ '"""', "", "Parameters", "----------", "", "Returns", "-------", "", '"""' }),
	}),
}
