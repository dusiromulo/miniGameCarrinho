CARMODULE = {}
carPositions = {}
local w, h

function CARMODULE.newCar(posIndex, posY, sprite)
  
  w, h = love.graphics.getDimensions()
  local carWidth = 44

  carPositions[1] = 0.17*w - carWidth
  carPositions[2] = 0.17*w - carWidth + 0.33*w
  carPositions[3] = 0.17*w - carWidth + 0.66*w
    
  obj = {
      x = carPositions[posIndex],
      y = posY,
      image = love.graphics.newImage(sprite),
      
      draw = function (car)
        love.graphics.draw( car.image, car.x, car.y)
      end,
      
      move = function(car, direction)
        if (direction == "left") then
          if (car.x == carPositions[2]) then
            car.x = carPositions[1]
          elseif (car.x == carPositions[3]) then
            car.x = carPositions[2]
          else
          end
        else
          if (car.x == carPositions[1]) then
            car.x = carPositions[2]
          elseif (car.x == carPositions[2]) then
            car.x = carPositions[3]
          else
          end
        end
      end,
      
      update = function(car)
      end    
      
  }
  
  return obj
  
end

return CARMODULE