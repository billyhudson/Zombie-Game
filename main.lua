function love.load()
	screen_w = love.graphics.getWidth()
	screen_h = love.graphics.getHeight()
	love.graphics.setFont(24)	
end

function love.draw()
	--love.graphics.print("Zombie Game", 300, 300)
end

function love.update(dt) -- dt is delta time (in seconds)
	--love.timer.sleep(2000)
	mapstate = love.filesystem.load("mapdraw.lua")
	mapstate() -- this will overwrite all the functions in this file
	love.load() -- call manually to relaod game state, will take effect next engine tick
end

function love.keypressed(key, unicode)

end
