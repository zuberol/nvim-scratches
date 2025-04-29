local function os_overview()
	local cmd = { "go", "doc", "-short", "os" }
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
