--[[ **main.lua :: Evolution Simulator with Neural Networks**

Coded by: _Solar and Misha_
]]

math.randomseed(os.time())

local matrix = require("lib.matrix")
local neural = require("lib.neural")

function love.run()
  
	if love.math then
		love.math.setRandomSeed(os.time())
	end
  
	if love.load then love.load(arg) end
  
	if love.timer then love.timer.step() end
  
	local dt = 0
  
	while true do
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
    
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
		if love.update then love.update(dt) end
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end
 
		--if love.timer then love.timer.sleep(0.001) end
	end
 
end

function love.load()
  
  timeWarp = 1
  testSetup = {30, 8, 6, 12}
  testGenome = neural.makeGenome(testSetup, "recurrent", true)
  draw = true
  
end

function love.update(dt)
  for i=1, timeWarp do
    
    -- Start Inputs, Neural Processing
    testInput = {}
    for i=1, testSetup[1] do
      table.insert(testInput, math.random(-10, 10) / 10)
    end
    neural.process(testInput, testGenome)
    -- Start Outputs, Physics Processing
    
    function mut(x)
      local final = x
      local rand = math.random()
      if rand < 0.01 then
        final = math.random(-20, 20)/10
      elseif rand < 0.1 then
        final = x + (2*math.random()-1)/10
      end
      return (final)
    end
    
    for i=1, #testGenome[1] do
      testGenome[1][i] = matrix.func(testGenome[1][i], mut)
    end
    
    
    -- End Update
  end
  
end

function love.draw()
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  love.graphics.print("FPS: " .. 1/love.timer.getDelta(), 10, 20)
  
  netText = ""
  netText = netText .. table.concat(testGenome[2][1], " ") .. "\n\n"
  for i=1, (#testGenome[1]) do
    netText = netText .. matrix.toString(testGenome[1][i], true, 5) .. "\n"
    netText = netText .. table.concat(testGenome[2][i+1], " ") .. "\n\n"
  end
  
  love.graphics.print("Neural Net: \n\n" .. netText, 10, 30)
  draw = false
  
end

