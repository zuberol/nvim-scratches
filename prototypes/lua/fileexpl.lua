vim.cmd.messages("clear")
-- vim.print("hello file explorer plugin change")

-- ref -> /usr/share/nvim/runtime/plugin/netrwPlugin.vim

-- local ret = vim.api.nvim_get_autocmds({ group = { "FileExplorer" } })
-- for index, au in ipairs(ret) do
-- 	vim.print(vim.inspect(au))
-- end


-- rl callback =
-- • id: (number) autocommand id
-- • event: (string) name of the triggered event
--   `autocmd-events`
-- • group: (number|nil) autocommand group id, if any
-- • match: (string) expanded value of <amatch>
-- • buf: (number) expanded value of <abuf>
-- • file: (string) expanded value of <afile>
-- • data: (any) arbitrary data passed from

vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
	pattern = "*",
	callback = function(ev)
		vim.print("is dir -> ", ev)

		if ev.data.is_dir then
			-- RENDER
			-- local ret = vim.system({ "find", ev.file }):wait()
			local ret = vim.system({ "tree", '-a' }):wait()

			local content = {}
			local lines = string.gmatch(ret.stdout, "[^\r\n]+")
			for l in lines do
				table.insert(content, l)
			end

			vim.schedule(function()
				vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, content)
				-- vim.api.nvim_set_option_value('buftype', 'nofile', { buf = ev.buf })
			end)
		end
	end
})

vim.api.nvim_create_autocmd({
	-- "BufNewFile",
	"BufNew",
	-- "BufRead",
	-- "BufReadPost",
	-- "BufReadPre",
	-- "BufWrite",
	-- "BufWriteCmd",
	-- "BufWritePre",
	-- "BufWritePost",
	-- "BufReadCmd",
	-- "BufFilePre",
	-- "BufFilePost",
	-- "FileAppendPost",
}, {
	-- group = aug,
	desc = "debugging info",
	-- pattern = "*/",
	callback = function(ev)
		local is_directory = vim.fn.isdirectory(ev.file) == 1
		if is_directory then
			vim.api.nvim_exec_autocmds("BufReadCmd", {
				data = { is_dir = true },
				pattern = ev.file
			})
		end
	end,
})


if true then
	return
end

-- vim.api.nvim_create_autocmd({
-- 	"BufNew",
-- }, {
-- 	-- group = aug,
-- 	desc = "debugging info",
-- 	callback = function (ev)
-- 		vim.print(vim.inspect(ev))
-- 	end
-- })


local aug = vim.api.nvim_create_augroup("FileExplorer", { clear = true })
local dir_prefix = 'dir://'

vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
	group = aug,
	pattern = "*",
	callback = function(ev)
		vim.print('tester here 2', vim.inspect(ev))
	end
})

vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
	group = aug,
	pattern = dir_prefix .. "*",
	callback = function(ev)
		vim.print('tester here 3', vim.inspect(ev))
		local fname = string.gsub(ev.file, "^" .. dir_prefix, "", 1)
		local ret = vim.system({ "find", fname }):wait()

		local content = {}
		local lines = string.gmatch(ret.stdout, "[^\r\n]+")
		for l in lines do
			table.insert(content, l)
		end

		vim.schedule(function()
			vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, content)
			-- vim.api.nvim_set_option_value('buftype', 'nofile', { buf = ev.buf })
		end)
	end
})

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
	group = aug,
	once = false,
	callback = function(ev)
		vim.print("hello pre: ", vim.inspect(ev))
		local bname = vim.api.nvim_buf_get_name(ev.buf)
		if bname == "" then
			return
		end

		local dir_not_exists = vim.fn.isdirectory(ev.file) == 0
		if dir_not_exists then
			vim.print("is file or not exist on disc")
			return
		end
		ev.file = dir_prefix .. ev.file

		vim.api.nvim_buf_set_name(ev.buf, dir_prefix .. ev.file)
	end
})

-- BufEnter
vim.api.nvim_create_autocmd({ "BufNew" }, {
	group = aug,
	desc = "Log is directory",
	once = false,
	callback = function(ev)
		vim.print("amatch: " .. ev.match)
		vim.print("buf number -> <abuf>: " .. ev.buf)
		vim.print("expanded absolute path -> <afile>: " .. ev.file)

		if true then
			return
		end
		local dir_not_exists = vim.fn.isdirectory(ev.file) == 0
		if dir_not_exists then
			vim.print("is file or not exist on disc")
			return
		end

		-- SET SCRATCH BUFFER
		-- vim.api.nvim_set_option_value('buftype', 'nofile', { buf = ev.buf })

		-- RENDER
		-- local ret = vim.system({ "tree", "-a", ev.file }):wait()
		local ret = vim.system({ "find", "." }):wait()

		local content = {}
		local lines = string.gmatch(ret.stdout, "[^\r\n]+")
		for l in lines do
			table.insert(content, l)
		end

		vim.schedule(function()
			vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, content)
			-- vim.api.nvim_set_option_value('buftype', 'nofile', { buf = ev.buf })
		end)
	end
})
