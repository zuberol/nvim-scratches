-- todo: attach autocmd only to qflist

local function onQflistSave(event)
	print(vim.inspect(event))
end

local group_opts = { clear = true }
local group = vim.api.nvim_create_augroup("zeauberg.on_qf_save", group_opts)
print("group:", vim.inspect(group))

local opts = {
	desc = "save qflist metadata",
	pattern = "*.qf",
	callback = onQflistSave,
	group = group,
}
vim.api.nvim_create_autocmd("BufWritePre", opts)
