-- global declaration
worldImgs = {}
worldCol = {}
zombies = {}
player = {}
saveData = {}
leftEdge = 0 -- for scrolling the screen, must be subtracted from the x value of all world draw calls
debugText = ""
fps = 0

function love.load()
	
	-- load libraries
	libcollision = love.filesystem.load("collision.lua")
	libcollision()
	
	-- initialization
	player.image = love.graphics.newImage("images/player.png")
	player.x = 10
	player.y = 340
	player.w = player.image:getWidth()
	player.h = player.image:getHeight()
	player.vx = 0
	player.vy = 0
	player.accel = 400 -- px per sec
	player.runSpeed = 150 -- px per sec
	player.walkSpeed = 60 -- px per sec
	player.jumpForce = 300 -- px per sec
	player.gravity = 10
	player.col_w = player.w * 0.8
	player.col_h = player.h * 1
	player.col_x_offset = (player.w - player.col_w) / 2
	player.col_y_offset = (player.h - player.col_h) / 2
	
	--world building objects	
	table.insert(worldImgs, {image=love.graphics.newImage("images/ground.png"), x=0, y=400, w=2000, h=200})
	
	--world collision objects
	table.insert(worldCol, {type="line", x1=0, y1=400, x2=2000, y2=400, solid={"floor"}, callback=nil})
	
	--final gfx setup
	love.graphics.setFont(24)
	
end

function love.draw()
	love.graphics.print("Zombie Game Prototype - Billy Hudson", 10, 10)
	love.graphics.print(math.floor(fps) .. " " .. debugText, 10, 35)
	
	-- draw world images
	for k, v in pairs(worldImgs) do
		love.graphics.draw(v.image, v.x, v.y, 0, v.w/v.image:getWidth(), v.h/v.image:getHeight())
	end
	
	--draw player
	love.graphics.draw(player.image, player.x, player.y)
end

function love.update(dt) -- dt is delta time (in seconds)

	fps = 1/dt
	
	-- PLAYER
	--- INPUT
	if love.keyboard.isDown("lshift") then
		player.maxSpeed = player.walkSpeed
	else
		player.maxSpeed = player.runSpeed
	end		
	if love.keyboard.isDown("left") and math.abs(player.vx) < player.maxSpeed then
		player.vx = player.vx - (player.accel * dt)
	elseif player.vx < 0 then
			player.vx = player.vx + (player.accel * dt)
	end
	if love.keyboard.isDown("right") and math.abs(player.vx) < player.maxSpeed then
		player.vx = player.vx + (player.accel * dt)
	elseif player.vx > 0 then
			player.vx = player.vx - (player.accel * dt)
	end
	--- END INPUT
	
	player.vy = player.vy - player.gravity -- apply gravity
	
	--- COLLISIONS
	for k, v in pairs(worldCol) do
		if v.type == "line" and objline(player, v.x1, v.y1, v.x2, v.y2) and player.vy < 0 then
				player.vy = 0 -- block all downward movment
		end
	end
	--- END COLLISIONS	
	
	player.x = player.x + (player.vx * dt) -- apply horiz velocity
	player.y = player.y - (player.vy * dt) -- apply vert. velocity; subtracting since negative velocity is down
	-- END PLAYER
end

function love.keypressed(key, unicode)
	if key == "up" then
		player.vy = player.jumpForce
	end
end
