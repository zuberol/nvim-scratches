local curr_qf_errors = vim.fn.getqflist()

for i, v in ipairs(curr_qf_errors) do
	print(vim.inspect(v))
end
