local term_setup, term = pcall(require, "toggleterm")
if not term_setup then
	print("toggleterm not found!")
	return
end

term.setup({
	size = 20,
	open_mapping = [[<c-t>]],
	hide_numbers = true,
})
