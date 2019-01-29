rednet.open("back")
local state = "ready"
while true do 
	if state == "ready" then
		local event, key = os.pullEvent("key")
		if key == keys.up then
			rednet.broadcast("up")
			state = "waiting"
		end

		if key == keys.enter then
			rednet.broadcast("up")
			state = "waiting"
		end
	else
		term.clear()
		local id,data =rednet.receive()
		term.clear()
		term.setCursorPos(1,1)
		write("Fuel:"..data[4].."     Direccion:"..data[5])
		term.setCursorPos(1,3)
		print("Frente:"..data[1])
		print("Arriba:"..data[3])
		print("Abajo:"..data[2])
		local state = "ready"
	end
end



