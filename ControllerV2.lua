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
	else
		term.clear()
		local id,data =rednet.receive()
		term.clear()
		term.setCursorPos(1,1)
		print("Fuel:"..data[4].."  Direccion:"..data[5])
		write("x:"..data[6].."y:"..data[7].."x:"..data[8])

		local turtle = vector.new(data[6], data[7], data[8])
		local position = vector.new(gps.locate(5))
		write("  distancia:"..tostring(turtle-position))
		print("Frente:"..data[1])
		print("Arriba:"..data[3])
		print("Abajo:"..data[2])
		state = "ready"
	end
end



