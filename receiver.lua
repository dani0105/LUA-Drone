local component = require("component")
local modem = component.modem
local shell = require("shell")
local event = require("event")
local args = shell.parse(...)
local serialization = require("serialization")
local keyboard = require("keyboard")
local term = require("term")
local robot = require("robot")


modem.close()

if #args < 1 then
	print("Use command transmitter[port]")
	return
end

if not tonumber(args[1]) then
	print("Please insert number")
	return
end

local port =tonumber(args[1])
modem.open(port-1)

function receiverData()
	local _, _, address, _, _, data = event.pull("modem_message")
	return serialization.unserialize(data)
end

function  sendData(port, running )
	modem.broadcast(port, serialization.serialize({state = running}))
end

sendData(port,true)

while true do
	local data = receiverData()

	if not data["transmitter"] then
		break
	end

	if data["direction"] == keyboard.keys.a then
		robot.turnLeft()
	end
	if data["direction"] == keyboard.keys.w then
		robot.swing()
		robot.forward()
	end
	if data["direction"] == keyboard.keys.s then
		robot.back()
	end
	if data["direction"] == keyboard.keys.d then
		robot.turnRight()
	end

	--down
	if data["direction"] == keyboard.keys.q then
		robot.swingDown()
		robot.down()
	end

	--up
	if data["direction"] == keyboard.keys.e then
		robot.swingUp()
		robot.up()
	end

	if data["direction"] == keyboard.keys.r then
		while robot.suck() do
		end
	end

	sendData(port,true)
end

print("closed")