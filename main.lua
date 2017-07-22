--[[ **main.lua :: Evolution Simulator with Neural Networks**

Coded by: _Solar and Misha_
]]

math.randomseed(os.time())

local matrix = require("lib.matrix")
local neural = require("lib.neural")

function love.load()
  
end


function love.update(dt)
  -- Neural
  
  -- Physics
  
end

function love.draw()
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
    
end

