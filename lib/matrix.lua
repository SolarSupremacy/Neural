--[[ **matrix.lua :: Matrix Functions**
To use these functions in other files:
local matrix = require("lib.matrix")
matrix.<function>(args)

In function descriptions, a * after a variable means it is necessary.
]]

-- Start Setup
local matrix = {}

getmetatable("").__index = function(str,i)
  if type(i) == 'number' then
    return string.sub(str,i,i)
  else
    return string[i]
  end
end

getmetatable("").__call = function(str,i,j)  
  if type(i)~='table' then
    return string.sub(str,i,j) 
  else
    local t={} 
    for k,v in ipairs(i) do
      t[k]=string.sub(str,v,v)
    end
    return table.concat(t)
  end
end
-- End Setup

-- **matrix.new(y*, x*, random, min, max)**
-- Create a new matrix. 'y' is number of rows, 'x' is number of collums.
-- 'random' is if you want random values between 'min' and 'max', default false.
-- If 'random' is false, enter default value as 'min', default 0.
--[[ Examples:
newMatrix(5, 10, false)
newMatrix(3, 2, true, -2, 2)
]]
function matrix.new(y, x, random, min, max)
  random = random or false
  min = min or 0
  local newMat = {}
  for i=0, y do
    newMat[i] = {}
    for j=0, x do
      if random then
        newMat[i][j] = (max-min)*math.random()+min
      else
        newMat[i][j] = min
      end
    end
  end
  return newMat
end

-- **matrix.toString(matrix*, negatives, length)**
-- Turn a matrix into a string. 'matrix' is theinput matrix.
-- 'negatives' should be true if the matrix can have negatives and should appear consistent.
-- 'negatives' should be set to false for automatic detection if consistency in the output is not important.
-- 'length' is the maximum number of characters for a number to occupy. If abs(negatives) < 10, decimals = length - 3.
--[[ Examples:
matrixToString(matrixA, true, 5)
matrixToString(matrixB, false, 6)
]]
function matrix.toString(matrix, negatives, length)
  negatives = negatives or false
  length = length or 5
  local longest = length
  for i=1, #matrix do
    for j=1, #matrix[i] do
      if (#tostring(matrix[i][j]) > longest) then
        longest = #tostring(matrix[i][j])
      end
      if (tostring(matrix[i][j])[1] == "-") then
        negatives = true
      end
    end
  end
  local line = ""
  local formatting = ""
  for i=1, #matrix do
    line = line .. "[ "
    for j=1, #matrix[i] do
      formatting = tostring(matrix[i][j])
      if (negatives) and (tostring(matrix[i][j])[1] ~= "-") then
        formatting = " " .. formatting
      end
      while (#formatting < longest) do
        formatting = formatting .. "0"
      end
      line = line .. formatting(1, length) .. " "
    end
    line = line .. "]\n"
  end
  return line
end

-- **matrix.mul(matrix1*, matrix2*)**
-- Multiply two matricies together. 'matrix1' and 'matrix2' are the input matricies.
-- Will return the result matrix.
--[[ Example:
matMul(matrixA, matrixB)
]]
function matrix.mul(matrix1, matrix2)
  local newMat = {}
  local val = 0
  for a=1, #matrix1 do
    newMat[a] = {}
    for b=1, #matrix2[1] do
      val = 0
      for c=1, #matrix1[1] do
        val = val + (matrix1[a][c] * matrix2[c][b])
      end
      newMat[a][b] = val
    end
  end
  return newMat
end

-- **matrix.func(matrix*, func*)**
-- Run every value in a matrix through a function.
-- If 'func' is a number instead of a function, it will multiply all values by that number.
-- Will return the result matrix.
--[[ Example:
function func(x) return (math.tanh(x)) end
matFunc(matrix, func)
]]
function matrix.func(matrix, func)
  local newMat = {}
  for a=1, #matrix do
    newMat[a] = {}
    for b=1, #matrix[a] do
      if (type(func) == "function") then
        newMat[a][b] = func(matrix[a][b])
      else
        newMat[a][b] = matrix[a][b] * func
      end
    end
  end
  return newMat
end

return (matrix)