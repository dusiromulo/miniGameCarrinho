local msgr = require "src/util/mqttLoveLibrary"

local mensageiro = {}

function mensageiro.cria(id, topic, callbackMsg)
	msgr.start(id, topic, callbackMsg)
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