function admin_GetPlayerInfo(player, target, playerid)
    local data = getplayer(playerid)
    CallRemoteEvent(player, "SetInfoLst", 'name', data.name)
    CallRemoteEvent(player, "SetInfoLst", 'id', data.id)
    CallRemoteEvent(player, "SetInfoLst", 'id_client', data.id_client)
    CallRemoteEvent(player, "SetInfoLst", 'admin', data.admin)
    CallRemoteEvent(player, "SetInfoLst", 'steamId', data.steamId)
    CallRemoteEvent(player, "SetInfoLst", 'Health', data:getHealth())
    CallRemoteEvent(player, "SetInfoLst", 'Armor', data:getArmor())
    CallRemoteEvent(player, "SetInfoLst", 'CashAccount', data:getCashAccount())
    CallRemoteEvent(player, "SetInfoLst", 'Cash', data:getCash())
    CallRemoteEvent(player, "SetInfoLst", 'food', data.food)
    CallRemoteEvent(player, "SetInfoLst", 'thirst', data.thirst)
    CallRemoteEvent(player, "SetInfoLst", 'clothing', data.clothing)
    CallRemoteEvent(player, "SetInfoLst", 'inv', data.inventory)
    CallRemoteEvent(player, "SetInfoLst", 'MaxWeight', data.MaxWeight)
    CallRemoteEvent(player, "SetInfoLst", 'CurWeight', data.CurWeight)
    CallRemoteEvent(player, "SetInfoLst", 'alert_count', data.alert_count)
    CallRemoteEvent(player, "SetInfoLst", 'backup_status', tostring(data:getBackUpStatus()))
end
