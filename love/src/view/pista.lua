listras = require 'src/view/listras'
carro = require 'src/view/carro'

pista = {
	velocidade = 1,
	x = 0,
	height = 0,
	width = 0,
	listras = {},
	carro = nil,
	criaCarro = function (obj, carPosition, carMoveOffsetX, carImg)
		obj.carro = carro.cria(carPosition, carMoveOffsetX, obj.height*0.8, carImg)
	end,
	update = function (obj, dt)
		for i = 1, #(obj.listras) do
			obj.listras[i]:update(dt)
		end
	end,
	draw = function (obj)
		if obj.carro ~= nil then
			obj.carro:draw()
		end

		for i = 1, #(obj.listras) do
			obj.listras[i]:draw()
		end
	end,
}

local mt = {
	__index = pista,
}

function pista.cria(posX, height, width)
	pist = {
		x = posX,
		height = height,
		width = width,
		listras = {
			listras.cria(posX, height),
			listras.cria(posX + width, height)
		}
	}
	
	setmetatable(pist, mt)
	return pist
end

return pista