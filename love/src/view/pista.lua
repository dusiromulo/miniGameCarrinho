listras = require 'src/view/listras'
obstaculos = require 'src/view/obstaculos'
carro = require 'src/view/carro'

pista = {
	callbackRestartApp = nil,
	nomePlayer = nil,
	pontosPlayer = nil,
	maxPontosPlayer = nil,
	aguardePlayer = nil,
	perdeuPlayer = nil,
	textH = 0,
	totalRestarted = 0,
	velocidade = 1,
	x = 0,
	playerName = "",
	pontos = 0,
	maxPontos = 0,
	height = 0,
	width = 0,
	started = false,
	crashed = false,
	listras = {},
	carro = nil,
	obstaculos = nil,
	start = function (obj)
		obj.totalRestarted = 0
		obj.started = true
		obj.crashed = false
		obj.carro:start()
		obj.obstaculos:start()
	end,
	stop = function (obj)
		obj.started = false
		obj.obstaculos:stop()
	end,
	playerRestart = function (obj)
		obj.started = false
		obj.crashed = false
		obj.velocidade = 1
		obj.pontos = 0
		obj.pontosPlayer:set(tostring(obj.pontos))
		
		for i = 1, #(obj.listras) do
			obj.listras[i]:restart()
		end

		obj.callbackRestartApp()
		obj.aguardePlayer:set("Aguarde até os outros jogadores recomeçarem.")
	end,
	crash = function (obj)
		obj.crashed = true
		obj.carro:crash()

		if obj.pontos > obj.maxPontos then
			obj.maxPontos = obj.pontos
			obj.maxPontosPlayer:set("Pontuação max: " .. tostring(obj.maxPontos))
		end
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
			function() obj:crash() end, function() return obj.carro:getLane(), obj.carro:getHeight() end)
	end,
	criaCarro = function (obj, id, channel, carPosition, carMoveOffsetX, carImg)
		obj.carro = carro.cria(id, channel, carPosition, carMoveOffsetX, obj.height*0.8, carImg,
			function() obj:playerRestart() end)
	end,
	update = function (obj, dt)
		if obj.started then
			if not obj.crashed then
				for i = 1, #(obj.listras) do
					obj.listras[i]:update(dt)
				end

				obj.obstaculos:update(dt)

				obj.pontos = obj.pontos + obj.velocidade
				obj.pontosPlayer:set(tostring(obj.pontos))
			end
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

			if obj.crashed then
				love.graphics.setColor(150, 0, 0)
				love.graphics.draw(obj.perdeuPlayer, obj.x + 20, obj.height/2)
			end
		else
			love.graphics.setColor(0, 150, 0)
			love.graphics.draw(obj.aguardePlayer, obj.x + 20, obj.height/2)
		end

		if obj.carro ~= nil then
			obj.carro:draw()
		end

		love.graphics.setColor(0, 0, 0)
		love.graphics.draw(obj.nomePlayer, obj.x + 20, 20)
		love.graphics.draw(obj.pontosPlayer, obj.x + 20, obj.textH + 20)
		love.graphics.draw(obj.maxPontosPlayer, obj.x + 20, obj.textH*2 + 20)
	end,
}

local mt = {
	__index = pista,
}

function pista.cria(posX, height, width, nome, initialVelocity, callbackRestartApp)
	local font = love.graphics.newFont("fonts/arial.ttf", 18)
	local nomePlayer = love.graphics.newText(font, nome)
	local aguardePlayer = love.graphics.newText(font, "Aguarde até outro player se conectar!")
	local perdeuPlayer = love.graphics.newText(font, "Você perdeu! Aguarde o próximo jogo.")
	local pontosPlayer = love.graphics.newText(font, "0")
	local maxPontosPlayer = love.graphics.newText(font, "Pontuação max: 0")
	local _, titleH = nomePlayer:getDimensions()

	pist = {
		nomePlayer = nomePlayer,
		pontosPlayer = pontosPlayer,
		maxPontosPlayer = maxPontosPlayer,
		aguardePlayer = aguardePlayer,
		perdeuPlayer = perdeuPlayer,
		callbackRestartApp = callbackRestartApp,
		textH = titleH,
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