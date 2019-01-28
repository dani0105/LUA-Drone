rednet.open("right")
local option 	= false
local fuel 		= turtle.getFuelLevel()

print("Puerto Abierto, listo para la conexion")
write("\nID de la computadora:")

local idComputer= tonumber(read())

while true do
	local id,response =rednet.receive()
	local Table = {}
	if id ==idComputer then
		for i in string.gmatch(response,"%s+") do
			table.insert(Table,i)
		end

		if Table[1] == "go" then
			local level = turtle.getFuelLevel()
			while level < tonumber(Table[2])*2 do
				if turtle.refuel(1) == false then
					rednet.send(idComputer,"No hay Combustible")
					rednet.send(idComputer,"terminado;")
					break					
				end
				rednet.send(idComputer,"Recargando Fuel")
			end
			for i = 1,Table[2] do
				turtle.dig()
				turtle.forward()
			end
			rednet.send(idComputer,"Termine de Moverme")
			rednet.send(idComputer,"terminado;")
		end	

		if Table[1] == "turn" then
			if Table[2] == "left" then
				if Table[3] ~= null then
					for i=1,Table[3] do
						turtle.turnLeft()
					end
				else 
					turtle.turnLeft()
				end
			elseif Table[2] == "right" then
				if Table[3] ~= null then
					for i=1,Table[3] do
						turtle.turnRight()
					end
				else 
					turtle.turnRight()
				end
			end

			rednet.send(idComputer,"Girando")
		end

		if Table[1] == "suck" then
			while turtle.seuck() do
				rednet.send(idComputer,"Recolectando")
			end
			rednet.send(idComputer,"terminado;")
		end	

		if Table[1] == "up" then
			for i=1,Table[2] do
				turtle.digUp()
				turtle.up()
			end
			rednet.send(idComputer,"terminado;")
		end

		if Table[1] == "down" then
			for i=1,Table[2] do
				turtle.digDown()
				turtle.down()
			end
			rednet.send(idComputer,"terminado;")
		end

		if Table[1] == "refuel" then
			if option then
				if Table[2] == "Y" or Table[2] == "y" then
					if turtle.refuel(1) then
						rednet.send(idComputer,"Recargado")
						rednet.send(idComputer,"terminado;")
					else
						rednet.send(idComputer,"Error!")
						rednet.send(idComputer,"terminado;")
					end
				elseif Table[2] == "N" or Table[2] == "n" then
					rednet.send(idComputer,"terminado;")
				end
				option = false
			else
				Fuel 	= turtle.getFuelLevel()
				rednet.send(idComputer,"Combustible en: "..fuel)
				rednet.send(idComputer,"Recargar Y/N")
				option 	= true
				rednet.send(idComputer,"terminado;")
			end
		end

		if Table[1] == "scan" then
			local done,data = turtle.insepct()
			if done then
				rednet.send(idComputerer,"Bloque "..data.name)
				rednet.send(idComputer,"terminado;")
			else
				rednet.send(idComputer,"No Hay Bloques")
				rednet.send(idComputer,"terminado;")
			end
		end

		if Table[1] == "stop" then
			term.clear()
			term.setCursorPos(1,1)
			rednet.send(idComputer,"terminado;")
			break
		end
		rednet.send(idComputer,"Comando Invalido")
		rednet.send(idComputer,"terminado;")
	end
end