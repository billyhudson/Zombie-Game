local tiledLoader = {}

tiledLoader.data = nil

function tiledLoader.loadFile(filename)
	local mapChunk = love.filesystem.load(filename)
	mapChunk()
	tiledLoader.data = map
	tiledLoader.data.layers[1].data = tiledLoader.make2dMap(tiledLoader.data.layers[1].data, tiledLoader.data.width, tiledLoader.data.height)
	map = nil
	
	return tiledLoader.data
end

-- given height 
function tiledLoader.make2dMap(map1d, w, h)
	local map2d = {}
	local i = 0
	for x = 1, h do
		map2d[x] = {}
		for y = 1, w do
			i = i + 1
			map2d[x][y] = map1d[i]
		end
	end
	return map2d
end

return tiledLoader