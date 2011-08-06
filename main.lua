-- global declaration

fpsCap = 60

function love.load()
	love.graphics.setFont(24)	
end

function love.draw()
	love.graphics.print("Zombie Game - Billy Hudson", 10, 10)
	love.graphics.print("Press Enter to Start", 10, 40)
end

function love.update(dt) -- dt is delta time (in seconds)
	if fpsCap ~= 0 then
		if dt < (1/fpsCap) then
		  love.timer.sleep((1/fpsCap) - dt)
		end
	end
end

function love.keypressed(key, unicode)
	if key == "return" then
		mapstate = love.filesystem.load("mapdraw.lua")
		mapstate()
		love.load()
	end
end
