pista = require 'src/view/pista'
novo_jogador = require 'src/controller/novo_jogador'

local w, h = 1280,720
local total_nodes = 3
local novoJogadorObj = nil
local pistas = {}


function novoPlayer(nome, posicao)
	--print("newConnection " .. nome .. " " .. posicao)
	local paddingPistas = 20
	local lenPistas = #pistas
	local pistaX, pistaW = (posicao-1)*w*0.33 + paddingPistas/2, w*0.33 - paddingPistas
	local carCenter, carMoveX = pistaX + w*0.165 - paddingPistas/2, pistaW/3
	if lenPistas == 0 then
		carImg = "images/car1.png"
	elseif lenPistas == 1 then
		carImg = "images/car2.png"
	else
		carImg = "images/car3.png"
	end

	pistas[lenPistas+1] = pista.cria(pistaX, h, pistaW)
	local id = nome..posicao
	local channel = id.."_mini_game_love"
	pistas[lenPistas+1]:criaCarro(id, channel, carCenter, carMoveX, carImg)
end

function appState()
	return #pistas < total_nodes
end

function love.load()
	love.window.setTitle("Mini Game - Carros")
	love.window.setMode(w, h)
	love.graphics.setBackgroundColor(255, 255, 255)

	novoJogadorObj = novo_jogador.cria(novoPlayer, appState)
end

function love.update(dt)
	for i = 1, #pistas do
		pistas[i]:update(dt)
	end
	novoJogadorObj:update()
end


function love.draw()
	love.graphics.setColor(255, 255, 255)
	
	for i = 1, #pistas do
		pistas[i]:draw()
	end
end
