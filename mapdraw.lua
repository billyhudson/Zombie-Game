function love.load()
	-- global player speeds
	runSpeed = 250
	walkSpeed = 75
	-- tiles away from edge to scroll map
	edgeBuffer = 4 -- tiles

	-- load external level code
	levelchunk = love.filesystem.load("levels/level1.lua")
	level = levelchunk()
	
	-- load the map for inital processing
	mapData = level.loadmap()
	
	if mapData.layers[1].type == "tilelayer" then
		map = mapData.layers[1].data
	else
		map = {
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 1, 1},
        {1, 2, 1, 1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1},
        {1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1},
        {1, 2, 1, 1, 1, 2, 2, 1, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 1, 2, 1},
        {1, 2, 2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 2, 1},
        {1, 2, 1, 1, 1, 2, 2, 1, 1, 2, 2, 2, 2, 2, 1, 1, 2, 1, 1, 1, 2, 1},
        {1, 2, 1, 1, 1, 1, 2, 1, 2, 2, 1, 1, 1, 2, 2, 1, 2, 1, 1, 1, 2, 1},
        {1, 2, 1, 1, 1, 2, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1},
        {1, 2, 2, 2, 2, 2, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 2, 2, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 1},
        {1, 2, 2, 2, 2, 2, 1, 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1},
        {1, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1},
        {1, 2, 1, 1, 1, 2, 1, 1, 2, 2, 2, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 1},
        {1, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}
	end
	
    -- map variables
	screen_w = love.graphics.getWidth()
	screen_h = love.graphics.getHeight()
	tile_w = 32
    tile_h = 32
    map_display_w = screen_w / tile_w
    map_display_h =  screen_h / tile_h
	
    map_w = #map[1] -- Obtains the width of the first row of the map
    map_h = #map -- Obtains the height of the map
    map_x = 0
    map_y = map_h * tile_h - screen_h
    map_display_buffer = 2 -- We have to buffer one tile before and behind our viewpoint.
                           -- Otherwise, the tiles will just pop into view, and we don't want that.
	
	-- load tiles from power-of-2 image
	tileimg = love.graphics.newImage("images/terrain.png")
	tile = {}
	imagesize = 1024 -- power of 2
	for y = 0, imagesize, tile_w do
		for x = 0, imagesize, tile_h do
			table.insert(tile, love.graphics.newQuad(x, y, tile_w, tile_h, imagesize, imagesize))
		end
	end
	
	--create the physics world
	world_w = map_w * tile_w
	world_h = map_h * tile_h
	world = love.physics.newWorld(-5, -5, world_w+5, world_h+5) -- add 5px to accomodate walls
	world:setMeter(64) --the height of a meter in this world will be 32px
	
	--initial graphics setup
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setMode(800, 600, false, true, 0) --set the window dimensions to 800 by 600 with no fullscreen, vsync on, and no antialiasing
	love.graphics.setColorMode("replace")
	love.graphics.setFont(18)
	
	-- load the level objects
	level.load()
	
	-- load world objects from map data
	if #mapData.layers > 1 and mapData.layers[2].type == "objectgroup" then
		for k, v in ipairs(mapData.layers[2].objects) do
			table.insert(objects.box, {}) -- add a new row
			local i = #objects.box -- get the new index
			objects.box[i].body = love.physics.newBody(world, 0, 0, 0, 0)
			objects.box[i].shape = love.physics.newPolygonShape(objects.box[i].body, v.x, v.y, v.x, v.y+v.height, v.x+v.width, v.y+v.height, v.x+v.width, v.y)
		end
	end
end
   
function draw_map()
    offset_x = math.floor(map_x % tile_w)
    offset_y = math.floor(map_y % tile_h)
    firstTile_x = math.floor(map_x / tile_w)
    firstTile_y = math.floor(map_y / tile_h)
   
    for y=1, (map_display_h + map_display_buffer) do
        for x=1, (map_display_w + map_display_buffer) do
            -- Note that this condition block allows us to go beyond the edge of the map.
            if y+firstTile_y >= 1 and y+firstTile_y <= map_h
                and x+firstTile_x >= 1 and x+firstTile_x <= map_w
            then
                love.graphics.drawq(tileimg,
                    tile[map[y+firstTile_y][x+firstTile_x]],
                    (x*tile_w) - offset_x - tile_w,
                    (y*tile_h) - offset_y - tile_h)
            end
        end
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

    -- check boundaries. remove this section if you don't wish to be constrained to the map.
    if map_x < 0 then
        map_x = 0
    end

    if map_y < 0 then
        map_y = 0
    end
 
    if map_x > map_w * tile_w - map_display_w * tile_w then
        map_x = map_w * tile_w - map_display_w * tile_w
    end
 
    if map_y > map_h * tile_h - map_display_h * tile_h then
        map_y = map_h * tile_h - map_display_h * tile_h
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
	draw_map()
	
	-- save then translate the viewport so all the world-aligned draws line up with the map
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
