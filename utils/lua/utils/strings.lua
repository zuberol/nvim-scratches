
---@param str string
---@return string[]
local function split_whitespace(str)
	local len = string.len(str)
	if len == 0 then
		return {}
	end

	local st = 1
	local en = str:len() - 1

	while st <= en do
		local ws, we = str:find("%s+")
		if ws == nil and we == nil then
			return { str }
		end

	end

	return {}
end

local str = "sfdlk   sa"
local ms, me, _ = str:find("%s+")
print(me - ms)
print(ms)
print(me)
error()

-- local given = "123aa67"
-- local ms, me, _ = given:find("aa")
-- assert(given:sub(1, ms-1) == "123")
-- local six7 = given:sub(me+1, given:len())
-- print(six7)
-- assert(given:sub(me+1, given:len()) == "67")

-- local str = [[123
--   	45]]
-- local s, e, m = str:find('%s+')

assert(#split_whitespace("") == 0)
assert(#split_whitespace("one") == 1)
assert(#split_whitespace("  	one") == 1)
assert(#split_whitespace("one	 ") == 1)
assert(#split_whitespace("  one  	 two  ") == 2)
-- assert(split_whitespace("  one   two  ")[2] == 'two')
-- assert(#split_whitespace("       ") == 0)
-- assert(#split_whitespace("  one     ") == 1)
