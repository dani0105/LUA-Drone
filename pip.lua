local internet = require("internet")
local shell = require("shell")
local args = shell.parse(...)
local io = require("io")
local component = require("component")
local modem = component.modem
local event = require("event")
local serialization = require("serialization")

function saveFile( filename,method,content)
	local file = io.open(filename,method)
	file:write(content)
	file:close()
end

if #args < 3 then
	print("Use pip install [url] [filename].lua : Used to install code from repositories (need internet card)")
	print("Use pip server [url] [filename].lua : Used to install code from repositories (need server)")
	return
end

if args[1] == "install" then
	local request = internet.request(args[2])
	local text = ""
	for line in request do
		text = text ..line.."\n"
	end
	saveFile(args[3],"w",text)
end

if args[1] == "server" then
	modem.close()
	modem.open(8081)
	modem.broadcast(8080,serialization.serialize({method="GET",url=args[2]}))
	local _, _, address, port, _, request = event.pull("modem_message")
	saveFile(args[3],"w",request)
end

print("installed success")