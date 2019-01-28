print("1) Drone")
print("2) Update")

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


