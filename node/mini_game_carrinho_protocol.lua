local msgr = require "mqttNodeMCULibrary"

local led1 = 3
local led2 = 6
local sw1 = 1
local sw2 = 2

local playerName = "Player"
local playerRand = math.floor(math.random(1, 99999))
local playerNumber = ""

local playerPosTopic = "_mini_game_love"
local playTopicName = "new_player" .. playerPosTopic
local isPlaying = false

local maxTimeTriggerTiro = 200000 -- 200 ms!
local lastBtn1Press, lastBtn2Press = 0, 0

gpio.mode(sw1, gpio.INPUT, gpio.PULLUP)
gpio.mode(sw2, gpio.INPUT, gpio.PULLUP)
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)


local function moveLeft(_, time)
    print("pressionou chave 1")
    
    if isPlaying then
        if time - lastBtn2Press < maxTimeTriggerTiro then
            msgr.sendMessage("ambos", playTopicName)
        else 
            msgr.sendMessage("esq", playTopicName)
        end
        lastBtn1Press = time
    else
        msgr.sendMessage(playerName..playerRand, playTopicName)
    end
end

local function moveRight(_, time)
    print("pressionou chave 2")
    if isPlaying then
        if time - lastBtn1Press < maxTimeTriggerTiro then
            msgr.sendMessage("ambos", playTopicName)
        else 
            msgr.sendMessage("dir", playTopicName)
        end
        lastBtn2Press = time
    else
        msgr.sendMessage(playerName..playerRand, playTopicName)
    end
end

local function mensagemRecebida (mensagem)
    print("Mensagem recebida: " .. mensagem)
    if (string.match(mensagem, playerName..playerRand)) then
        isPlaying = true
        pos = string.find(mensagem, ",")
        playerNumber = tonumber(string.sub(mensagem, pos+1))
        msgr.subToNewTopic(playerName .. playerNumber .. playerPosTopic)
    end
end

gpio.trig(sw1, "down", moveLeft)
gpio.trig(sw2, "down", moveRight)
msgr.start(playerName, "new_player_mini_game_node", mensagemRecebida)
