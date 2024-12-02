function Split(inputstr, sep)
	sep = sep or "%s"
	local t = {}
	for field, s in string.gmatch(inputstr, "([^" .. sep .. "]*)(" .. sep .. "?)") do
		table.insert(t, field)
		if s == "" then
			return t
		end
	end
end

function ConstructSortedTables(input)
	local left = {}
	local right = {}

	for line in io.lines(input) do
		local lineSplitted = Split(line, " ")

		table.insert(left, tonumber(lineSplitted[1]))
		table.insert(right, tonumber(lineSplitted[4]))
	end

	table.sort(left)
	table.sort(right)

	return left, right
end

local listLeft, listRight = ConstructSortedTables("input_1.txt")

local distance = 0
for index, value in ipairs(listLeft) do
	distance = distance + math.abs(value - listRight[index])
end

print(distance)
