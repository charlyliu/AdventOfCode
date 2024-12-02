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
	local rightOccurances = {}

	for line in io.lines(input) do
		local lineSplitted = Split(line, " ")

		table.insert(left, tonumber(lineSplitted[1]))
		local rightNumber = tonumber(lineSplitted[4])
		local rightString = lineSplitted[4]
		table.insert(right, rightNumber)
		rightOccurances[rightString] = (rightOccurances[rightString] or 0) + 1
	end

	table.sort(left)
	table.sort(right)

	return left, right, rightOccurances
end

local listLeft, listRight, tableOccurances = ConstructSortedTables("input_1.txt")

local distance = 0
local similarities = 0

for index, value in ipairs(listLeft) do
	distance = distance + math.abs(value - listRight[index])
	similarities = similarities + (value * (tableOccurances[tostring(value)] or 0))
end

-- Part 1
print("distance: ", tostring(distance))

-- Part 2
print("similarities: ", tostring(similarities))
