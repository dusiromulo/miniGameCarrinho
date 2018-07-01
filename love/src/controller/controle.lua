local mensageiro = require "src/util/mensageiro"

local controle = {
	id = nil,
	callback_esq = nil,
	callback_dir = nil,
	callback_both = nil,
	mensagemRecebida = function (obj, msg)
		if (msg == "esq") then
			obj:callback_esq()
		elseif (msg == "dir") then
			obj:callback_dir()
		elseif (msg == "ambos") then
			obj.callback_both()
		end
	end,
	update = function(obj)
		mensageiro.check()
	end
}

local mt = {
	__index = controle,
}

function controle.cria(id, playerChannel, callback_esq, callback_dir, callback_both)
	local control = {
		id = id,
		callback_esq = callback_esq,
		callback_dir = callback_dir,
		callback_both = callback_both
	}
	setmetatable(control, mt)
	
	mensageiro.sub(playerChannel)
	mensageiro.addCallback(playerChannel, function(msg) control:mensagemRecebida(msg) end)
	return control
end

return controle