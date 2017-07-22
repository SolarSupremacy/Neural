--[[ **main.lua :: Evolution Simulator with Neural Networks**

Coded by: _Solar and Misha_
]]

math.randomseed(os.time())

num = 10
avg = 0.015
test = 2

function love.load()
  
end


function love.update(dt)
  
end

function love.draw()
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

local matrix = require("scripts.matrix")

print(matrix.toString(matrix.new(2, 4, true, 1, 2), true, 5))

