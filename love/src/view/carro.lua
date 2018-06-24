local carro = {
	x = 0,
	y = 0,
	height = 89,
	lane = 2,
	carPositions = {0, 0, 0},
	imagem = nil,
	draw = function (obj)
		love.graphics.draw(obj.imagem, obj.x, obj.y)
	end,
	moveEsq = function(obj)
		if (car.lane > 1) then
			car.lane = car.lane - 1
		end
		car.x = car.carPositions[car.lane]
	end,
	moveDir = function(obj)
		if (car.lane < 3) then
			car.lane = car.lane + 1
		end
		car.x = car.carPositions[car.lane]
	end,
}

local mt = {
	__index = carro,
}

function carro.cria(startX, moveOffsetX, fixedY, imagem)
	local carWidth = 44
	
	carro = {
		x = startX - carWidth/2,
		y = fixedY,
		carPositions = {startX - moveOffsetX - carWidth/2, startX - carWidth/2, startX + moveOffsetX - carWidth/2},
		imagem = love.graphics.newImage(imagem),
	}

	setmetatable(carro, mt)
	return carro
end

return carro