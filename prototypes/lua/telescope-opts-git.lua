local M = {}

local function git_root()
	local out = vim.fn.system("git rev-parse --show-toplevel")
	local error = vim.v.shell_error
	local ret = nil
	if error == 0 then
		ret = string.gsub(out, '\n', '')
	elseif error == 128 then
		local msg = table.concat { "pwd not inside git repo.", " cwd: ", vim.fn.getcwd() }
		vim.api.nvim_notify(msg, vim.log.levels.DEBUG, {})
	else
		vim.api.nvim_err_writeln(out)
	end
	return ret
end
vim.cmd([[message clear]])

function M.git_root_or_cwd()
	local root, _ = git_root()
	return root or vim.fn.getcwd(), root ~= nil
end

local function search_opts_of(init)
	local opts = vim.deepcopy(init or {})
	local defaults = {
		hidden = false,
		layout_config = { prompt_position = "bottom" },
		--search_dirs = { vim.fn.expand("/Users/jzuber/Documents/chaos") },
	}
	function opts.cwd_in_repo()
		if is_git_repo() then
			opts.cwd = git_root()
		else
			vim.notify("zeauberg - not a git repo, leaving cwd as it was", vim.log.levels.DEBUG)
		end
		return opts
	end

	return setmetatable(opts, { __index = defaults }), init
end

return M
