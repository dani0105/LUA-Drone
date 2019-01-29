rednet.open("back")
local state = "ready"
term.clear()

term.setCursorPos(6,4)
print("   ID: "..os.getComputerID())
term.setCursorPos(5,6)
term.setTextColour( colours.green )
term.write("Press Enter")
while true do 
	local event, key
	if state == "ready" then
		event, key = os.pullEvent("key")
		if key == keys.up then
			rednet.broadcast("up")
		end

		if key == keys.down then
			rednet.broadcast("down")
		end

		if key == keys.s then
			rednet.broadcast("s")
		end

		if key == keys.a then
			rednet.broadcast("a")
		end

		if key == keys.d then
			rednet.broadcast("d")
		end

		if key == keys.w then
			rednet.broadcast("w")
		end

		if key == keys.enter then
			rednet.broadcast("enter")
		end

		if key == keys.f then
			rednet.broadcast("f")
			break
		end

		if key == keys.r then
			rednet.broadcast("r")
		end

		if key == keys.e then
			rednet.broadcast("e")
			break
		end

		state = "waiting"
	else
		term.clear()
		local id,data =rednet.receive()
		term.clear()
		term.setCursorPos(1,1)
		term.setTextColour( colours.white )
		term.setBackgroundColour( colours.blue )
		term.write("Fuel:"..data[4].."  Direccion:"..data[5])
		print("Frente:"..data[1])
		print("Arriba:"..data[3])
		print("Abajo:"..data[2])

		term.setCursorPos(1,6)
		print("Mensaje:")
		term.setCursorPos(1,7)
		term.setTextColour( colours.yellow )
		term.setBackgroundColour( colours.black )
		term.write(data[6])

		term.setCursorPos(1,9)
		print("Inventario")
		local f = 1
		for i=1,16 do
			f = f+1
			if data[7][i] > 32 and data[7][i] < 49 then
				term.setTextColour( colours.yellow )
			elseif data[7][i] > 50 then
				term.setTextColour( colours.red )
			else
				term.setTextColour( colours.lime )
			end
			if f > 4 then
				term.write("\n"..data[7][i].." ")
				f=1
			else
				term.write(data[7][i].." ")
			end
		end
		state = "ready"
	end
end
term.clear()
term.setCursorPos(1,1)



