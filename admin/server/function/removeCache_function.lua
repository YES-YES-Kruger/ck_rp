function admin_remove_cache_player(player, id)
	local level = 1

	if(AdminLevel(player, level)) then
		AddAdminLog(player, "admin :"..GetPlayerName(player).." remove cache for : " .. GetPlayerName(id))
		local steam_id = GetPlayerSteamId(id)
		KickPlayer(id,"😨 you were kicked by an administrator who works on your user data 😨" )
		Delay(1000, function()
			DestroyPlayerData(steam_id)
		end)
	end
 end