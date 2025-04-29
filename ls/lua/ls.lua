local M = {}
local function scratch_redir(opts)
	-- vim.cmd.w { mods = { silent = true } }
	-- :redir @" | silent map | redir end | enew | put
	--	vim.fn['hehe#function'](opts)
	-- =vim.api.nvim_parse_cmd(":redir >> @\\\"", {})
	local out = vim.api.nvim_cmd({
		cmd = opts.fargs[1],
		mods = {
			silent = true
		}
	}, { output = true })
	lines = {}
	for s in out:gmatch("[^\r\n]+") do
		table.insert(lines, s)
	end

	vim.api.nvim_cmd(vim.api.nvim_parse_cmd(":redir END", {}), { output = false })
	vim.cmd("enew")
	vim.api.nvim_put(lines, "", false, true)
end

function M.setup()
	vim.api.nvim_create_user_command( 'Ls', scratch_redir, {
			nargs = '+',
			desc = "redirect <cmd> output to scratch buffer",
			bang = true,
			register = true
		}
	)
end

return M
