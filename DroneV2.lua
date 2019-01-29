rednet.open("right")
print("Puerto Abierto, listo para la conexion")
write("\nID de la computadora:")
local idComputer= tonumber(read())

local directions = {"norte","este","sur","oeste"}
local j = 1
local direction = directions[j]
local errorText = ""

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
			turtle.digUp()
			turtle.up()
		end

		if response == "down" then
			turtle.digDown()
			turtle.down()
		end

		if response == "f" then
			break
		end

		if response == "e" then
			while turtle.suck() do

			end
			errorText = "Recoleccion terminada"
		end

		if response == "r" then
			if turtle.refuel() == false then 
				errorText="no se pude recargar"
			else
				errorText="recargado"
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

		if done then
			arriba=arriba.name
		else
			arriba = "nada"
		end
		local done,abajo = turtle.inspectDown()
		if done then
			abajo=abajo.name
		else
			abajo = "nada"
		end

		fuel = turtle.getFuelLevel()
		local inventory = {}
		for i=1,16 do
			table.insert(inventory,turtle.getItemCount(i))
		end
		Table = {frente,arriba,abajo,fuel,direction,errorText,inventory}
		rednet.send(idComputer,Table)

	end
end