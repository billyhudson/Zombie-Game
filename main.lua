-- global declaration
worldImgs = {}

worldCollision = {}
zombies = {}
player = {}
saveData = {}
leftEdge = 0 -- for scrolling the screen, must be subtracted from the x value of all world draw calls
debugText = "Test"
fps = 0

function love.load()

	-- initialization
	player.x = 10
	player.y = 340
	player.speed = 80 -- px per sec
	
	--world building objects	
	table.insert(worldImgs, {image=love.graphics.newImage("images/ground.png"), x=0, y=400, w=2000, h=200})
	
	
	--image loading
	player.image = love.graphics.newImage("images/player.png")
	
	--final gfx setup
	love.graphics.setFont(24)
	
end

function love.draw()
	love.graphics.print("Zombie Game Prototype - Billy Hudson", 10, 10)
	love.graphics.print(math.floor(fps) .. " " .. debugText, 10, 35)
	
	-- draw world images
	for k, v in pairs(worldImgs) do
		love.graphics.draw(v.image, v.x-leftEdge, v.y, 0, v.w/v.image:getWidth(), v.h/v.image:getHeight())
	end
	
	--draw player
	love.graphics.draw(player.image, player.x, player.y)
end

function love.update(dt) -- dt is delta time (in seconds)

	fps = 1/dt
	
	if love.keyboard.isDown("left") then
		debugText = "left"
		player.x = player.x - player.speed * dt
	end
	if love.keyboard.isDown("right") then
		debugText = "right"
		player.x = player.x + player.speed * dt
	end
	if love.keyboard.isDown("up") then
		debugText = "up"
	end
	if love.keyboard.isDown("down") then
		debugText = "down"
	end
end

function love.keypressed(key, unicode)

end