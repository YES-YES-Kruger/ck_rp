function admin_tp_to_pos(player, x, y, z)
	local level = 1

	if(AdminLevel(player, level)) then
		local msg = "teleport to x =" .. x ..", y= ".. y ..", z= " .. z
		AddAdminLog(player, msg)
		if (GetPlayerVehicleSeat(player) == 1) then
		local vehicle = GetPlayerVehicle(player)
		SetVehicleLocation(vehicle, x, y, z + 30)
		if (to[4] ~= -1.0) then
			SetVehicleHeading(vehicle, 0)
		end

			SetVehicleLinearVelocity(vehicle, 0.0, 0.0, 0.0, true)
			SetVehicleAngularVelocity(vehicle, 0.0, 0.0, 0.0, true)
			local rx, ry, rz = GetVehicleRotation(vehicle)
			SetVehicleRotation(vehicle, 0.0, ry, 0.0)
		else
			SetPlayerLocation(player, x, y, z + 30)
			if (0 ~= -1.0) then
				SetPlayerHeading(player, 0)
			end
		end
	end
 end

function admin_tp_to(main, to)
	local level = 1

	if(AdminLevel(main, level)) then
		AddAdminLog(main, GetPlayerName(main).." tp to " .. GetPlayerName(to))
		local x, y, z = GetPlayerLocation(to)
		admin_tp_to_pos(main, x, y, z)
	end
end

function get_admin_tp_preset_pos(player, target, dest)
	local level = 1

	if(AdminLevel(player, level)) then
		local pos = tonumber(dest)
		if(isnil(pos)) then pos = dest end
		GetPosByName( pos, player, target)
	end
end

AddRemoteEvent("admin_tp_preset_pos", function(player, target, x, y, z, h)
    admin_tp_to_pos(target, x, y, z)
end)