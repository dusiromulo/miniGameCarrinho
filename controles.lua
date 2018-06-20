local msgr = require "mqttLoveLibrary"

controles = {}
instance = {}

instance.assign = function(player,car)
  if #controles < 3 then
    controles[#controles + 1] = 
    {
      id = "Player"..player,
      carro = car,
      carregar = function(controle)
        print(controle.id)
        msgr.start(controle.id,controle.id,controle.move)
      end,
      move = function(msg)
        print(msg)
        if msg:find("right") then
          carro:move("right")
        elseif msg:find("left") then
          carro:move("left")
        end
      end,
      update = function()
        msgr.checkMessages()
      end
    }
    
    controles[#controles]:carregar()
  end
end


instance.update = function()
    for i=1,#controles do
      controles[i].update()
    end
end



return instance