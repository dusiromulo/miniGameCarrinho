local msgr = require "src/mqttLoveLibrary"

local novo_jogador = {
	callback_nova_conexao = nil,
}

local mt = {
	__index = novo_jogador,
}

function novo_jogador.cria(callback_nova_conexao)
	instance = {}
	setmetatable(instance, mt)
	instance.callback_nova_conexao = callback_nova_conexao
	msgr.start("0", "new_player_mini_game_carrinho_love",  receivedMessage)
	return instance
end

return novo_jogador