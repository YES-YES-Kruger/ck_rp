-- by dictateurfou
local importedFile = {}

function import(filename)
	if(importedFile[filename] == nil) then
		local f = assert(loadfile("packages/"..filename))
		importedFile[filename] = true
		print("-- loadead " .. filename)
		return f()
	end
end

local account = import("account/server/sr_account.lua")
import("cmd/server/sr_admin.lua")
import("cmd/server/sr_client.lua")
import("cmd/server/sr_teleport.lua")