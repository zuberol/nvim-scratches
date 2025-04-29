local M = {}

function M.with_tilde(path)
	assert(type(path) == "string")
	local ret = nil
	if string.match(path, "^~") then
		return ret
	end
	local home = vim.fn.environ()["HOME"]
	assert(home ~= nil)
	assert(string.match(path, "^/.*"), "should be absolute, was: '" .. path .. "'")
	ret = string.gsub(path, "^"..home, "~")
	return ret
end

return M
