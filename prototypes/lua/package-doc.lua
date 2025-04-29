-- vim.lsp.tagfunc
-- vim.lsp.rpc
-- workspace/symbol cm'fallback'
-- lsp request

---@class lsp.LocationLink



---@class Location
local location = {

}
local offset_enc = 'utf-8'
local show_doc_opts = {
	reuse_win = false,
	focus = true
}


local ret = vim.lsp.util.show_document(location, offset_enc, show_doc_opts)
vim.print(ret)



error("exiting")
local uri = {
}
vim.api.nvim_create_autocmd('LspRequest', {
	callback = function(args)
		local bufnr = args.buf
		local client_id = args.data.client_id
		local request_id = args.data.request_id
		local request = args.data.request
		-- if request.type == 'pending' then
		-- 	-- do something with pending requests
		-- 	track_pending(client_id, bufnr, request_id, request)
		-- elseif request.type == 'cancel' then
		-- 	-- do something with pending cancel requests
		-- 	track_canceling(client_id, bufnr, request_id, request)
		-- elseif request.type == 'complete' then
		-- 	-- do something with finished requests. this pending
		-- 	-- request entry is about to be removed since it is complete
		-- 	track_finish(client_id, bufnr, request_id, request)
		-- end
		vim.print("request: ", vim.inspect(request))
	end,
})

-- vim.api.nvim_create_autocmd('LspResponse', {
-- 	callback = function (args)
-- 		vim.print(vim.inspect(args))
-- 	end
-- })


local win_doc_opts = {}

local M = {
	["textDocument/hover"] = vim.lsp.with(
		function (err, result, ctx)
			vim.print("result: ", vim.inspect(result))
			vim.print("ctx: ", vim.inspect(ctx))
			return vim.lsp.handlers.hover(err, result, ctx)
		end,
		{}
	),
	["window/showDocument"] = vim.lsp.with(
		function (err, result, ctx)
			vim.print("err: ", vim.inspect(err))
			vim.print("result: ", vim.inspect(result))
			vim.print("ctx: ", vim.inspect(ctx))
		end,
		win_doc_opts
	)
}
return M
