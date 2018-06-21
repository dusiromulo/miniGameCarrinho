local msgr = require "src/util/mqttLoveLibrary"

--[[controles = {}
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



return instance]]--


msgr.start(minhaMat, minhaMat .. "love",  receivedMessage)

local controle = {
	a = 0,
	b = 0,
	conjugate = function (obj)
		return complex.cria(obj.a, -obj.b)
	end,
	magnitude = function (obj)
		return math.sqrt(obj.a^2 + obj.b^2)
	end,
	print = function (obj)
		print("{a = " .. tostring(obj.a) .. ", b = " .. tostring(obj.b) .. "}")
	end,
}

local mt = {
	__index = complex,
	__add = function (obj1, obj2)
		return complex.cria(obj1.a + obj2.a, obj1.b + obj2.b)
	end,
	__sub = function (obj1, obj2)
		return complex.cria(obj1.a - obj2.a, obj1.b - obj2.b)
	end,
	__mul = function (obj1, obj2)
		return complex.cria(obj1.a*obj2.a - obj1.b*obj2.b, obj1.b*obj2.a + obj1.a*obj2.b)
	end,
	__div = function (obj1, obj2)
		local aVal = (obj1.a*obj2.a + obj1.b*obj2.b) / (obj2.a^2 + obj2.b^2)
		local bVal = (obj1.b*obj2.a - obj1.a*obj2.b) / (obj2.a^2 + obj2.b^2)

		return complex.cria(aVal, bVal)
	end,
	__unm = function (obj)
		return complex.cria(-obj.a, -obj.b)
	end,
	__eq = function (obj1, obj2)
		local errorLim = 0.00001
		return math.abs(obj1.a-obj2.a) < errorLim and math.abs(obj1.b-obj2.b) < errorLim
	end
}

function controle.cria(a, b)
	if a ~= nil and b ~= nil then
		comp = {a=a, b=b}
	elseif a ~= nil then
		comp = {a=a}
	elseif b ~= nil then
		comp = {b=b}
	end

	setmetatable(comp, mt)
	return comp
end

return controle