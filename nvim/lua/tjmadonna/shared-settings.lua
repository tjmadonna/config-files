local M = {}

M.ignored_patterns = {
	"^env$",
	"^venv$",
	"^.pytest_cache$",
	"^.next$",
	"^node_modules$",
	"^.git$",
	"^obj$",
	".DS_Store",
}

return M
