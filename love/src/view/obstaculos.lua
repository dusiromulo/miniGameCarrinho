obstaculos = {
	windowHeight = 0,
	velocidade = 1,
	velPx = 0,
	obstaculos = {},
	posicoes = {},
	positionX = 0,
	obstacleHeight = 0,
	started = false,
	crashed = false,
	offset = 0,
	showingFinal = false,
	totalObstaculos = 20,
	offsetObstaculos = 300,
	setObstaculos = function (obj, obstaculos)
		obj.obstaculos = obstaculos
	end,
	start = function(obj)
		obj.started = true
		obj.velocidade = 1
		obj.offset = 0
	end,
	stop = function (obj)
		obj.started = false
	end,
	levelUp = function (obj)
		obj.velocidade = obj.velocidade + 1
	end,
	update = function(obj, dt)
		if obj.started and not obj.crashed then
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
				
				if not obj.crashed then
					carLane, carHeight = obj.callbackCarroLane()
					if currY + obj.obstacleHeight > obj.windowHeight*0.8 and currY < obj.windowHeight*0.8 + carHeight then
						if carLane == obj.obstaculos[i].x then
							obj.crashed = true
							obj.callbackCrash()
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
	local obstacleWidth, obstacleHeight = obstacleImg:getWidth(), obstacleImg:getHeight()

	obstac = {
		obstacleHeight = obstacleHeight/2,
		windowHeight = windowHeight,
		callbackCrash = callbackCrash,
		callbackCarroLane = callbackCarroLane,
		velPx = velPx,
		positionX = positionX,
		positions = {midX - offsetX - obstacleWidth/2, midX - obstacleWidth/2, midX + offsetX - obstacleWidth/2},
		img = obstacleImg
	}
	setmetatable(obstac, mt)

	return obstac
end

return obstaculos