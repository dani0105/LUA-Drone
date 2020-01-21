local internet = require("internet")
local shell = require("shell")
local args = shell.parse(...)
local io = require("io")

if #args < 3 then
	print("Use pip install [url] [filename] ")
	print("Used to install code from repositories")
	return
end

if args[1] == "install" then
	local request = internet.request(args[2])
	local text = ""
	for line in request do
		text = text ..line.."\n"
	end
	local file = io.open(args[3],"w")
	file:write(text)
	file:close()
end