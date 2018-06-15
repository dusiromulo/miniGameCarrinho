CAR_MODULE = require 'car'
PISTA_MODULE = require 'pista'
local w, h
local cont = 0
local updateStep = 20
cars = {}
pista = {}
pontos = {0,0,0}

local function loadPista()
  print("load");
  pista = PISTA_MODULE.newPista()
  print("end load");
end

local function loadCars(numCars)
  if numCars > 3 then
    numCars = 3
  end
  for i=1,numCars do
    if (i == 1) then
      cars[#cars+1] = CAR_MODULE.newCar(w*0.165,h*0.8, "images/car1.png")
    elseif (i == 2) then
      cars[#cars+1] = CAR_MODULE.newCar(w*0.165 + 0.33*w,h*0.8, "images/car2.png")
    else
      cars[#cars+1] = CAR_MODULE.newCar(w*0.165 + 0.66*w,h*0.8, "images/car3.png")
    end
    
  end  
  
end



local function checkMsgs()
  
  if #cars>0  then
    if (love.keyboard.isDown("a")) then
      cars[1]:move("left")
    elseif (love.keyboard.isDown("d")) then
      cars[1]:move("right")
    else
    end
  end

  if #cars>1  then
    if (love.keyboard.isDown("q")) then
      cars[2]:move("left")
    elseif (love.keyboard.isDown("e")) then
      cars[2]:move("right")
    else
    end
  end

  if #cars>2  then
    if (love.keyboard.isDown("z")) then
      cars[3]:move("left")
    elseif (love.keyboard.isDown("c")) then
      cars[3]:move("right")
    else
    end
  end
end


function love.load()
  love.window.setMode(1280,720)
  love.graphics.setBackgroundColor(1,1,1)
  w, h = love.graphics.getDimensions()
  
  loadPista()
  loadCars(3)
  
  --<Create Cars>
 
  --</Create Cars>
  
end



function love.update()
  cont = cont + 1
  pista:update(pontos, cars)
  
  if(cont > updateStep) then
    cont = 0   
    checkMsgs()
    for i,v in pairs(cars) do
      cars[i]:update()
    end
  end
end


function love.draw()
  love.graphics.setColor(0,0,0)
  pontosP1 = "P1 = "..pontos[1]
  pontosP2 = "P2 = "..pontos[2]
  pontosP3 = "P3 = "..pontos[3]
  love.graphics.print(pontosP1, w*0.165, h*0.1)
  love.graphics.print(pontosP2, w*0.165 + w*0.33, h*0.1)
  love.graphics.print(pontosP3, w*0.165 + w*0.66, h*0.1)
  love.graphics.setColor(1,1,1)
  pista:draw()
  
  for i,v in pairs(cars) do
      cars[i]:draw()
    end
end
  