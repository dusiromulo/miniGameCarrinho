STRIPES_MODULE = {}

local function loadStripes(stripes)
  
  
  w, h = love.graphics.getDimensions()
  local stripeWidth = 9
  
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
    
  stripes.draw = function ()
          for i=1,#stripes do
            love.graphics.draw( stripes[i].imagem, stripes[i].x, stripes[i].y)
          end
        end
  
  
end

function STRIPES_MODULE.newStripe()
  stripes = {}
  loadStripes(stripes)
  return stripes
end



return STRIPES_MODULE