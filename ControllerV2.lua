rednet.open("back")
local state = "ready"
term.clear()
print("Press Enter")
while true do 
	local event, key
	if state == "ready" then
		event, key = os.pullEvent("key")
		if key == keys.up then
			rednet.broadcast("up")
			state = "waiting"
		end

		if key == keys.a then
			rednet.broadcast("a")
			state = "waiting"
		end

		if key == keys.d then
			rednet.broadcast("d")
			state = "waiting"
		end

		if key == keys.enter then
			rednet.broadcast("")
			state = "waiting"
		end
	else
		term.clear()
		local id,data =rednet.receive()
		term.clear()
		term.setCursorPos(1,1)
		write("Fuel:"..data[4].."     Direccion:"..data[5])
		term.setCursorPos(1,3)
		write("Frente:"..data[1])
		term.setCursorPos(1,4)
		write("Arriba:"..data[3])
		term.setCursorPos(1,5)
		write("Abajo:"..data[2])
		state = "ready"
	end
end



