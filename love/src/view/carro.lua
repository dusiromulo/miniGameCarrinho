controle = require 'src/controller/controle'

local carro = {
	x = 0,
	y = 0,
	callbackRestart = nil,
	height = 89,
	lane = 2,
	carPositions = {0, 0, 0},
	crashed = false,
	restarted = false,
	imagem = nil,
	controle = nil,
	start = function (obj)
		print("carro start")
		obj.crashed = false
		obj.restarted = false
		obj.lane = 2
		obj.x = obj.carPositions[obj.lane]
	end,
	update = function (obj, dt)
		if obj.controle ~= nil then
			obj.controle:update()
		end
	end,
	createControle = function (obj, id, channel)
		local callbackEsq = function() obj:moveEsq() end
		local callbackDir = function() obj:moveDir() end
		local callbackBoth = function() obj:both() end
		obj.controle = controle.cria(id, channel, callbackEsq, callbackDir, callbackBoth)
	end,
	draw = function (obj)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(obj.imagem, obj.x, obj.y)
	end,
	moveEsq = function (obj)
		print("moveEsq")
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
			if not obj.restarted then
				obj.restarted = true
				obj.callbackRestart()
			end
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
	car:createControle(id, channel)
	return car
end

return carro