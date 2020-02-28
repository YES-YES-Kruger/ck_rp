local anim_drop = "PICKUP_LOWER"

function CreateDropItem(player, item_id)
    local x, y, z = GetPlayerLocation(player)
    local ph = GetPlayerHeading(player)
    local Vx, Vy, Vz = GetPlayerForward(player)

    local obj = CreateObject(item_id, x, y, z)

    SetPlayerAnimation(player, anim_drop)
    SetObjectAttached(obj, ATTACH_PLAYER, player, 0, 0.0, 0.0, 0.0, 0,0, "hand_l")

    os.sleep(1.6)

    SetObjectDetached(obj)
    SetObjectLocation(obj, x + (Vx * 200), y + (Vy * 200), z - 100)
    SetObjectRotation(obj, 0, ph, 0)

end

function GetPlayerForward(playerid)
	local deg = GetPlayerHeading(playerid)
	local rad = math.rad(deg)
	local x = math.cos(rad)
	local y = math.sin(rad)
	return x, y, 0
end