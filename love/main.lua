pista = require 'src/view/pista'
obstaculos = require 'src/view/obstaculos'
novo_jogador = require 'src/controller/novo_jogador'

local doOnce = true
local total_nodes = -1
local each_track_w = 426
local w, h = 640, 720
local novoJogadorObj = nil
local pistas = {}
local listaObstaculos = {}
local startedTime = 0
local initialVelocity = 100
local secondsStageUp = 20
local totalNodesRestarted = 0
local appState = 0
local states = {CONNECTING=0, PLAYING=1, FINISHED=2}
local display = true
local cont = 0


function novoPlayer(nome, posicao)
	local paddingPistas = 20
	local lenPistas = #pistas
	local pistaX, pistaW = (posicao-1)*w/total_nodes + paddingPistas/2, w/total_nodes - paddingPistas
	local carCenter, carMoveX = pistaX + pistaW/2, pistaW/3
	if lenPistas == 0 then
		carImg = "images/car1.png"
	elseif lenPistas == 1 then
		carImg = "images/car2.png"
	else
		carImg = "images/car3.png"
	end

	pistas[lenPistas+1] = pista.cria(pistaX, h, pistaW, nome, initialVelocity, restartGame)
	local id = nome..posicao
	local channel = id.."_mini_game_love"
	pistas[lenPistas+1]:criaCarro(id, channel, carCenter, carMoveX, carImg)
	pistas[lenPistas+1]:criaObstaculos(pistaW/2, carMoveX, pistaX, initialVelocity)

	if #listaObstaculos == 0 then
		listaObstaculos = obstaculos.criaLista()
	end

	pistas[lenPistas+1]:setListaObstaculos(listaObstaculos)

	if #pistas == total_nodes then
		startedTime = os.time()
		appState = states.PLAYING

		for i = 1, #pistas do
			pistas[i]:start()
		end
	end
end

function restartGame()
	appState = states.CONNECTING
	totalNodesRestarted = totalNodesRestarted + 1

	if totalNodesRestarted == total_nodes then
		totalNodesRestarted = 0
		startedTime = os.time()
		appState = states.PLAYING

		listaObstaculos = obstaculos.criaLista()

		for i = 1, #pistas do
			pistas[i]:setListaObstaculos(listaObstaculos)
		end

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
  w = 1024*0.95
  h = 640*0.7
	love.window.setMode(w, h, {msaa=8})
	love.graphics.setBackgroundColor(255, 255, 255)
  
  input = "Digite 1 para 1 jogador, 2 para 2 e 3 para 3"
  font = love.graphics.newFont("fonts/arial.ttf")
  text = love.graphics.newText(font,input)
  logo = love.graphics.newImage("images/logo.png")
  bg = love.graphics.newImage("images/bg.jpg")

end

function checkNumPlayers()
  if doOnce == true then
    if (love.keyboard.isDown("1")) then
      total_nodes = 1
      w, h = each_track_w*total_nodes + total_nodes*20, 720
      love.window.setMode(w, h, {msaa=8})
      novoJogadorObj = novo_jogador.cria(novoPlayer, podeConectar)
      doOnce = false
    end
    if (love.keyboard.isDown("2")) then
        print("2")
      total_nodes = 2
      w, h = each_track_w*total_nodes + total_nodes*20, 720
      love.window.setMode(w, h, {msaa=8})
      novoJogadorObj = novo_jogador.cria(novoPlayer, podeConectar)
      doOnce = false
    end
    if (love.keyboard.isDown("3")) then
        print("3")
      total_nodes = 3
      w, h = each_track_w*total_nodes + total_nodes*20, 720
      love.window.setMode(w, h, {msaa=8})
      novoJogadorObj = novo_jogador.cria(novoPlayer, podeConectar)
      doOnce = false
    end
  end
end

function love.update(dt)
  
  if (doOnce == true) then
    cont = cont + 1
    if cont > 40 then
      cont = 0
      display = not display
    end
    checkNumPlayers()
    if (total_nodes < 0) then
      return
    end
  end
  
	if appState == states.PLAYING then
		if (os.time() - startedTime) > secondsStageUp then
			startedTime = os.time()
			for i = 1, #pistas do
				pistas[i]:levelUp()
			end
		end
	end

	for i = 1, #pistas do
		pistas[i]:update(dt)
	end
	novoJogadorObj:update()

end

function love.draw()
	
  if total_nodes<0 then
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(bg,0, 0)
    love.graphics.draw(logo,w/2 - logo:getWidth()/4, h*0.1, 0, 0.5, 0.5)
    if display == true then
      love.graphics.setColor(0, 0, 0)
      love.graphics.draw(text,w/2 - text:getWidth()/2 ,h*0.6)
    end
  end
  
	love.graphics.setColor(255, 255, 255)
	for i = 1, #pistas do
		pistas[i]:draw()
	end
end
