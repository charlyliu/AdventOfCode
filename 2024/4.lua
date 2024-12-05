require("extra")

local function constructMatrix()
	local inputMatrix = {}
	local lineIndex = 1
	for line in io.lines("input_4.txt") do
		-- print("Adding line: ", line)
		inputMatrix[lineIndex] = {}
		local charIndex = 1
		for char in line:gmatch(".") do
			-- print("Adding: ", char)
			inputMatrix[lineIndex][charIndex] = char
			charIndex = charIndex + 1
		end
		lineIndex = lineIndex + 1
	end
	return inputMatrix
end

-- Part 1
local function up(inputMatrix, i, j)
	if i < 4 then
		return 0
	end
	if
		inputMatrix[i][j] == "X"
		and inputMatrix[i - 1][j] == "M"
		and inputMatrix[i - 2][j] == "A"
		and inputMatrix[i - 3][j] == "S"
	then
		return 1
	end
	return 0
end

local function leftup(inputMatrix, i, j)
	if i < 4 or j < 4 then
		return 0
	end
	if
		inputMatrix[i][j] == "X"
		and inputMatrix[i - 1][j - 1] == "M"
		and inputMatrix[i - 2][j - 2] == "A"
		and inputMatrix[i - 3][j - 3] == "S"
	then
		return 1
	end
	return 0
end

local function left(inputMatrix, i, j)
	if j < 4 then
		return 0
	end
	if
		inputMatrix[i][j] == "X"
		and inputMatrix[i][j - 1] == "M"
		and inputMatrix[i][j - 2] == "A"
		and inputMatrix[i][j - 3] == "S"
	then
		return 1
	end
	return 0
end

local function leftdown(inputMatrix, i, j)
	if i > #inputMatrix - 3 or j < 4 then
		return 0
	end
	if
		inputMatrix[i][j] == "X"
		and inputMatrix[i + 1][j - 1] == "M"
		and inputMatrix[i + 2][j - 2] == "A"
		and inputMatrix[i + 3][j - 3] == "S"
	then
		return 1
	end
	return 0
end

local function down(inputMatrix, i, j)
	if i > #inputMatrix - 3 then
		return 0
	end
	if
		inputMatrix[i][j] == "X"
		and inputMatrix[i + 1][j] == "M"
		and inputMatrix[i + 2][j] == "A"
		and inputMatrix[i + 3][j] == "S"
	then
		return 1
	end
	return 0
end

local function rightdown(inputMatrix, i, j)
	if i > #inputMatrix - 3 or j > #inputMatrix[i] - 3 then
		return 0
	end
	if
		inputMatrix[i][j] == "X"
		and inputMatrix[i + 1][j + 1] == "M"
		and inputMatrix[i + 2][j + 2] == "A"
		and inputMatrix[i + 3][j + 3] == "S"
	then
		return 1
	end
	return 0
end

local function right(inputMatrix, i, j)
	if j > #inputMatrix[i] - 3 then
		return 0
	end
	if
		inputMatrix[i][j] == "X"
		and inputMatrix[i][j + 1] == "M"
		and inputMatrix[i][j + 2] == "A"
		and inputMatrix[i][j + 3] == "S"
	then
		return 1
	end
	return 0
end

local function rightup(inputMatrix, i, j)
	if i < 4 or j > #inputMatrix[i] - 3 then
		return 0
	end
	if
		inputMatrix[i][j] == "X"
		and inputMatrix[i - 1][j + 1] == "M"
		and inputMatrix[i - 2][j + 2] == "A"
		and inputMatrix[i - 3][j + 3] == "S"
	then
		return 1
	end
	return 0
end

local function numberOfXmas(inputMatrix, i, j)
	local l = left(inputMatrix, i, j)
	local lu = leftup(inputMatrix, i, j)
	local u = up(inputMatrix, i, j)
	local ru = rightup(inputMatrix, i, j)
	local r = right(inputMatrix, i, j)
	local rd = rightdown(inputMatrix, i, j)
	local d = down(inputMatrix, i, j)
	local ld = leftdown(inputMatrix, i, j)
	-- if inputMatrix[i][j] == "X" then
	-- print(inputMatrix[i][j], l, lu, u, ru, r, rd, d, ld)
	-- end
	return l + lu + u + ru + r + rd + d + ld
end

function Xmas()
	local inputMatrix = constructMatrix()

	local xmas = 0

	for i = 1, #inputMatrix, 1 do
		for j = 1, #inputMatrix[i], 1 do
			xmas = xmas + numberOfXmas(inputMatrix, i, j)
		end
	end

	print(xmas)
end

-- Part 2

local function crossRight(inputMatrix, i, j)
	if
		inputMatrix[i][j] == "A"
		and inputMatrix[i - 1][j - 1] == "M"
		and inputMatrix[i - 1][j + 1] == "S"
		and inputMatrix[i + 1][j + 1] == "S"
		and inputMatrix[i + 1][j - 1] == "M"
	then
		return 1
	end
	return 0
end

local function crossLeft(inputMatrix, i, j)
	if
		inputMatrix[i][j] == "A"
		and inputMatrix[i - 1][j - 1] == "S"
		and inputMatrix[i - 1][j + 1] == "M"
		and inputMatrix[i + 1][j + 1] == "M"
		and inputMatrix[i + 1][j - 1] == "S"
	then
		return 1
	end
	return 0
end

local function crossUp(inputMatrix, i, j)
	if
		inputMatrix[i][j] == "A"
		and inputMatrix[i - 1][j - 1] == "M"
		and inputMatrix[i - 1][j + 1] == "M"
		and inputMatrix[i + 1][j + 1] == "S"
		and inputMatrix[i + 1][j - 1] == "S"
	then
		return 1
	end
	return 0
end

local function crossDown(inputMatrix, i, j)
	if
		inputMatrix[i][j] == "A"
		and inputMatrix[i - 1][j - 1] == "S"
		and inputMatrix[i - 1][j + 1] == "S"
		and inputMatrix[i + 1][j + 1] == "M"
		and inputMatrix[i + 1][j - 1] == "M"
	then
		return 1
	end
	return 0
end

local function numberOfCrossMas(inputMatrix, i, j)
	local cr = crossRight(inputMatrix, i, j)
	local cl = crossLeft(inputMatrix, i, j)
	local cu = crossUp(inputMatrix, i, j)
	local cd = crossDown(inputMatrix, i, j)

	return cr + cl + cu + cd
end

function CrossMas()
	local inputMatrix = constructMatrix()

	local xmas = 0

	for i = 2, #inputMatrix - 1, 1 do
		for j = 2, #inputMatrix[i] - 1, 1 do
			xmas = xmas + numberOfCrossMas(inputMatrix, i, j)
		end
	end

	print(xmas)
end

CrossMas()
