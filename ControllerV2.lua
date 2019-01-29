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

		if key == keys.down then
			rednet.broadcast("down")
			state = "waiting"
		end

		if key == keys.s then
			rednet.broadcast("s")
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

		if key == keys.w then
			rednet.broadcast("w")
			state = "waiting"
		end

		if key == keys.enter then
			rednet.broadcast("enter")
			state = "waiting"
		end

		if key == keys.f then
			rednet.broadcast("f")
			break
		end

		if key == keys.r then
			rednet.broadcast("r")
			state = "waiting"
		end

		if key == keys.e then
			rednet.broadcast("e")
			break
		end
	else
		term.clear()
		local id,data =rednet.receive()
		term.clear()
		term.setCursorPos(1,1)
		print("Fuel:"..data[4].."  Direccion:"..data[5])
		print("Frente:"..data[1])
		print("Arriba:"..data[3])
		print("Abajo:"..data[2])

		term.setCursorPos(1,6)
		print("Mensaje:")
		print(data[6])

		term.setCursorPos(1,9)
		for i=1,16 do
			write(data[7][i].." ")
		end
		state = "ready"
	end
end



