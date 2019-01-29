rednet.open("right")
local state = "wating"

print("Puerto Abierto, listo para la conexion")
write("\nID de la computadora:")
local idComputer= tonumber(read())

print("esperando conexion")
while state == "wating" do
	local id,response =rednet.receive()
	if id == idComputer and response == "done" then
		state= "ready"
	end
end
local directions = {"norte","este","sur","oeste"}
local j = 1
local direction = directions[j]
local done,frente = turtle.inspect()
if done==false then frente="nada" end
local done,abajo = turtle.inspectUp()
if done==false then abajo="nada" end
local done,arriba = turtle.inspectDown()
if done==false then arriba="nada" end
fuel = turtle.getFuelLevels()

Table = {frente,abajo,arriba,fuel,direction}
rednet.send(idComputer,Table)


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
		if done==false then frente="nada" end
		local done,abajo = turtle.inspectUp()
		if done==false then abajo="nada" end
		local done,arriba = turtle.inspectDown()
		if done==false then arriba="nada" end
		fuel = turtle.getFuelLevels()


		Table = {frente,abajo,arriba,fuel,direction}
		rednet.send(idComputer,Table)

	end
end