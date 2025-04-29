local utils = {}

ToggleDiagnostic = {
	cached_cfg = vim.diagnostic.config(),
	hide_all = false
}

local function install_toggle_diagnostic()
	vim.api.nvim_create_user_command("ToggleDiagnostic", function()
		local cfg = vim.diagnostic.config()
		assert(cfg ~= nil)
		if ToggleDiagnostic.hide_all then
			vim.diagnostic.config({
				virtual_lines = false,
				virtual_text = false,
				signs = false,
				underline = false
			})
		else
			vim.diagnostic.config(ToggleDiagnostic.cached_cfg)
		end
	end, { desc = "Hide all vim.diagnostic from ui", force = false })
end

function utils.setup(opts)
	if opts == nil then
		return
	end

	if opts.ls then
		require'utils.ls'.setup()
	end

	if opts.toggle_diagnostic then
		install_toggle_diagnostic()
	end
end

return utils
