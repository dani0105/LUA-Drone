--f=open("update","w")
--data = http.get("https://raw.githubusercontent.com/dani0105/LUA-Drone/master/Update.lua")
--f.write(data.readAll())
--file.close()

print("1) Drone")
print("2) Update")
print("3) DroneV2")
print("4) ControllerV2")


local option 	= tonumber(read())
local url 		= ""
local name		= ""
local data 		= "" 
local file		= ""
if option == 1 then
	url 	= "https://raw.githubusercontent.com/dani0105/LUA-Drone/master/Drone.lua"
	name 	= "Drone"
elseif option == 2 then
	url		= "https://raw.githubusercontent.com/dani0105/LUA-Drone/master/Update.lua"
	name 	= "update"
elseif option == 3 then 
	url		= "https://raw.githubusercontent.com/dani0105/LUA-Drone/master/DroneV2.lua"
	name 	= "DroneV2"
elseif option == 4 then 
	url		= "https://raw.githubusercontent.com/dani0105/LUA-Drone/master/ControllerV2.lua"
	name 	= "ControllerV2"
else
	print("opcion invalidad")
	return
end


data = http.get(url)

if fs.exists(name) then
	fs.delete(name)
end
file = fs.open(name,"w")
file.write(data.readAll())
file.close()


