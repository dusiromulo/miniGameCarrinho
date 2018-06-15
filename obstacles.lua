OBSTACLES_MODULE = {}
obstaclePositions = {}


function createObstacles(posX)
  local _,h = love.graphics.getDimensions()
  local obstacleWidth = 102

  obstaclePositions[1] = w*0.055 - obstacleWidth/2
  obstaclePositions[2] = w*0.055 - obstacleWidth/2 + 0.11*w
  obstaclePositions[3] = w*0.055 - obstacleWidth/2 + 0.22*w
  obstaclePositions[4] = w*0.055 - obstacleWidth/2 + 0.33*w
  obstaclePositions[5] = w*0.055 - obstacleWidth/2 + 0.44*w
  obstaclePositions[6] = w*0.055 - obstacleWidth/2 + 0.55*w
  obstaclePositions[7] = w*0.055 - obstacleWidth/2 + 0.66*w
  obstaclePositions[8] = w*0.055 - obstacleWidth/2 + 0.77*w
  obstaclePositions[9] = w*0.055 - obstacleWidth/2 + 0.88*w
  
  obst = {}
  
  
  if (posX<4) then
    obst.player = 1
  elseif (posX<7) then
    obst.player = 2
  else
    obst.player = 3
  end
  
  if (posX<4) then
    obst.lane = posX
  elseif (posX<7) then
    obst.lane = posX-3
  else
    obst.lane = posX-6
  end
  
  obst.x = obstaclePositions[posX]
  
  obst.y = 0
  obst.cont = 0
  obst.speed = h/100
  obst.destroy = false
  obst.update = function (target, pontos, cars)
      target.cont = 0
      target.y = target.y + target.speed
      if (target.y > h) then
        pontos[target.player] = pontos[target.player] + 1
        target.destroy = true
      end
      
      if (target.y >= cars[target.player].y and target.y <= cars[target.player].y+cars[target.player].height) then
        if (target.lane == cars[target.player].lane) then
          target.destroy = true
        end
      end
      
      
  end
    
    
  
  obst.image = love.graphics.newImage("images/obstacle.png")
  obst.draw = function (target)
    love.graphics.draw( target.image, target.x, target.y)
  end
  
    
  
  return obst
end


function OBSTACLES_MODULE.newObstacles()
  obstacles ={}
  
  
  
  obstacles.draw = function()
    for i = 1,#obstacles do
      obstacles[i]:draw()
    end
  end
  
  obstacles.update = function(pontos)
    if (#obstacles < 1) then
      return 
    end
    
    continue = true
    
    for i = 1,#obstacles do
      if (continue == true) then
        obstacles[i]:update(pontos, cars)
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
    obstacles[#obstacles+1] = createObstacles(x)
  end
  

  return obstacles
end


return OBSTACLES_MODULE