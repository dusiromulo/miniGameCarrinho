PISTA_MODULE = {}
STRIPES_MODULE = require 'stripes'
OBSTACLES_MODULE = require 'obstacles'

local obstacleChance = 50
local w, h

function PISTA_MODULE.newPista()
  math.randomseed(os.time())
  
  pista = {
        stripes = STRIPES_MODULE.newStripe(),
        obstaculos = OBSTACLES_MODULE.newObstacles(),
        
        update = function(pista, pontos)
          if (math.random(100) > (100-obstacleChance)) then
            if (pista.obstaculos.numInstances() < 3) then
              pista.obstaculos.newObstacle(math.random(3))
              pista.obstaculos.newObstacle(math.random(3)+3)
              pista.obstaculos.newObstacle(math.random(3)+6)
            end
          end
          
          
          pista.stripes.update()
          pista.obstaculos.update(pontos, cars)
        end,
        
        draw = function(pista)
          pista.stripes.draw()
          pista.obstaculos.draw()
        end,

        
    }
    
  return pista
end


return PISTA_MODULE