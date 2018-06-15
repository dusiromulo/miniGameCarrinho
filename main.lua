CAR_MODULE = require 'car'
local w, h
local stripeWidth = 9
local cont = 0
local updateStep = 20
stripes = {}
cars = {}

local function loadStripes()
  
  local darkImg = love.graphics.newImage("images/dark.png")
  local lightImg = love.graphics.newImage("images/light.png")
  
  for i=1,20 do
    stripes[#stripes+1] = {
                              x = 0,
                              y = i*h/20
                          }
    if (math.fmod(i, 2) == 0) then
      stripes[#stripes].imagem = darkImg
    else
      stripes[#stripes].imagem = lightImg
    end
    
  end
  --</Left Stripes>
  
  --<0.33 Stripes>
  for i=1,20 do
    stripes[#stripes+1] = {
                              x = w*0.33 - stripeWidth,
                              y = i*h/20
                          }
    if (math.fmod(i,2) == 0) then
      stripes[#stripes].imagem = darkImg
    else
      stripes[#stripes].imagem = lightImg
    end
    
  end
  --</0.33 Stripes>
  
  --<0.66 Stripes>
  for i=1,20 do
    stripes[#stripes+1] = {
                              x = w*0.66 - stripeWidth,
                              y = i*h/20
                          }
    if (math.fmod(i,2) == 0) then
      stripes[#stripes].imagem = darkImg
    else
      stripes[#stripes].imagem = lightImg
    end
    
  end
  --</0.66 Stripes>
  
  --<Right Stripes>
  for i=1,20 do
    stripes[#stripes+1] = {
                              x = w-stripeWidth,
                              y = i*h/20
                          }
    if (math.fmod(i,2) == 0) then
      stripes[#stripes].imagem = darkImg
    else
      stripes[#stripes].imagem = lightImg
    end
    
  end
  --</Right Stripes>
  
  stripes.update = function ()
      for i=1,#stripes do
        stripes[i].y = stripes[i].y + h/40
        if (stripes[i].y > h) then
          stripes[i].y = -h/40
        end
      end
    end
  
  
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
  
  loadStripes()
  loadCars(2)
  
  --<Create Cars>
 
  --</Create Cars>
  
end



function love.update()
  cont = cont + 1
  stripes.update()
  
  if(cont > updateStep) then
    cont = 0   
    checkMsgs()
    for i,v in pairs(cars) do
      cars[i]:update()
    end
  end
end


function love.draw()
  for i=1,#stripes do
      love.graphics.draw( stripes[i].imagem, stripes[i].x, stripes[i].y)
  end
  
  for i,v in pairs(cars) do
      cars[i]:draw()
    end
end
  