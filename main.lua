local w, h
local stripeWidth = 9
local carWidth = 44
local cont = 0
local updateStep = 50
carPositions = {}
stripes = {}
cars = {}

function love.load()
  love.window.setMode(1280,720)
  love.graphics.setBackgroundColor(1,1,1)
  w, h = love.graphics.getDimensions()
  
  carPositions[1] = 0.17*w - carWidth
  carPositions[2] = 0.17*w - carWidth + 0.33*w
  carPositions[3] = 0.17*w - carWidth + 0.66*w
  local darkImg = love.graphics.newImage("images/dark.png")
  local lightImg = love.graphics.newImage("images/light.png")
  --<Left Stripes>
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
  
  --<Cars>
  for i=0,1 do
    cars[#cars+1] = {
                        x = carPositions[i+1],
                        y = h*0.8
                    }
    if (math.fmod(i,2) == 0) then
      cars[#cars].imagem = love.graphics.newImage("images/car1.png")
    else
      cars[#cars].imagem = love.graphics.newImage("images/car2.png")
    end
    
  end
  --</Cars>
  
end

function love.update()
  cont = cont + 1
  if (love.keyboard.isDown("w")) then
    for i=1,#stripes do
      stripes[i].y = stripes[i].y + h/40
      if (stripes[i].y > h) then
        stripes[i].y = -h/40
      end
    end
  end
  
  if(cont > updateStep) then
    cont = 0
    
    --<control Car1>
    if (love.keyboard.isDown("d")) then
        if (cars[1].x == carPositions[1]) then
          cars[1].x = carPositions[2]
        elseif (cars[1].x == carPositions[2]) then
          cars[1].x = carPositions[3]
        else
        end
    end
  
    if (love.keyboard.isDown("a")) then
        if (cars[1].x == carPositions[2]) then
          cars[1].x = carPositions[1]
        elseif (cars[1].x == carPositions[3]) then
          cars[1].x = carPositions[2]
        else
        end
    end
    --</control Car1>
    
    --<control Car2>
    if (love.keyboard.isDown("e")) then
        if (cars[2].x == carPositions[1]) then
          cars[2].x = carPositions[2]
        elseif (cars[2].x == carPositions[2]) then
          cars[2].x = carPositions[3]
        else
        end
    end
  
    if (love.keyboard.isDown("q")) then
        if (cars[2].x == carPositions[2]) then
          cars[2].x = carPositions[1]
        elseif (cars[2].x == carPositions[3]) then
          cars[2].x = carPositions[2]
        else
        end
    end
    --</control Car2>
  
  end
end

function love.draw()
  for i=1,#stripes do
      love.graphics.draw( stripes[i].imagem, stripes[i].x, stripes[i].y)
  end
  
  for i=1,#cars do
      love.graphics.draw( cars[i].imagem, cars[i].x, cars[i].y)
  end
end
  
