--[[ **main.lua :: Evolution Simulator with Neural Networks**

Coded by: _Solar and Misha_
]]

math.randomseed(os.time())

num = 10
avg = 0.015
test = 2

function love.load()
  love.window.setFullscreen(true)
end


function love.update(dt)
  for i=1, test do
    num = num + math.sin(num) + math.random(1,100)
  end
  avg = avg * 0.9 + dt * 0.1
  if (love.timer.getFPS() > 59) then
    test = test + 1000
  elseif (love.timer.getFPS() > 10) then
    test = test + (1/30 - dt)*10000
  end
end

function love.draw()
    love.graphics.print("Delta time: " .. avg, 400, 320)
    love.graphics.print("Loops per tick per second: " .. test, 400, 340)
    love.graphics.print("Fast Approach: " .. tostring(love.timer.getFPS() > 59), 400, 360)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 400, 380)
end

--local matrix = require("scripts.matrix")

--print(matrix.toString(matrix.new(2, 4, true, 1, 2), true, 5))

