CAR_MODULE = require 'src/view/car'
PISTA_MODULE = require 'src/view/pista'
CONTROLE_MODULE = require 'src/controller/controles'

local w, h = 1280,720
local total_nodes = 3
cars = {}
pista = {}
pontos = {0,0,0}

local function loadPista()
	pista = PISTA_MODULE.newPista()
end

local function loadCars()
	for i = 1, total_nodes do
		if (i == 1) then
		  cars[#cars+1] = CAR_MODULE.newCar(w*0.165,h*0.8, "images/car1.png")
		elseif (i == 2) then
		  cars[#cars+1] = CAR_MODULE.newCar(w*0.165 + 0.33*w,h*0.8, "images/car2.png")
		else
		  cars[#cars+1] = CAR_MODULE.newCar(w*0.165 + 0.66*w,h*0.8, "images/car3.png")
		end

		CONTROLE_MODULE.assign(i, cars[#cars])
	end  
end

function love.load()
	love.window.setMode(w, h)
	love.graphics.setBackgroundColor(1,1,1)
	w, h = love.graphics.getDimensions()
	loadPista()
	loadCars(3)
end

function love.update()
	pista:update(pontos, cars)

	for i = 1, #cars do
		cars[i]:update()
	end

	CONTROLE_MODULE.update()
end


function love.draw()
	love.graphics.setColor(0,0,0)
	pontosP1 = "P1 = " .. pontos[1]
	pontosP2 = "P2 = " .. pontos[2]
	pontosP3 = "P3 = " .. pontos[3]
	love.graphics.print(pontosP1, w*0.165, h*0.1)
	love.graphics.print(pontosP2, w*0.165 + w*0.33, h*0.1)
	love.graphics.print(pontosP3, w*0.165 + w*0.66, h*0.1)
	love.graphics.setColor(1,1,1)
	pista:draw()

	for i,v in pairs(cars) do
		cars[i]:draw()
	end
end
  