local mensageiro = require "src/util/mensageiro"

local novo_jogador = {
	fromTopic = "new_player_mini_game_love",
	toTopic = "new_player_mini_game_node",
	totalPlayers = 0,
	callback_nova_conexao = nil,
	callback_pronto_para_nova_conexao = nil,
	mensagemRecebida = function (obj, msg)
		if obj.callback_pronto_para_nova_conexao() and obj.totalPlayers < 3 then
			obj.totalPlayers = obj.totalPlayers + 1
			mensageiro.send(msg .. "," .. obj.totalPlayers, obj.toTopic)
			nome = string.match(msg, "%D+")
			obj.callback_nova_conexao(nome, obj.totalPlayers)
		end
	end,
	update = function(obj)
		mensageiro.check()
	end
}

local mt = {
	__index = novo_jogador,
}

function novo_jogador.cria(callback_nova_conexao, callback_pronto_para_nova_conexao)
	novo_jogador = {}
	setmetatable(novo_jogador, mt)
	
	novo_jogador.callback_nova_conexao = callback_nova_conexao
	novo_jogador.callback_pronto_para_nova_conexao = callback_pronto_para_nova_conexao
	mensageiro.cria("0", novo_jogador.fromTopic)
	mensageiro.addCallback(novo_jogador.fromTopic, function(msg) novo_jogador:mensagemRecebida(msg) end)
	return novo_jogador
end

return novo_jogador