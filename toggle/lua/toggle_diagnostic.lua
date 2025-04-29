local M = {}

ToggleDiagnostic = {
	cached_cfg = vim.diagnostic.config(),
	hide_all = false
}

function ToggleDiagnostic.toggle ()
		local cfg = vim.diagnostic.config()
		assert(cfg ~= nil)
		ToggleDiagnostic.hide_all = not ToggleDiagnostic.hide_all
		if ToggleDiagnostic.hide_all then
			vim.diagnostic.config({
				virtual_lines = false,
				virtual_text = false,
				signs = ToggleDiagnostic.cached_cfg.signs,
				underline = true
			})
		else
			vim.diagnostic.config(ToggleDiagnostic.cached_cfg)
		end
	end

local function install_toggle_diagnostic()
	vim.api.nvim_create_user_command(
		"ToggleDiagnostic",
		ToggleDiagnostic.toggle, { desc = "Hide virtual_text/lines vim.diagnostic from the ui", force = false })
end

function M.setup(opts)
	assert(opts ~= nil)
	if opts.toggle_diagnostic then
		install_toggle_diagnostic()
	end
	if opts.hide_on_start then
		ToggleDiagnostic:toggle()
	end
end

return M
