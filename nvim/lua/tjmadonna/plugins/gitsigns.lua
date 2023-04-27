local gitsigns_setup, gitsigns = pcall(require, "gitsigns")
if not gitsigns_setup then
	print("gitsigns not found!")
	return
end

gitsigns.setup()
