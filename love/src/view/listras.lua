listras = {
	velocidade = 1,
	velPx = 0,
	x = 0,
	windowHeight = 0,
	currOffset = 0,
	width = 10,
	height = 30,
	restart = function (obj)
		obj.velocidade = 1
		obj.currOffset = 0
	end,
	levelUp = function (obj)
		obj.velocidade = obj.velocidade + 1
	end,
	update = function (obj, dt)
		obj.currOffset = obj.currOffset + dt*obj.velocidade*obj.velPx
		if obj.currOffset > 2*obj.height then
			obj.currOffset = obj.currOffset % 20
		end
	end,
	draw = function (obj)
		love.graphics.setColor(0, 0, 0)
		for i = -2, math.floor(obj.windowHeight/obj.height) do -- para desenhar fora da tela
			if i % 2 == 0 then
				love.graphics.rectangle("fill", obj.x, obj.currOffset + i*obj.height, obj.width, obj.height)
			end
		end		
	end,
}

local mt = {
	__index = listras,
}

function listras.cria(initialVelocity, posX, windowHeight, width, height)
	if width ~= nil then
		listr = {
			velPx = initialVelocity,
			x = posX,
			windowHeight = windowHeight,
			width = width,
			height = height
		}
	else
		listr = {
			velPx = initialVelocity,
			x = posX,
			windowHeight = windowHeight
		}
	end

	setmetatable(listr, mt)
	return listr
end

return listras