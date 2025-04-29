vim.cmd.messages("clear")
vim.print("hello file explorer plugin change")

-- local ret = vim.api.nvim_get_autocmds({ group = { "FileExplorer" } })
-- for index, au in ipairs(ret) do
-- 	vim.print(vim.inspect(au))
-- end

local aug = vim.api.nvim_create_augroup("FileExplorer", { clear = true})

-- rl callback = 
-- • id: (number) autocommand id
-- • event: (string) name of the triggered event
--   `autocmd-events`
-- • group: (number|nil) autocommand group id, if any
-- • match: (string) expanded value of <amatch>
-- • buf: (number) expanded value of <abuf>
-- • file: (string) expanded value of <afile>
-- • data: (any) arbitrary data passed from
--   `nvim_exec_autocmds()`                   

vim.api.nvim_create_autocmd({"BufEnter"}, {
	group = aug,
	desc = "Log is directory",
	callback = function (ev)

		vim.print("amatch: " .. ev.match)
		vim.print("buf number -> <abuf>: " .. ev.buf)
		vim.print("expanded absolute path -> <afile>: " .. ev.file)

		local dir_not_exists = vim.fn.isdirectory(ev.file) == 0
		if dir_not_exists then
			vim.print("is file or not exist on disc")
			return
		end

		-- SET SCRATCH BUFFER
		vim.api.nvim_set_option_value('buftype', 'nofile', { buf = ev.buf })

		-- RENDER
		local ret = vim.system({ "tree", "-a", ev.file }):wait()

		local content = {}
		local lines = string.gmatch(ret.stdout, "[^\r\n]+")
		for l in lines do
			table.insert(content, l)
		end

		vim.schedule(function ()
			vim.api.nvim_buf_set_lines(ev.buf, 0, 0, false, content)
		end)

	end
})

-- prevent loading a file
-- augroup LargeFile
--    au!
--    au BufReadCmd *.json echo "no you won't" | b# | bd#
-- augroup end

