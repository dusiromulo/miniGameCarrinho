obstaculos = {
	windowHeight = 0,
	velocidade = 1,
	velPx = 0,
	obstaculos = {},
	posicoes = {},
	positionX = 0,
	started = false,
	offset = 0,
	showingFinal = false,
	totalObstaculos = 20,
	offsetObstaculos = 300,
	setObstaculos = function (obj, obstaculos)
		obj.obstaculos = obstaculos
	end,
	start = function(obj)
		obj.started = true
	end,
	stop = function (obj)
		obj.started = false
	end,
	levelUp = function (obj)
		obj.velocidade = obj.velocidade + 1
	end,
	update = function(obj, dt)
		if obj.started then
			obj.offset = obj.offset + dt*obj.velocidade*obj.velPx
		end
	end,
	draw = function(obj)
		if obj.started then
			for i = 1, #(obj.obstaculos) do
				local currY = obj.obstaculos[i].y + obj.offset
				if obj.showingFinal and i < 4 then
					currY = currY - #(obj.obstaculos)*obstaculos.offsetObstaculos
				end

				love.graphics.setColor(255, 255, 255)
				love.graphics.draw(obj.img, obj.positionX + obj.positions[obj.obstaculos[i].x], 
					currY)

				if currY > obj.windowHeight*0.8 then
					if obj.callbackCarroLane() == obj.obstaculos[i].x then
						obj.callbackCrash()
					end
				end

				if i == #(obj.obstaculos) then
					if not obj.showingFinal then
						if currY > 0 then
							obj.showingFinal = true
						end
					else 
						if currY > obj.windowHeight then
							obj.showingFinal = false
							obj.offset = obj.offset - #(obj.obstaculos)*obstaculos.offsetObstaculos
						end
					end
				end
			end
		end
	end,
}

local mt = {
	__index = obstaculos,
}

function obstaculos.criaLista()
	math.randomseed(os.time())
	local positions = {}
	local totalPositions = obstaculos.totalObstaculos
	for i = 1, totalPositions do
		positions[i] = {x=math.random(1, 3), y=i*obstaculos.offsetObstaculos*-1}
	end
	return positions
end

function obstaculos.cria(windowHeight, midX, offsetX, positionX, velPx, callbackCrash, callbackCarroLane)
	local obstacleImg = love.graphics.newImage("images/obstacle.png")
	local obstacleWidth = obstacleImg:getWidth()

	obstaculos = {
		windowHeight = windowHeight,
		callbackCrash = callbackCrash,
		callbackCarroLane = callbackCarroLane,
		velPx = velPx,
		positionX = positionX,
		positions = {midX - offsetX - obstacleWidth/2, midX - obstacleWidth/2, midX + offsetX - obstacleWidth/2},
		img = obstacleImg
	}
	setmetatable(obstaculos, mt)


	return obstaculos
end

return obstaculos