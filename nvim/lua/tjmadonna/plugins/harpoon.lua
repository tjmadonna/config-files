local harpoon_setup, harpoon = pcall(require, "harpoon")
if not harpoon_setup then
	print("harpoon not found!")
	return
end

harpoon.setup({})
