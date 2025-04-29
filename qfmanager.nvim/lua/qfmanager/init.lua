return {
	setup = function (opts)
		if opts.qfmanager.enabled then
			vim.print("hello quickfix manager")
		end
	end
}
