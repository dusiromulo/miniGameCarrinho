CARRO_MODULE = require 'src/view/carro'
PISTA_MODULE = require 'src/view/pista'
NOVO_JOGADOR_MODULE = require 'src/controller/novo_jogador'

local w, h = 1280,720
local total_nodes = 3
local novo_jogador = nil
cars = {}
pista = {}
pontos = {0,0,0}

local function loadPista()
	pista = PISTA_MODULE.newPista()
end

local function loadCarros()
	for i = 1, total_nodes do
		if (i == 1) then
		  cars[#cars+1] = CARRO_MODULE.cria(w*0.165, w*0.11, h*0.8, "images/car1.png")
		elseif (i == 2) then
		  cars[#cars+1] = CARRO_MODULE.cria(w*0.165 + 0.33*w, w*0.11, h*0.8, "images/car2.png")
		else
		  cars[#cars+1] = CARRO_MODULE.cria(w*0.165 + 0.66*w, w*0.11, h*0.8, "images/car3.png")
		end
	end  
end

function novoPlayer(nome, posicao)
	print("newConnection " .. nome .. " " .. posicao)
end

function appState()
	return true
end

function love.load()
	love.window.setMode(w, h)
	love.graphics.setBackgroundColor(255, 255, 255)
	w, h = love.graphics.getDimensions()
	loadPista()
	loadCarros()

	novo_jogador = NOVO_JOGADOR_MODULE.cria(novoPlayer, appState)
end

function love.update()
	pista:update(pontos, cars)
	novo_jogador:update()
	--[[for i = 1, #cars do
		cars[i]:update()
	end]]
end


function love.draw()
	love.graphics.setColor(0,0,0)
	pontosP1 = "P1 = " .. pontos[1]
	pontosP2 = "P2 = " .. pontos[2]
	pontosP3 = "P3 = " .. pontos[3]
	love.graphics.print(pontosP1, w*0.165, h*0.1)
	love.graphics.print(pontosP2, w*0.165 + w*0.33, h*0.1)
	love.graphics.print(pontosP3, w*0.165 + w*0.66, h*0.1)
	love.graphics.setColor(255, 255, 255)
	pista:draw()

	for i,v in pairs(cars) do
		cars[i]:draw()
	end
end
  