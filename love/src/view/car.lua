CARMODULE = {}
local w, h

function CARMODULE.newCar(startPos, posY, sprite)
  
  w, h = love.graphics.getDimensions()
  local carWidth = 44
    
  obj = {
      x = startPos - carWidth/2,
      y = posY,
      height = 89,
      lane = 2,
      carPositions = {startPos - 0.11*w - carWidth/2, startPos - carWidth/2, startPos + 0.11*w - carWidth/2},
      image = love.graphics.newImage(sprite),
      
      draw = function (car)
        love.graphics.draw( car.image, car.x, car.y)
      end,
      
      move = function(car, direction)
        if (direction == "left") then
          if (car.x == car.carPositions[2]) then
            car.x = car.carPositions[1]
            car.lane = car.lane - 1
          elseif (car.x == car.carPositions[3]) then
            car.x = car.carPositions[2]
            car.lane = car.lane - 1
          else
          end
        else
          if (car.x == car.carPositions[1]) then
            car.x = car.carPositions[2]
            car.lane = car.lane + 1
          elseif (car.x == car.carPositions[2]) then
            car.x = car.carPositions[3]
            car.lane = car.lane + 1
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