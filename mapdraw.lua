function love.load()
	-- global player speeds
	runSpeed = 250
	walkSpeed = 75
	-- tiles away from edge to scroll map
	edgeBuffer = 4 -- tiles

	-- load external level code
	levelchunk = love.filesystem.load("levels/level1.lua")
	level = levelchunk()
	
	-- map variables
	gTileSize = 32 -- a global tile size for refrence by modules of the program
	screen_w = love.graphics.getWidth()
	screen_h = love.graphics.getHeight()
	--TODO remove these
	tile_w = gTileSize
    tile_h = gTileSize
	
	-- load the map for inital processing
	level.loadmap()
	
    map_x = 0
    map_y = (gMap.height * gTileSize) - screen_h
	
	--create the physics world
	world_w = gMap.width * gTileSize
	world_h = gMap.height * gTileSize
	world = love.physics.newWorld(-5, -5, world_w+5, world_h+5) -- add 5px to accomodate walls
	world:setMeter(gTileSize)
	
	--initial graphics setup
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setMode(800, 600, false, true, 0) --set the window dimensions to 800 by 600 with no fullscreen, vsync on, and no antialiasing
	love.graphics.setColorMode("replace")
	love.graphics.setFont(18)
	
	-- load the level objects
	level.load()
	
	-- load the world objects into the physics engine
	for k, v in ipairs(gWorld) do
		table.insert(objects.box, {}) -- add a new row
		local i = #objects.box -- get the new index
		objects.box[i].body = love.physics.newBody(world, 0, 0, 0, 0)
		objects.box[i].shape = love.physics.newPolygonShape(objects.box[i].body, v.x, v.y, v.x, v.y+v.height, v.x+v.width, v.y+v.height, v.x+v.width, v.y)
	end
end
	

function love.update( dt )
	world:update(dt) --this puts the world into motion
	
	--get input
	if love.keyboard.isDown( "lshift" ) then
		moveSpeed = walkSpeed
	else
		moveSpeed = runSpeed
	end
    if love.keyboard.isDown( "up" ) then
    end
    if love.keyboard.isDown( "down" ) then
    end
    if love.keyboard.isDown( "left" ) then
		local vx, vy = objects.player.body:getLinearVelocity()
		objects.player.body:setLinearVelocity(-moveSpeed, vy-1)
    end
    if love.keyboard.isDown( "right" ) then
		local vx, vy = objects.player.body:getLinearVelocity()
		objects.player.body:setLinearVelocity(moveSpeed, vy-1)
    end
    if love.keyboard.isDown( "escape" ) then
        love.event.push( "q" )
    end
	
	-- push the map around based on the player's onscreen position
	player_x = objects.player.body:getX()
	player_y = objects.player.body:getY()
	local vx, vy = objects.player.body:getLinearVelocity()
	if player_x < map_x + tile_w * edgeBuffer then
		map_x = map_x - math.abs(vx) * dt
	elseif player_x > map_x + screen_w - tile_w * edgeBuffer then
		map_x = map_x + math.abs(vx) * dt
	end
	if player_y > map_y + (screen_h - tile_h * edgeBuffer) then
		map_y = map_y + math.abs(vy) * dt
	elseif player_y < map_y + tile_h * edgeBuffer then
		map_y = map_y - math.abs(vy) * dt
	end
	
	level.update()
end

function love.keypressed(key, unicode)
	level.keypressed(key, unicode)
end

function love.mousereleased(x, y, button)
	level.mousereleased(x, y, button)
end

function love.draw()   
	-- draw the tile bg
	local cam_x = map_x + screen_w / 2
	local cam_y = map_y + screen_h / 2
	TiledMap_DrawNearCam(cam_x,cam_y)
	
	-- save viewport state then translate it so all the world-aligned draws line up with the map
	love.graphics.push()
	love.graphics.translate(-map_x, -map_y)
	-- event for level to draw items in worldspace
	level.world_draw()
	
	-- return to normal for drawing static screen elements
	love.graphics.pop()
	-- call level event
	level.screen_draw()
end

-- rounds to the nearest tile boundary
function tile_round(num, length)
    under = num - (num % length)
    upper = under +length
    underV = -(under - num)
    upperV = upper - num
    if (upperV > underV) then
        return under
    else
        return upper
    end
end

function maxxy(points)
	x = {}
	y = {}
	for k, v in ipairs(points) do
		if k % 2 == 0 then -- y
			table.insert(y, v)
		else -- x
			table.insert(x, v)
		end
	end
	return math.max(unpack(x)), math.max(unpack(y))
end

function minxy(points)
	local x = {}
	local y = {}
	for k, v in ipairs(points) do
		if k % 2 == 0 then -- y
			table.insert(y, v)
		else -- x
			table.insert(x, v)
		end
	end
	return math.min(unpack(x)), math.min(unpack(y))
end
