local level = {}

function level.loadmap() -- load the map for inital processing
	
	-- load the level's tmx map file
	local chunk = love.filesystem.load("/tmxLoader.lua")
	local tiled = chunk()
	TiledMap_Load("/tiled/level1.tmx", gTileSize)
	
end

function level.load() -- map is processed now we can add the final level code
	-- world objects
	objects = {}
	-- the ground for the level
	objects.box = {}
	-- three outer walls (no bottom)
	---[[
	objects.box[1] = {}
	objects.box[1].body = love.physics.newBody(world, world_w/2, -5, 0, 0)
	objects.box[1].shape = love.physics.newRectangleShape(objects.box[1].body, 0, 0, world_w, 10, 0)
	--[[
	objects.box[2] = {}
	objects.box[2].body = love.physics.newBody(world, world_w/2, world_h+5, 0, 0)
	objects.box[2].shape = love.physics.newRectangleShape(objects.box[2].body, 0, 0, world_w, 10, 0)
	--]]
	objects.box[3] = {}
	objects.box[3].body = love.physics.newBody(world, world_w+5, world_h/2, 0, 0)
	objects.box[3].shape = love.physics.newRectangleShape(objects.box[3].body, 0, 0, 10, world_h, 0)
	objects.box[4] = {}
	objects.box[4].body = love.physics.newBody(world, -5, world_h/2, 0, 0)
	objects.box[4].shape = love.physics.newRectangleShape(objects.box[4].body, 0, 0, 10, world_h, 0)
	--]]
	
	-- the player
	maxHealth = 200
	objects.player = {}
	objects.player.body = love.physics.newBody(world, 100, 100, 15, 0)
	objects.player.shape = love.physics.newRectangleShape(objects.player.body, 0, 0, 30, 60, 0)
	objects.player.texture = love.graphics.newImage("images/player.png")
	objects.player.quad = {}
	objects.player.quad.idle = love.graphics.newQuad(0, 0, 32, 64, 32, 64)
	objects.player.health = maxHealth
	
	-- some info text
	objects.text = {}
	table.insert(objects.text, {x = 32, y = 352, text = "Left click to define polygons"})
	table.insert(objects.text, {x = 32, y = 384, text = "Right click turns the polygon into a world object"})
	table.insert(objects.text, {x = 32, y = 416, text = "Z cancels the current polygon"})
	table.insert(objects.text, {x = 32, y = 448, text = "X removes the last world object"})
	table.insert(objects.text, {x = 32, y = 480, text = "Q save world object data"})
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
	love.graphics.setPointSize(4)
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
	if key == "x" and #objects.box > 0 then
		local i = #objects.box
		objects.box[i].shape:destroy()
		objects.box[i].body:destroy()
		table.remove(objects.box)
	end
	if key == "q" and #objects.box then
		data = ""
		for k, v in ipairs(objects.box) do
			data = data .. "objects.box["..k.."] = {}\n"
			data = data .. "objects.box["..k.."].body = objects.box[i].body = love.physics.newBody(world, 0, 0, 0, 0)\n"
			data = data .. "objects.box["..k.."].shape = love.physics.newPolygonShape(objects.box["..k.."].body, unpack({".. table.concat({objects.box[k].shape:getPoints()}, ", ") .."}))\n"
		end
		love.filesystem.write("boxdata.snip.lua", data)
	end
end

function level.world_draw()
	-- set the drawing color
	love.graphics.setColor(0, 255, 255)
	
	for k, v in pairs(objects.box) do
		-- draw an outlined polygon using the box's coordinates
		love.graphics.polygon("line", {objects.box[k].shape:getPoints()})
	end
	
	-- draw the help text
	for k, v in ipairs(objects.text) do
		love.graphics.print(v.text, v.x, v.y)
	end
	
	-- draw a texture for the player
	x1, y1, x2, y2 = objects.player.shape:getBoundingBox()
	love.graphics.drawq(objects.player.texture, objects.player.quad.idle, x2, y2)
	
	-- draw the mouse pointer
	love.graphics.point(mouse.snap_x, mouse.snap_y)
	
	-- draw the "design poly"
	love.graphics.polygon("line", objects.designPoly)
	for i = 1, #objects.designPoly, 2 do
		love.graphics.point(objects.designPoly[i], objects.designPoly[i+1])
	end
	
	-- draw the spawner particle effects
	
end

function level.screen_draw()
	love.graphics.print("An Awesome Zombie Game Demo", 25, 25)
	love.graphics.print("sx: "..mouse.snap_x.." sy: "..mouse.snap_y, 25, 40)
	love.graphics.print("box: "..#objects.box, 25, 55)
	
end

function level.mousereleased(x, y, button)
	if button == "l" and #objects.designPoly <= 7 * 2 then -- max 7 points
		table.insert(objects.designPoly, mouse.snap_x)
		table.insert(objects.designPoly, mouse.snap_y)
	end
	if button == "r" and #objects.designPoly  >= 4 * 2 then -- min 4 points
		-- copy design polygon into a physics object
		table.insert(objects.box, {}) -- add a new row
		local i = #objects.box -- get the new index
		objects.box[i].body = love.physics.newBody(world, 0, 0, 0, 0)
		objects.box[i].shape = love.physics.newPolygonShape(objects.box[i].body, unpack(objects.designPoly))
		objects.designPoly = {} -- reset the designPoly
	end
end

return level