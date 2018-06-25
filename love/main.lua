pista = require 'src/view/pista'
obstaculos = require 'src/view/obstaculos'
novo_jogador = require 'src/controller/novo_jogador'

local w, h = 1280,720
local total_nodes = 3
local novoJogadorObj = nil
local pistas = {}
local listaObstaculos = {}
local startedTime = 0
local initialVelocity = 100
local secondsStageUp = 20
local appState = 0
local states = {CONNECTING=0, PLAYING=1, FINISHED=2}


function novoPlayer(nome, posicao)
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

	pistas[lenPistas+1] = pista.cria(pistaX, h, pistaW, nome, initialVelocity)
	local id = nome..posicao
	local channel = id.."_mini_game_love"
	pistas[lenPistas+1]:criaCarro(id, channel, carCenter, carMoveX, carImg)
	pistas[lenPistas+1]:criaObstaculos(pistaW/2, carMoveX, pistaX, initialVelocity)

	if #listaObstaculos == 0 then
		listaObstaculos = obstaculos.criaLista()
	end

	pistas[lenPistas+1]:setListaObstaculos(listaObstaculos)
	pistas[lenPistas+1]:start()

	if #pistas == total_nodes then
		startedTime = os.time()
		appState = states.PLAYING

		for i = 1, #pistas do
			pistas[i]:start()
		end
	end
end

function podeConectar()
	if appState == states.CONNECTING then
		return #pistas < total_nodes
	else
		return false
	end
end

function love.load()
	love.window.setTitle("Mini Game - Carros")
	love.window.setMode(w, h)
	love.graphics.setBackgroundColor(255, 255, 255)

	--novoJogadorObj = novo_jogador.cria(novoPlayer, podeConectar)
	novoPlayer("a", 1)
	novoPlayer("a", 2)
end

function love.update(dt)
	if appState == states.PLAYING then
		local vel = ((os.time() - startedTime)/secondsStageUp)+1
	end

	for i = 1, #pistas do
		pistas[i]:update(dt)
	end
	--novoJogadorObj:update()

end


function love.draw()
	love.graphics.setColor(255, 255, 255)
	
	for i = 1, #pistas do
		pistas[i]:draw()
	end
end
