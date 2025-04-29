local M = {}

-- quickfix
-- winid
-- id
-- start_idx
-- end_idx
-- list[string]
local function qf_lock_list_count()

	local qf_count = vim.fn.getqflist { ['nr'] = '$' }
	vim.print("quickfix lists: " .. qf_count.nr)
	local loc_count = vim.fn.getloclist { ['nr'] = '$' }
	vim.print("loclist lists: " .. loc_count)
end

local function qf_list_pretty(arg)
	local what = {
		["all"] = 0,
	}
	local qf_loc_entries = vim.fn.getqflist()
	local loc_lists = {}
	local qf_lists = {}
	for i, v in ipairs(qf_loc_entries) do
		-- vim.print(v.nr .. " -> " .. v.bufnr)
		vim.print(v)
		if v.nr == -1 then
			
		else
			
		end
	end
end

qf_lock_list_count()

return M
