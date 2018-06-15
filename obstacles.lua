OBSTACLES_MODULE = {}
obstaclePositions = {}


function createObstacles(posX)
  local _,h = love.graphics.getDimensions()
  local obstacleWidth = 100

  obstaclePositions[1] = 0.17*w - obstacleWidth
  obstaclePositions[2] = 0.17*w - obstacleWidth + 0.33*w
  obstaclePositions[3] = 0.17*w - obstacleWidth + 0.66*w
  
  obst = {}
  
  obst.x = obstaclePositions[posX]
  obst.y = 0
  obst.cont = 0
  obst.speed = h/100
  obst.destroy = false
  obst.update = function (target)
      target.cont = 0
      target.y = target.y + target.speed
      if (target.y > h) then
        target.destroy = true
      end
  end
    
    
  
  obst.image = love.graphics.newImage("images/obstacle.png")
  obst.draw = function (target)
    love.graphics.draw( target.image, target.x, target.y)
  end
  
    
  
  return obst
end


function OBSTACLES_MODULE.newObstacles()
  obstacles = {}
  
  obstacles.draw = function()
    for i = 1,#obstacles do
      obstacles[i]:draw()
    end
  end
  
  obstacles.update = function()
    if (#obstacles < 1) then
      return 
    end
    
    continue = true
    
    for i = 1,#obstacles do
      if (continue == true) then
        obstacles[i]:update()
        if (obstacles[i].destroy == true) then
          table.remove(obstacles,i)
          continue = false
        end
      end
    end
    
  end
  
  obstacles.numInstances = function()
    return #obstacles
  end
  

  obstacles.newObstacle = function (x)
    obstacles[#obstacles+1] = createObstacles(x, nome)
  end
  

  return obstacles
end


return OBSTACLES_MODULE