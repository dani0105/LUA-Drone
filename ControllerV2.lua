rednet.open("back")

rednet.brodcast("done")
sleep(1)
local id,data =rednet.receive()


term.clear()
term.setCursorPos(1,1)
write("Fuel:"..data[5].."     Direccion:"..data[4])
term.setCursorPos(1,3)
print("Frente:".data[1])
print("Arriba:".data[2])
print("Abajo:".data[3])

local state = "ready"

while true do 
	if state == "ready" then
		local event, key = os.pullEvent("key")
		if key == keys.up then
			rednet.brodcast("up")
			state = "waiting"
		end
	else
		local id,data =rednet.receive()
		term.clear()
		term.setCursorPos(1,1)
		write("Fuel:"..data[5].."     Direccion:"..data[4])
		term.setCursorPos(1,3)
		print("Frente:".data[1])
		print("Arriba:".data[2])
		print("Abajo:".data[3])
		local state = "ready"
	end
end



