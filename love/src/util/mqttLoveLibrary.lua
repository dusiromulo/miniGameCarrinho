mqttLove = require('src/util/mqtt')

local HOST = 'test.mosquitto.org' 
local PORT = 1883

local mqttClient
local defaultTopic 

MQTT = {}


--[[
  function to start the mqttClient. It connects to the broker and subscribes to a predefined channel.
  id: unique id for the user
  callbackFunction: optional, function to be called when the application receives a message. 
]]
function MQTT.start(id, listchannel, callbackFunction)
	callback = callbackFunction
	defaultTopic = id .. 'node'
	listchannel = listchannel or id..'love'
	mqttClient = mqttLove.client.create(HOST, PORT, function (topic , message)
		print("received message " .. message .. " from topic " .. topic)
		callback(message)
	end) 
	connectErrorMessage = mqttClient:connect(id..'love') 
	if(connectErrorMessage) then
		print("Error connecting! "..connectErrorMessage)
	end
	mqttClient:subscribe({listchannel})
	print("connecting to " .. listchannel)
end

--[[
	function to close connection from mqttClient
]]
function MQTT.stop()
	mqttClient:disconnect() 
	print("closing mqtt connection")
end

--[[
  function to send a message
  message: message to be sent
  topic: optional, channel to send the message. If nil the message will be sent to a default channel
]]
function MQTT.sendMessage(message,topic)
	topic = topic or defaultTopic -- default topic for publishing
	mqttClient:publish(topic, message)
	print ("sending message ".. message .. " to topic " .. topic)
end

--[[
  function to check if messages were received in the subscribed channels
]]
function MQTT.checkMessages()
	errorMessage = mqttClient:handler()
	if(errorMessage) then
		print("Error checking for messages! "..errorMessage)
	end
end

--[[
	function to subscribe to topics
]]
function MQTT.subscribe(topic)
	mqttClient:subscribe({topic})
	print("connecting to " .. topic)
end

--[[
	function to unsubscribe from topics
]]
function MQTT.unsubscribe(topic)
	mqttClient:unsubscribe({topic})
	print("disconnecting from " .. topic)
end

return MQTT
