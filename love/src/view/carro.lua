controle = require 'src/controller/controle'

local carro = {
	x = 0,
	y = 0,
	callbackRestart = nil,
	height = 89,
	lane = 2,
	carPositions = {0, 0, 0},
	crashed = false,
	imagem = nil,
	controle = nil,
	start = function (obj)
		obj.crashed = false
		obj.lane = 2
		obj.x = obj.carPositions[obj.lane]
	end,
	update = function (obj, dt)
		if obj.controle ~= nil then
			obj.controle:update()
		end
	end,
	draw = function (obj)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(obj.imagem, obj.x, obj.y)
	end,
	moveEsq = function (obj)
		if not obj.crashed then
			if (obj.lane > 1) then
				obj.lane = obj.lane - 1
			end
			obj.x = obj.carPositions[obj.lane]
		end
	end,
	moveDir = function (obj)
		if not obj.crashed then
			if (obj.lane < 3) then
				obj.lane = obj.lane + 1
			end
			obj.x = obj.carPositions[obj.lane]
		end
	end,
	both = function (obj)
		if obj.crashed then
			obj.callbackRestart()
		end
	end,
	crash = function (obj)
		obj.crashed = true
	end,
	getLane = function (obj)
		return obj.lane
	end,
	getHeight = function (obj)
		return obj.imagem:getHeight()
	end,
}

local mt = {
	__index = carro,
}

local function createCallbackTable(carro)
	return {
		function() carro:moveEsq() end, 
		function() carro:moveDir() end, 
		function() carro:both() end
	}
end

function carro.cria(id, channel, startX, moveOffsetX, fixedY, imagem, callbackRestart)
	local carImg = love.graphics.newImage(imagem)
	local carWidth = carImg:getWidth()
	car = {
		callbackRestart = callbackRestart,
		x = startX - carWidth/2,
		y = fixedY,
		carPositions = {startX - moveOffsetX - carWidth/2, startX - carWidth/2, startX + moveOffsetX - carWidth/2},
		imagem = carImg
	}

	setmetatable(car, mt)

	local callbacks = createCallbackTable(car)
	car.controle = controle.cria(id, channel, callbacks[1], callbacks[2], callbacks[3])
	return car
end

return carro