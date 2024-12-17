require("extra")

local function TransformIndividualBlocks(line)
	local result = {}
	local id = 0
	local freeBuffer = false

	for char in line:gmatch(".") do
		local number = tonumber(char)
		if number then
			for _ = 1, number, 1 do
				if freeBuffer == false then
					table.insert(result, tostring(id))
				else
					table.insert(result, ".")
				end
			end
			if freeBuffer == true then
				freeBuffer = false
			else
				id = id + 1
				freeBuffer = true
			end
		end
	end

	return result
end

-- Part 1
local function ReOrderPart1(individualBlocks)
	-- local leftIndex = 1
	local rightIndex = #individualBlocks
	-- local result = {}
	local checkSum = tonumber(0)
	for index, c in ipairs(individualBlocks) do
		-- for c in individualBlocks:gmatch(".") do
		if c ~= "." then
			-- table.insert(result, c)
			print((tonumber(c) * tonumber(index - 1)))
			checkSum = checkSum + (tonumber(c) * tonumber(index - 1))
		else
			local notFound = true
			while notFound do
				-- local rightChar = string.charAt(individualBlocks, rightIndex)
				local rightChar = individualBlocks[rightIndex]
				if rightChar ~= "." then
					-- table.insert(result, rightChar)
					print(tonumber(rightChar) * tonumber(index - 1))
					checkSum = checkSum + (tonumber(rightChar) * tonumber(index - 1))
					notFound = false
				end
				rightIndex = rightIndex - 1
			end
		end

		-- leftIndex = leftIndex + 1
		if index + 1 > rightIndex then
			break
		end
	end
	-- for index = leftIndex, #individualBlocks, 1 do
	--	table.insert(result, ".")
	-- end
	return checkSum
end

local function ReOrderPart2(individualBlocks) end

function Decode()
	for line in io.lines("input_9.txt") do
		-- print(line)
		local individualBlocks = TransformIndividualBlocks(line)
		-- print(individualBlocks)
		local checkSum = ReOrderPart1(individualBlocks)
		print(checkSum)
	end
end

Decode()
