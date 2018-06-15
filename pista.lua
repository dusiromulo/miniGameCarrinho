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
        
        update = function(pista)
          if (math.random(100) > (100-obstacleChance)) then
            if (pista.obstaculos.numInstances() < 4) then
              pista.obstaculos.newObstacle(math.random(3))
            end
          end
          
          
          pista.stripes.update()
          pista.obstaculos:update()
        end,
        
        draw = function(pista)
          pista.stripes.draw()
          pista.obstaculos:draw()
        end,

        
    }
    
  return pista
end


return PISTA_MODULE