require("extra")

function SafeReports(input)
	local safeReports = 0

	for line in io.lines(input) do
		local listLine = Split(line, " ")
		if IsSafe(listLine) then
			safeReports = safeReports + 1
		else
			for i = 1, #listLine, 1 do
				local partialList = table.table_copy(listLine)
				table.remove(partialList, i)
				if IsSafe(partialList) == true then
					safeReports = safeReports + 1
					break
				end
			end
		end
	end

	return safeReports
end

function IsSafe(list)
	local lastNumber = tonumber(0)
	local firstNumber = true
	local isIncreasing = nil
	for _, field in ipairs(list) do
		local number = tonumber(field)
		if firstNumber then
			lastNumber = number
			firstNumber = false
		else
			if IsMoreThan(3, lastNumber, number) then
				return false
			end

			if isIncreasing == nil then
				if lastNumber == number then
					return false
				end

				isIncreasing = lastNumber < number
			elseif isIncreasing == true then
				if lastNumber >= number then
					return false
				end
			else
				if lastNumber <= number then
					return false
				end
			end

			lastNumber = number
		end
	end
	return true
end

function IsMoreThan(number, left, right)
	return math.abs(left - right) > number
end

print(SafeReports("input_2.txt"))
