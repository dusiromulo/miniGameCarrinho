listras = require 'src/view/listras'
obstaculos = require 'src/view/obstaculos'
carro = require 'src/view/carro'

pista = {
	velocidade = 1,
	x = 0,
	playerName = "",
	height = 0,
	width = 0,
	started = false,
	listras = {},
	carro = nil,
	obstaculos = nil,
	start = function (obj)
		obj.started = true
		obj.obstaculos:start()
	end,
	stop = function (obj)
		obj.started = false
		obj.obstaculos:stop()
	end,
	levelUp = function (obj)
		obj.velocidade = obj.velocidade + 1
		obj.obstaculos:levelUp()
		for i = 1, #(obj.listras) do
			obj.listras[i]:levelUp()
		end
	end,
	setListaObstaculos = function (obj, obstaculos)
		obj.obstaculos:setObstaculos(obstaculos)
	end,
	criaObstaculos = function (obj, midX, offsetX, positionX, velPx)
		obj.obstaculos = obstaculos.cria(obj.height, midX, offsetX, positionX, velPx,
			function() obj:stop() end, function() return obj.carro:getLane(), obj.carro:getHeight() end)
	end,
	criaCarro = function (obj, id, channel, carPosition, carMoveOffsetX, carImg)
		obj.carro = carro.cria(id, channel, carPosition, carMoveOffsetX, obj.height*0.8, carImg)
	end,
	update = function (obj, dt)
		if obj.started then
			for i = 1, #(obj.listras) do
				obj.listras[i]:update(dt)
			end

			obj.obstaculos:update(dt)
		end
	end,
	draw = function (obj)
		for i = 1, #(obj.listras) do
			obj.listras[i]:draw()
		end

		if obj.started then
			if obj.obstaculos ~= nil then
				obj.obstaculos:draw()
			end
		end

		if obj.carro ~= nil then
			obj.carro:draw()
		end
	end,
}

local mt = {
	__index = pista,
}

function pista.cria(posX, height, width, nome, initialVelocity)
	pist = {
		x = posX,
		height = height,
		width = width,
		playerName = nome,
		listras = {
			listras.cria(initialVelocity, posX, height),
			listras.cria(initialVelocity, posX + width/2, height, 5, 60),
			listras.cria(initialVelocity, posX + width, height)
		},
	}
	
	setmetatable(pist, mt)
	return pist
end

return pista