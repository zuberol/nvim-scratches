local M = {}

function M.hi_cword()
	local cword = vim.fn.expand("<cword>")
	local is_word = string.find(cword, "%g")
	if is_word then
		--			print("match" .. os.clock())
		vim.cmd("match Search /" .. cword .. "/")
	else
		--print("no match" .. os.clock())
	end
end

return M
