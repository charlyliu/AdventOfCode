require("extra")

function SumMultiplication()
	local result = tonumber(0)

	for line in io.lines("input_3.txt") do
		for _, mul in ipairs(FindAllOccurances(line)) do
			result = mul + result
		end
	end

	print(result)
end

add = true

function FindAllOccurances(line)
	local result = {}

	for w in FindMuls(line) do
		--print(w)
		--Part 1

		local mulNumbersList = CalculateEveryMul(w)
		table.insert(result, mulNumbersList)
	end
	return result
end

function CalculateEveryMul(word)
	local mulNumbersList = tonumber(1)
	for number in string.gmatch(word, "(%d+)") do
		mulNumbersList = tonumber(number) * mulNumbersList
	end
	return mulNumbersList
end

function FindMuls(line)
	local stateMul = {
		currentIndex = 1,
		char = { "m", "u", "l", "(", ",", ")" },
	}

	local stateDo = {
		currentIndex = 1,
		char = { "d", "o", "(", ")" },
	}

	local stateDont = {
		currentIndex = 1,
		char = { "d", "o", "n", "'", "t", "(", ")" },
	}

	local currentMul = {}
	local allMuls = {}

	for c in line:gmatch(".") do
		if c == stateDo.char[stateDo.currentIndex] then
			if stateDo.currentIndex == 4 then
				add = true
				stateDo.currentIndex = 1
			else
				stateDo.currentIndex = stateDo.currentIndex + 1
			end
		else
			stateDo.currentIndex = 1
		end

		if c == stateDont.char[stateDont.currentIndex] then
			if stateDont.currentIndex == 7 then
				add = false
				stateDont.currentIndex = 1
			else
				stateDont.currentIndex = stateDont.currentIndex + 1
			end
		else
			stateDont.currentIndex = 1
		end

		local digit = tonumber(c)
		if stateMul.currentIndex == 5 and digit ~= nil then
			table.insert(currentMul, digit)
		elseif stateMul.currentIndex == 6 and digit ~= nil then
			table.insert(currentMul, digit)
		elseif c == stateMul.char[stateMul.currentIndex] then
			table.insert(currentMul, stateMul.char[stateMul.currentIndex])
			if stateMul.currentIndex > 5 then
				if add then
					table.insert(allMuls, table.concat(currentMul))
				end
				currentMul = {}
				stateMul.currentIndex = 1
			else
				stateMul.currentIndex = stateMul.currentIndex + 1
			end
		else
			currentMul = {}
			stateMul.currentIndex = 1
		end
	end

	local index = 0
	local count = #allMuls

	return function()
		index = index + 1

		if index <= count then
			return allMuls[index]
		end
	end

	--Part 1
	--return string.gmatch(line, "mul%(%d+,%d+%)*do%(%)*")
end

SumMultiplication()
