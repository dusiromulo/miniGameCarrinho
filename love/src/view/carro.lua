controle = require 'src/controller/controle'

local carro = {
	x = 0,
	y = 0,
	height = 89,
	lane = 2,
	carPositions = {0, 0, 0},
	imagem = nil,
	controle = nil,
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
		if (obj.lane > 1) then
			obj.lane = obj.lane - 1
		end
		obj.x = obj.carPositions[obj.lane]
	end,
	moveDir = function (obj)
		if (obj.lane < 3) then
			obj.lane = obj.lane + 1
		end
		obj.x = obj.carPositions[obj.lane]
	end,
	both = function (obj)
	end,
	getLane = function (obj)
		return obj.lane
	end
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

function carro.cria(id, channel, startX, moveOffsetX, fixedY, imagem)
	local carImg = love.graphics.newImage(imagem)
	local carWidth = carImg:getWidth()
	carro = {
		x = startX - carWidth/2,
		y = fixedY,
		carPositions = {startX - moveOffsetX - carWidth/2, startX - carWidth/2, startX + moveOffsetX - carWidth/2},
		imagem = carImg
	}

	setmetatable(carro, mt)

	local callbacks = createCallbackTable(carro)
	carro.controle = controle.cria(id, channel, callbacks[1], callbacks[2], callbacks[3])
	return carro
end

return carro