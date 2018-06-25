local msgr = require "src/util/mqttLoveLibrary"

local mensageiro = {}
local callbacks = {}

function callbackMsg(topic, msg)
	if callbacks[topic] ~= nil then
		callbacks[topic](msg)
	end
end

function mensageiro.cria(id, topic)
	msgr.start(id, topic, callbackMsg)
end

function mensageiro.addCallback(topic, callbackMsg)
	callbacks[topic] = callbackMsg
end

function mensageiro.check()
	msgr.checkMessages()
end

function mensageiro.send(msg, topic)
	msgr.sendMessage(msg, topic)
end

function mensageiro.sub(topic)
	msgr.subscribe(topic)
end

function mensageiro.unsub(topic)
	msgr.unsubscribe(topic)
end

function mensageiro.close()
	msgr.stop()
end

return mensageiro