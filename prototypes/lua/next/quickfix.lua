--vim.fn.setqflist()
--vim.fn.getqflist()
--errorfmt
-- 10. Customizing the quickfix window quickfix-window-function
--[[
" create a quickfix list from v:oldfiles
call setqflist([], ' ', {'lines' : v:oldfiles, 'efm' : '%f',
                                    \ 'quickfixtextfunc' : 'QfOldFiles'})
func QfOldFiles(info)
    " get information about a range of quickfix entries
    let items = getqflist({'id' : a:info.id, 'items' : 1}).items
    let l = []
    for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
        " use the simplified file name
      call add(l, fnamemodify(bufname(items[idx].bufnr), ':p:.'))
    endfor
    return l
endfunc
--]]


local function QfOldFiles(qf_id)
	local qf_oldfiles = vim.fn.getqflist({ nr = qf_id })
	local what = {
		title = "Old files by me",
		id = qf_oldfiles.id,
		items = {}
	}
	for i, oldfile in pairs(vim.v.oldfiles) do
		local entry = {
			filename = oldfile,
			lnum = 0,
			col = 0,
			nr = i,
			text = string.gsub(oldfile, ".*/", "")
		}
		table.insert(what.items, entry)
	end
	vim.fn.setqflist({}, " ", what)
--	io.write(vim.inspect(what))
end

local qf_id = vim.fn.setqflist({}, " ")
QfOldFiles(qf_id)
