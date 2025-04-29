local function isTTY ( fd )
    fd = tonumber( fd ) or 1
    local ok, exit, signal = os.execute( string.format( "test -t %d", fd ) )
    return (ok and exit == "exit") and signal == 0 or false
end

--vim.loop.print_all_handles()

--print(vim.loop.fs_event_getpath())

print(vim.loop.guess_handle(vim.fn.getpid()))
--vim.loop.fs_poll_getpath()

print( "stdin", isTTY( 0 ) )
print( "stdout", isTTY( 1 ) )
print( "stderr", isTTY( 2 ) )
