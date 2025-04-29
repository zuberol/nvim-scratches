
-- https://rosettacode.org/wiki/Check_output_device_is_a_terminal#C

local pid = vim.loop.os_getpid()
vim.api.nvim_err_writeln("ze:" .. pid)

print(vim.inspect(_G.arg))

vim.print("hello scratches/ppid.lua")



---
local function isTTY ( fd )
    fd = tonumber( fd ) or 1
    local ok, exit, signal = os.execute( string.format( "test -t %d", fd ) )
    return (ok and exit == "exit") and signal == 0 or false
end

local another_pid = vim.fn.getpid()
local gh = vim.loop.guess_handle(pid)
vim.api.nvim_err_writeln(gh or "none")
vim.api.nvim_err_writeln(pid.."<- pid")
print( "stdin", isTTY( 0 ) )
print( "stdout", isTTY( 1 ) )
print( "stderr", isTTY( 2 ) )

print(isTTY(pid))
