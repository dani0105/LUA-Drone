rednet.open("right")
print("Puerto Abierto, listo para la conexion")
write("\nID de la computadora:")
local idComputer= tonumber(read())

local directions = {"norte","este","sur","oeste"}
local j = 1
local direction = directions[j]

while true do
	local id,response =rednet.receive()
	if id ==idComputer then
		
		if response == "w" then 
			turtle.dig()
			turtle.forward()
		end

		if response == "d" then
			turtle.turnRight()
			j = j+ 1
		end

		if response == "a" then
			turtle.turnLeft()
			j = j- 1
		end

		if response == "s" then
			turtle.back()
		end

		if response == "up" then
			turtle.up()
		end

		if response == "down" then
			turtle.down()
		end

		if response == "r" then
			if turtle.refuel() == false then 
				rednet.send(idComputer,"error")
			else
				rednet.send(idComputer,"completado")
			end

		end

		if j > 4 then j = 1 end
		if j < 1 then j = 4 end
		direction = directions[j]

		local done,frente = turtle.inspect()

		if done then 
			frente= frente.name
		else
			frente = "nada"
		end
		local done,arriba = turtle.inspectUp()

		if done==false then
			arriba=arriba.name
		else
			arriba = "nada"
		end
		local done,abajo = turtle.inspectDown()

		if done==false then
			abajo=abajo.name
		else
			abajo = "nada"
		end

		fuel = turtle.getFuelLevel()
		Table = {frente,abajo,arriba,fuel,direction}
		rednet.send(idComputer,Table)

	end
end