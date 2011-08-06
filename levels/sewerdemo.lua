local level = {}

function level.loadmap() -- load the map for inital processing
	
	-- the map (random junk + copy and paste)
	map={
    { 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 4, 4, 4, 4},
    { 3, 1, 4, 4, 2, 2, 2, 4, 3, 4, 3, 4, 1, 1, 1, 4, 4, 3, 4, 4, 4},
    { 3, 1, 4, 4, 2, 4, 2, 4, 3, 4, 3, 4, 1, 4, 4, 4, 4, 4, 3, 4, 4},
    { 3, 1, 1, 4, 2, 2, 2, 4, 4, 3, 4, 4, 1, 1, 4, 4, 4, 4, 4, 3, 4},
    { 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 4, 4, 4, 4, 4, 4, 4, 3},
    { 4, 1, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 2},
    { 4, 1, 4, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 1, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 1, 4, 4, 4, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 1, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 2, 2, 2, 4, 3, 3, 3, 4, 1, 1, 1, 4, 2, 4, 4, 4, 4, 4, 4, 4},
    { 4, 2, 4, 4, 4, 3, 4, 3, 4, 1, 4, 1, 4, 2, 4, 4, 4, 4, 4, 4, 1},
    { 4, 2, 4, 4, 4, 3, 4, 3, 4, 1, 4, 1, 4, 2, 4, 4, 4, 4, 4, 4, 4},
    { 4, 2, 2, 2, 4, 3, 3, 3, 4, 1, 1, 1, 4, 2, 2, 2, 4, 4, 4, 4, 4},
    { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 1, 4, 4, 2, 2, 2, 4, 3, 4, 3, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4},
    { 4, 1, 4, 4, 2, 4, 2, 4, 3, 4, 3, 4, 1, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 1, 1, 4, 2, 2, 2, 4, 4, 3, 4, 4, 1, 1, 4, 4, 4, 4, 4, 4, 4},
    { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 4, 4, 4, 4, 4, 4, 4, 3},
    { 4, 1, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4},
    { 4, 1, 4, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 1, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    { 4, 1, 4, 4, 4, 1, 4, 4, 4, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4}
    }
	
end

function level.load() -- map is processed now we can add the final level code
	-- world objects
	objects = {}
	-- the ground for the level
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, world_w/2, world_h, 0, 0)
	objects.ground.shape = love.physics.newRectangleShape(objects.ground.body, 0, 0, world_w, 20, 0)
	
	-- the player
	maxHealth = 200
	objects.player = {}
	objects.player.body = love.physics.newBody(world, 100, 100, 15, 0)
	objects.player.shape = love.physics.newRectangleShape(objects.player.body, 0, 0, 30, 60, 0)
	objects.player.texture = love.graphics.newImage("images/player.png")
	objects.player.quad = {}
	objects.player.quad.idle = love.graphics.newQuad(0, 0, 32, 64, 32, 64)
	objects.player.health = maxHealth
	
	-- we also set the world's gravity here
	world:setGravity(0, 300)
end

function level.update(dt)

end

function level.keypressed(key, unicide)
	if key == "up" then
		objects.player.body:applyImpulse(0, -100)
	end
	if key == "down" then
		objects.player.body:applyImpulse(0, 100)
	end
end

function level.world_draw()
	-- set the drawing color to green for the ground
	love.graphics.setColor(72, 160, 14)
	-- draw a "filled in" polygon using the ground's coordinates
	love.graphics.polygon("fill", {objects.ground.shape:getPoints()})
	
	-- draw a texture for the player
	x1, y1, x2, y2 = objects.player.shape:getBoundingBox()
	love.graphics.drawq(objects.player.texture, objects.player.quad.idle, x2, y2)
end

function level.screen_draw()
	love.graphics.print("HUD Text", 25, 25)
end

return level