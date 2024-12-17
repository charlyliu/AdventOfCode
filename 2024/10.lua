require("extra")

local function createMap()
	local inputMatrix = {}
	local lineIndex = 1
	for line in io.lines("input_10.txt") do
		inputMatrix[lineIndex] = {}
		local charIndex = 1
		for char in line:gmatch(".") do
			inputMatrix[lineIndex][charIndex] = char
			charIndex = charIndex + 1
		end
		lineIndex = lineIndex + 1
	end
	return inputMatrix
end

-- Part 1
local function findTrails(topographicMap, i, j, resultSet)
	if topographicMap[i][j] == "9" then
		local key = tostring(i) .. ":" .. tostring(j)
		if resultSet[key] == nil then
			resultSet[key] = 1
		else
			resultSet[key] = resultSet[key] + 1
		end

		return
	end

	-- left
	if j < #topographicMap[i] and tonumber(topographicMap[i][j + 1]) == tonumber(topographicMap[i][j]) + 1 then
		findTrails(topographicMap, i, j + 1, resultSet)
	end

	-- right
	if j > 1 and tonumber(topographicMap[i][j - 1]) == tonumber(topographicMap[i][j]) + 1 then
		findTrails(topographicMap, i, j - 1, resultSet)
	end

	-- up
	if i > 1 and tonumber(topographicMap[i - 1][j]) == tonumber(topographicMap[i][j]) + 1 then
		findTrails(topographicMap, i - 1, j, resultSet)
	end

	--down
	if i < #topographicMap and tonumber(topographicMap[i + 1][j]) == tonumber(topographicMap[i][j]) + 1 then
		findTrails(topographicMap, i + 1, j, resultSet)
	end
end

local function findScoreTrails(topographicMap, i, j)
	local allTrails = {}
	findTrails(topographicMap, i, j, allTrails)
	local allRatings = 0
	for _, value in pairs(allTrails) do
		allRatings = allRatings + value
	end
	-- Part 1
	-- return #allTrails

	-- Part 2
	return allRatings
end

local function SumTrailhead(topographicMap)
	local sumTrails = 0

	for i = 1, #topographicMap, 1 do
		for j = 1, #topographicMap[i], 1 do
			if topographicMap[i][j] == "0" then
				sumTrails = sumTrails + findScoreTrails(topographicMap, i, j)
			end
		end
	end
	return sumTrails
end

function day10()
	local topographicMap = createMap()
	print(SumTrailhead(topographicMap))
end

day10()
