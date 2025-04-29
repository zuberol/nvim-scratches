if vim.b[0].did_ftplugin == nil then
	vim.notify("zeauberg: go filetype was already loaded", vim.log.levels.DEBUG)
	vim.b[0].did_ftplugin = 1
end

-- refs
-- From vim-go
--%-G# %.%#,%-G%.%#panic: %m,%Ecan't load package: %m,%A%\%%(%[%^:]%\+: %\)%\?%f:%l:%c: %m,%A%\%%(%[%^:]%\+: %\)%\?%f:%l: %m,%C%*\s%m,%-G%.%#


vim.bo.makeprg="go test ./..."
vim.bo.errorformat = "%E%f:%l: %m,%-G%.%#"

