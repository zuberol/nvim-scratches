local devGroupId = vim.api.nvim_create_augroup("zeauberg-dev", {})

vim.print("hello scratches/autocmd.lua")

local quickFixBuf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_option(quickFixBuf, "buftype", "quickfix")
vim.api.nvim_buf_set_option(quickFixBuf, "swapfile", false)
--vim.api.nvim_buf_set_option(quickFixBuf, "readonly", true)

local tests = {}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = devGroupId,
	pattern = "*_test.go",
	desc = "run tests on save",
	callback = function(data)
		local msg = "running " .. data.file .. " after " .. data.event .. "event received"
		vim.notify(msg, vim.log.levels.INFO, {})
		local runTest = { "go", "test", "./...", "-json" }

		local logResult = function(_, data, streamName)
			local msg = "out from: " .. streamName
	--		print(vim.inspect(data))
			vim.notify(msg, vim.log.levels.INFO, {})
			tests = data
		end

		vim.fn.jobstart(runTest, {
			on_exit = function ()
				--vim.cmd('copen') or vim.cmd('cwindow')
--vim.fn.setqflist()
				vim.api.nvim_buf_set_text(quickFixBuf, 0, 0, 0, 0, tests)
				vim.cmd('copen')
			end,
			stderr_buffered = true,
			stdout_buffered = true,
			on_stdout = logResult,
			on_stderror = logResult
		})
	end
})

--[[
vim.api.nvim_create_namespace(name)

vim.api.nvim_create_buf(listed, scratch) TODO later

vim.fn.win_gettype(nr?)

vim.fn.winline()
vim.fn.winline()
--]]
--




