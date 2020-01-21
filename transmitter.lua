local component = require("component")
local modem = component.modem
local shell = require("shell")
local args = require("event")
local serialization = require("serialization")
local keyboard = require("keyboard")
local term = require("term")

function send(address, port, key, running)
	local porsen = tonumber(port) - 1
	modem.broadcast(portsend, serialization.serilize({direction = key,transmitter = running}))
end

modem.close()

if #args < 1 then
	print("Use command transmitter[port]")
	return
end

if not tonumber(args[1]) then
	print("Please insert number")
	return
end

local port = tonumber(args[1])
print("Listening in port "..port)
local robotAddress = ""
modem.open(port)

if modem.isOpen(port) then
	local connected = false
	while true do
		if not connected then
			local _, _, address, _, _, data  event.pull("modem_message")
			data = serialization.unserialize(data)
			if data["state"] then
				print(address..
				" is connected")
				connected = true
				robotAddress = address
			end
		else
			print("A:left D:Right W:Forward S:Back  T:End Program  E:UP  Q:Down  R:Suck")
			local eventKey, address, arg1, arg2, arg3 = term.pull()
			if eventKey == "key_down" then
				if arg2 == keyboard.keys.t then
					print("Disconnected")
					connected = false
					send(robotAddress, port, arg2, connected)
					break
				end
				send(robotAddress, port, arg2, connected)

				local _, _, _, _, _, response  event.pull("modem_message")
				response = serialization.unserialize(response)
			end	
		end
	end
end


