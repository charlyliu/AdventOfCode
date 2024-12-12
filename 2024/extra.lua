function Split(inputstr, sep)
	sep = sep or "%s"
	local t = {}
	for field, s in MatchListBySeparator(inputstr, sep) do
		table.insert(t, field)
		if s == "" then
			return t
		end
	end
end

function MatchListBySeparator(inputstr, sep)
	return string.gmatch(inputstr, "([^" .. sep .. "]*)(" .. sep .. "?)")
end

function table.table_copy(t)
	local t2 = {}
	for k, v in pairs(t) do
		t2[k] = v
	end
	return t2
end

function string.charAt(inputstr, position)
	return string.char(string.byte(inputstr, position))
end
