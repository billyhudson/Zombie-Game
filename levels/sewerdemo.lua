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
	objects.box[1].body = love.physics.newBody(world, world_w/2, -5, 0, 0)
	objects.box[1].shape = love.physics.newRectangleShape(objects.box[1].body, 0, 0, world_w, 10, 0)
	objects.box[2] = {}
	objects.box[2].body = love.physics.newBody(world, world_w/2, world_h+5, 0, 0)
	objects.box[2].shape = love.physics.newRectangleShape(objects.box[2].body, 0, 0, world_w, 10, 0)
	objects.box[3] = {}
	objects.box[3].body = love.physics.newBody(world, world_w+5, world_h/2, 0, 0)
	objects.box[3].shape = love.physics.newRectangleShape(objects.box[3].body, 0, 0, 10, world_h, 0)
	objects.box[4] = {}
	objects.box[4].body = love.physics.newBody(world, -5, world_h/2, 0, 0)
	objects.box[4].shape = love.physics.newRectangleShape(objects.box[4].body, 0, 0, 10, world_h, 0)
	
	-- the player
	maxHealth = 200
	objects.player = {}
	objects.player.body = love.physics.newBody(world, 100, world_h - 20, 15, 0)
	objects.player.shape = love.physics.newRectangleShape(objects.player.body, 0, 0, 30, 60, 0)
	objects.player.texture = love.graphics.newImage("images/player.png")
	objects.player.quad = {}
	objects.player.quad.idle = love.graphics.newQuad(0, 0, 32, 64, 32, 64)
	objects.player.health = maxHealth
	
	-- some info text
	objects.text = {}
	table.insert(objects.text, {x = 32, y = 640, text = "Right click to define polygons"})
	table.insert(objects.text, {x = 32, y = 672, text = "Left click turns the polygon into a world object"})
	table.insert(objects.text, {x = 32, y = 704, text = "Z cancels the current polygon"})
	
	-- poly information for the design tool
	objects.designPoly = {}
	
	-- mouse pointer (for level building)
	mouse = {}
	mouse.x = 0
	mouse.y = 0
	mouse.snap_x = 0
	mouse.snap_y = 0
	
	-- we also set the world's gravity here
	world:setGravity(0, 1000)
	
	-- level graphics setup
	love.graphics.setPointSize(3)
	love.graphics.setPointStyle("smooth")
end

function level.update(dt)
	-- update mouse info
	mouse.x, mouse.y = love.mouse.getPosition()
	mouse.snap_x = tile_round(mouse.x + map_x, tile_w)
	mouse.snap_y = tile_round(mouse.y + map_y, tile_h)
end

function level.keypressed(key, unicide)
	if key == "up" then
		objects.player.body:applyImpulse(0, -100)
	end
	if key == "down" then
		objects.player.body:applyImpulse(0, 100)
	end
	if key == "z" then
		objects.designPoly = {}
	end
end

function level.world_draw()
	-- set the drawing color
	love.graphics.setColor(0, 255, 255)
	
	for k, v in pairs(objects.box) do
		-- draw an outlined polygon using the box's coordinates
		love.graphics.polygon("line", {objects.box[k].shape:getPoints()})
	end
	-- draw a texture for the player
	x1, y1, x2, y2 = objects.player.shape:getBoundingBox()
	love.graphics.drawq(objects.player.texture, objects.player.quad.idle, x2, y2)
	
	-- draw the help text
	for k, v in ipairs(objects.text) do
		love.graphics.print(v.text, v.x, v.y)
	end
	
	-- draw the mouse pointer
	love.graphics.point(mouse.snap_x, mouse.snap_y)
	
	-- draw the "design poly"
	love.graphics.polygon("line", objects.designPoly)
end

function level.screen_draw()
	love.graphics.print("An Awesome Zombie Game Demo", 25, 25)
	love.graphics.print("sx: "..mouse.snap_x.." sy: "..mouse.snap_y, 25, 40)
	love.graphics.print("box: "..#objects.box, 25, 55)
	
end

function level.mousereleased(x, y, button)
	if button == "r" then
		table.insert(objects.designPoly, mouse.snap_x)
		table.insert(objects.designPoly, mouse.snap_y)
	end
	if button == "l" then
		local maxx, maxy = maxxy(objects.designPoly)
		local minx, miny = minxy(objects.designPoly)
		local dx = maxx - minx
		local dy = maxy - miny
		table.insert(objects.box, {}) -- add a new row
		local i = #objects.box -- get the new index
		objects.box[i].body = love.physics.newBody(world, 0, 0, 0, 0)
		objects.box[i].shape = love.physics.newPolygonShape(objects.box[i].body, unpack(objects.designPoly))
		objects.designPoly = {} -- reset the designPoly
	end
end

return level