--[[ **neural.lua :: Neural Network Functions**
To use these functions in other files:
local neural = require("lib.neural")
matrix.<function>(args)

In function descriptions, a * after a variable means it is necessary.
]]

local matrix = require("lib.matrix")

-- Start Setup
local neural = {}

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

function neural.process(inputs, genome)
  genome[2][1] = inputs
  for i=1, #genome[2]-1 do
    function act(x) return ((2.71828^(2*x)-1)/(2.71828^(2*x)+1)) end
    for j=1, #genome[2][i] do
    end
    genome[2][i+1] = matrix.func(matrix.mul({genome[2][i]}, genome[1][i]), act)[1] 
  end
  return (genome)
end

function neural.makeGenome(setup)
  local genome = {{}, {}}
  for i=1, (#setup-1) do
    genome[1][i] = matrix.new(setup[i], setup[i+1], true, -2, 2)
  end
  for i=1, #setup do
    local blanklist = {}
    for j=1, setup[i] do
      table.insert(blanklist, 0)
    end
    genome[2][i] = blanklist
  end
  return (genome)
end

return (neural)