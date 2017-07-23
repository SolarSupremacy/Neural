--[[ **main.lua :: Evolution Simulator with Neural Networks**

Coded by: _Solar and Misha_
]]

math.randomseed(os.time())

local matrix = require("lib.matrix")
local neural = require("lib.neural")

function love.load()
  testSetup = {2, 4, 3}
  testGenome = neural.makeGenome(testSetup)
  
end


function love.update(dt)
  -- Neural
  testInput = {}
  for i=1, testSetup[1] do
    table.insert(testInput, math.random(-10, 10) / 10)
  end
  neural.process(testInput, testGenome)
  -- Physics
end

function love.draw()
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  
  netText = ""
  netText = netText .. table.concat(testGenome[2][1], " ") .. "\n\n"
  for i=1, (#testGenome[2])-1 do
    netText = netText .. matrix.toString(testGenome[1][i], true, 5) .. "\n"
    netText = netText .. table.concat(testGenome[2][i+1], " ") .. "\n\n"
  end
  
  love.graphics.print("Neural Net: \n\n" .. netText, 10, 30)
    
end

