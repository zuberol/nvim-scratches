vim.keymap.set('i', '<Enter>', function()
	log.info("called")
	vim.lsp.buf.completion {
		context = {
			triggerKind = 1
		}
	} 
end, { desc = 'try complete', noremap = true, silent = true })

return {
	["textDocument/completion"] = function(err, result, ctx, config)
			vim.g.result = result
			local items = {}
			local idx = 1
			for i, v in ipairs(result.items) do
				if v.kind == 9 then
					vim.print(i .. v.detail)
					items[i] = {
						text = v.detail,
						nr = idx
					}
					idx = idx + 1
				end
			end
			vim.fn.setqflist(items)
		end,
}
