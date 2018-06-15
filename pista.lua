PISTA_MODULE = {}
STRIPES_MODULE = require 'stripes'
local w, h

function PISTA_MODULE.newPista()
  pista = {
        stripes = STRIPES_MODULE.newStripe(),
        obstaculos = {},
        
        update = function(pista)
          pista.stripes:update()
          --pista.obstaculos:update()
        end,
        
        draw = function(pista)
          pista.stripes:draw()
          --pista.obstaculos:draw()
        end,

        
    }
    
  return pista
end


return PISTA_MODULE