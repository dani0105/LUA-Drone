local internet = require("internet")
local component = require("component")
local modem = component.modem
local event = require("event")
local serialization = require("serialization")
modem.close()
modem.open(8080)

print("Server started in 8080")
while true do
	local _, _, address, port, _, request = event.pull("modem_message")
	request = serialization.unserialize(request)

	if not request["method"] or not request["url"] then
		print("Request rejected")	
	else
		if request["method"] == "GET" then
			local response = internet.request(request["url"])
			local text = ""
			for line in response do
				text = text.. line.."\n"
			end
			modem.send(address,8081,text)
			print("send")
		elseif request["method"] == "POST" then
		else
		end
	end
end
end