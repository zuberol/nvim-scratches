local M = {}

--[[
usage:
newPopup({
	title = "package 'os' -> overview",
	data = os_overview,
	enter = true
})
--]]
M.new = function(opts)
	assert(#vim.api.nvim_list_uis() == 1, "more that one UI spotted")
	local ui = vim.api.nvim_list_uis()[1]

	local f_width = ui.width - 60
	local f_height = ui.height - 10
	local win_conf = {
		relative = 'editor',
		width = f_width,
		height = f_height,
		row = (ui.height / 2.0) - (f_height / 2.0),
		col = (ui.width / 2.0) - (f_width / 2.0),
		title = opts.title,
		border = "solid"
	}

	local buf = vim.api.nvim_create_buf(false, true)

	vim.schedule(function()
		assert(type(opts.data) == "function", "opts.data must be a function")
		vim.api.nvim_buf_set_lines(buf, 0, 1, false, opts.data())
		local win = vim.api.nvim_open_win(buf, opts.enter, win_conf)
		local curr_buffer = 0
		-- vim.wo[win][curr_buffer].colorcolumn = "80"
		vim.wo[win][curr_buffer].wrap = true
		vim.wo[win][curr_buffer].linebreak = true
		vim.wo[win][curr_buffer].breakindent = true
		-- vim.wo[win][curr_buffer].showbreak = "> "
		vim.print(vim.inspect(vim.api.nvim_win_get_config(win)))
	end)
end

return M
