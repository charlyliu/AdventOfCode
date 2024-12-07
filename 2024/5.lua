require("extra")

function OrderRules(line)
	local numbers = Split(line, "|")
	return numbers[1], numbers[2]
end

local function tableContains(table, key)
	if table == nil then
		return false
	end
	for _, value in pairs(table) do
		if value == key then
			return true
		end
	end

	return false
end

-- Part 1
function PageOrdering(line, rules)
	local pages = Split(line, ",")

	local correct = true
	for i = 1, #pages - 1, 1 do
		for j = i + 1, #pages, 1 do
			local left = pages[i]
			local right = pages[j]
			print(left, right)
			if tableContains(rules[left], right) == false then
				print("contains false")
				correct = false
				break
			end
		end
	end

	if correct then
		return pages
	end
	return nil
end

-- Part 2
--

function findIncorrect(pages, rules)
	for i = 1, #pages - 1, 1 do
		for j = i + 1, #pages, 1 do
			if tableContains(rules[pages[i]], pages[j]) == false then
				print("contains false")
				return true, i, j
			end
		end
	end
	return false, 0, 0
end

function PageOrderingIncorrectAndReorder(line, rules)
	local pages = Split(line, ",")

	local incorrect = false
	local resultPages = table.table_copy(pages)
	local wasIncorrect = false
	while true do
		incorrect, i, j = findIncorrect(resultPages, rules)
		if incorrect == false then
			break
		end

		wasIncorrect = true
		-- reorder
		print(i, j)
		local exchangepage = resultPages[i]
		resultPages[i] = resultPages[j]
		resultPages[j] = exchangepage
	end

	if wasIncorrect then
		return resultPages
	end
end

function SumMiddleNumbers()
	local result = tonumber(0)

	local readRules = true
	local rules = {}
	for line in io.lines("input_5.txt") do
		if line == "" then
			readRules = false
		else
			if readRules then
				print(line)
				local key, value = OrderRules(line)
				if rules[key] == nil then
					rules[key] = {}
				end

				table.insert(rules[key], value)
			else
				print(line)
				local pages = PageOrderingIncorrectAndReorder(line, rules)
				if pages then
					local middleNumber = pages[math.ceil(#pages / 2)]
					result = result + tonumber(middleNumber)
				end
			end
		end
	end

	print(result)
end

SumMiddleNumbers()
