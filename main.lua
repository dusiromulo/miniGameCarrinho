CAR_MODULE = require 'car'
PISTA_MODULE = require 'pista'
local w, h
local cont = 0
local updateStep = 20
cars = {}
pista = {}

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
    if (math.fmod(i,2) == 0) then
      cars[#cars+1] = CAR_MODULE.newCar(i,h*0.8, "images/car1.png")
    else
      cars[#cars+1] = CAR_MODULE.newCar(i,h*0.8, "images/car2.png")
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
  pista:update()
  
  if(cont > updateStep) then
    cont = 0   
    checkMsgs()
    for i,v in pairs(cars) do
      cars[i]:update()
    end
  end
end


function love.draw()
  pista:draw()
  
  for i,v in pairs(cars) do
      cars[i]:draw()
    end
end
  