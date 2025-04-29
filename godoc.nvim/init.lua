local M = {}
local popup = require'popup'

local function call_godoc(pkg)
	local cmd = { "godoc", "os" }
	local opts = { text = true }
	local res = vim.system(cmd, opts):wait()

	assert(res.code == 0, "bad code: " .. res.code)

	local lines = {}
	for s in res.stdout:gmatch("[^\r\n]+") do
		if s ~= "" then
			table.insert(lines, s)
		end
	end

	return lines
end

M.test = function ()
	popup.new {
		title = "package 'os' -> overview",
		data = function() return call_godoc("io") end,
		enter = true
	}
end
M.test()

return M
