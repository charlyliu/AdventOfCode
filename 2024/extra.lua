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