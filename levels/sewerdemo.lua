local level = {}

function level.loadmap() -- load the map for inital processing
	
	-- the map
	-- tile ids start at 1 using less than one will crash the game
	map={
	{ 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 9, 7, 7, 7, 7, 7, 7, 7},
    { 7, 7, 7, 7, 8, 9, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7},
    { 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 9, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7},
    { 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7},
    { 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7},
    { 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7},
    { 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7},
    { 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7},
    { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 19, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 16, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 13, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 20, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 14, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 12, 2, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 18, 2, 19, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
    { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
    { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
    { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
    { 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11}
    }
	
end

function level.load() -- map is processed now we can add the final level code
	-- world objects
	objects = {}
	-- the ground for the level
	objects.box = {}
	-- four outer walls
	objects.box[1] = {}
	objects.box[1].body = love.physics.newBody(world, world_w/2, 0, 0, 0)
	objects.box[1].shape = love.physics.newRectangleShape(objects.box[1].body, 0, 0, world_w, 20, 0)
	objects.box[2] = {}
	objects.box[2].body = love.physics.newBody(world, world_w/2, world_h, 0, 0)
	objects.box[2].shape = love.physics.newRectangleShape(objects.box[2].body, 0, 0, world_w, 20, 0)
	objects.box[3] = {}
	objects.box[3].body = love.physics.newBody(world, world_w, world_h/2, 0, 0)
	objects.box[3].shape = love.physics.newRectangleShape(objects.box[3].body, 0, 0, 20, world_h, 0)
	objects.box[4] = {}
	objects.box[4].body = love.physics.newBody(world, 0, world_h/2, 0, 0)
	objects.box[4].shape = love.physics.newRectangleShape(objects.box[4].body, 0, 0, 20, world_h, 0)
	
	-- the player
	maxHealth = 200
	objects.player = {}
	objects.player.body = love.physics.newBody(world, 100, world_h - 20, 15, 0)
	objects.player.shape = love.physics.newRectangleShape(objects.player.body, 0, 0, 30, 60, 0)
	objects.player.texture = love.graphics.newImage("images/player.png")
	objects.player.quad = {}
	objects.player.quad.idle = love.graphics.newQuad(0, 0, 32, 64, 32, 64)
	objects.player.health = maxHealth
	
	-- we also set the world's gravity here
	world:setGravity(0, 1000)
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
	love.graphics.setColor(0, 255, 255)
	-- some of these are for level design and should be commented out in production
	for k, v in pairs(objects.box) do
		-- draw an outlined polygon using the box's coordinates
		love.graphics.polygon("line", {objects.box[k].shape:getPoints()})
	end
	-- draw a texture for the player
	x1, y1, x2, y2 = objects.player.shape:getBoundingBox()
	love.graphics.drawq(objects.player.texture, objects.player.quad.idle, x2, y2)
end

function level.screen_draw()
	love.graphics.print("An Awesome Zombie Game Demo", 25, 25)
	-- for building phys boxes
	local x, y = love.mouse.getPosition()
	love.graphics.print("x:" .. map_x + x .. " y:" .. map_y + y, 25, 45)
end

return level