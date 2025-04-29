if vim.g.zeauberg.packages == nil or not vim.g.zeauberg.packages.enabled then
	vim.print("ls off")
	return
end

function Ls_packages()
	-- TODO REFACTOR
	-- open centered float
	assert(#vim.api.nvim_list_uis() == 1, "more that one UI spotted")
	local ui = vim.api.nvim_list_uis()[1]

	local f_width = ui.width - 20
	local f_height = ui.height - 10
	local win_conf = {
		relative = 'editor',
		width = f_width,
		height = f_height,
		row = (ui.height / 2.0) - (f_height / 2.0),
		col = (ui.width / 2.0) - (f_width / 2.0),
		title = "packages",
		border = "solid"
	}

	local opts = {
		enter = true,
		win_cfg = win_conf
	}

	local cmd = { "go", "list", "std" }
	local cmd_opts = {
		text = true
	}

	local ret = vim.system(cmd, cmd_opts)
	local completed = ret:wait()

	assert(completed.code == 0, completed.stderr)
	local packages = vim.split(completed.stdout, "\n")

	local buf = vim.api.nvim_create_buf(false, true)

	vim.schedule(function()
		vim.api.nvim_buf_set_lines(buf, 0, 0, false, packages)
		local _ = vim.api.nvim_open_win(buf, opts.enter, opts.win_cfg)
	end)
end

local function doc_cmd(param)
	assert(#param.fargs == 1, "package required")
	local package = param.fargs[1]
	Ls_packages()
end

local function doc_cmd_complete(args)
	local cmd = { "go", "list", "std" }
	local cmd_opts = {
		text = true
	}
	local ret = vim.system(cmd, cmd_opts)
	local completed = ret:wait()

	return vim.split(completed.stdout, "\n", { trimempty = true })
end

local doc_cmd_opts = {
	force = true,
	desc = 'usage: ":Doc os"',
	complete = doc_cmd_complete,
	nargs = "+"
}

vim.api.nvim_create_user_command("Doc", doc_cmd, doc_cmd_opts)
