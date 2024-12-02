require("extra")

function SafeReports(input)
	local safeReports = 0

	for line in io.lines(input) do
		if IsSafe(line) then
			safeReports = safeReports + 1
		end
	end

	return safeReports
end

function IsSafe(line)
	local lastNumber = tonumber(0)
	local firstNumber = true
	local isIncreasing = nil
	for field, s in MatchListBySeparator(line, " ") do
		local number = tonumber(field)
		if firstNumber then
			lastNumber = number
			firstNumber = false
		else
			if IsMoreThan(3, lastNumber, number) then
				print("is More than 3 ", lastNumber, " ", number)
				return false
			end

			if isIncreasing == nil then
				if lastNumber == number then
					return false
				end

				isIncreasing = lastNumber < number
			elseif isIncreasing == true then
				if lastNumber >= number then
					print("Changed direction > ", lastNumber, " ", number)
					return false
				end
			else
				if lastNumber <= number then
					print("Changed direction < ", lastNumber, " ", number)
					return false
				end
			end

			lastNumber = number
		end

		if s == "" then
			return true
		end
	end
end

function IsMoreThan(number, left, right)
	return math.abs(left - right) > number
end

print(SafeReports("input_2.txt"))
