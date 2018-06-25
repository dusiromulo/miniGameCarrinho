local mensageiro = require "src/util/mensageiro"

local controle = {
	callback_esq = nil,
	callback_dir = nil,
	callback_both = nil,
	mensagemRecebida = function (obj, msg)
		print(msg)
		if (msg == "esq") then
			obj.callback_esq()
		elseif (msg == "dir") then
			obj.callback_dir()
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
	control = {}
	setmetatable(control, mt)
	control.callback_esq = callback_esq
	control.callback_dir = callback_dir
	control.callback_both = callback_both
	print(playerChannel)
	mensageiro.cria(id, playerChannel, function(msg) control:mensagemRecebida(msg) end)

	return control
end

return controle