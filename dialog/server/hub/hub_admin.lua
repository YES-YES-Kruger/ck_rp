AddRemoteEvent("Exucute", function(playerid, json)
    local data = json_decode(json)
    local func = data['func']


    if(func == 'car_action') then
        if(isnil(data['car_id'])) then
            AddPlayerChat(playerid, "none id")
        else
            local am = false
            local b = false
            if(data['autopilote'] == 'on') then am = true end
            if(data['boost'] == 'on') then b = true end
            
            admin_car_spawn(playerid, data['car_id'], am, b, data['color'])
        end
    end

    if(func == 'health_action') then
        if(isnil(data['target'])) then
            AddPlayerChat(playerid, "none id")
        else
            local h = data['health']
            local t = data['target']
            
            admin_heal(playerid, t, h)
        end
    end

    if(func == 'armor_action') then
        if(isnil(data['target'])) then
            AddPlayerChat(playerid, "none id")
        else
            local a = data['armor']
            local t = data['target']
            
            admin_armor(playerid,t ,a)
        end
    end

    if(func == 'cloathing_action') then
        if(isnil(data['target'])) then
            AddPlayerChat(playerid, "none id")
        else
            local p = data['target']
            local cp = data['clothingPreset']
            
            admin_clothing_preset(playerid, p,  cp)
        end
    end

    if(func == 'weapon_action') then
        if(isnil(data['target'])) then
            AddPlayerChat(playerid, "none id")
        else
            local p = data['target']
            local w = data['weapon']
            local s = data['slot']
            local a = data['ammo']
            
            admin_weapon_spawn(p, w, s, a)
        end
    end

    if(func == 'kill_action') then
        if(isnil(data['target'])) then
            AddPlayerChat(playerid, "none id")
        else
            local p = data['target']
            
            admin_kill(playerid, p)
        end
    end

    if(func == 'tp_pos_action') then
        if(isnil(data['target'])) then
            AddPlayerChat(playerid, "none id")
        else
            local p = data['target']

            local x = data['x']
            local y = data['y']
            local z = data['z']
            
            admin_tp_to_pos(p, x, y, z)
        end
    end

    if(func == 'tp_to_action') then
        if(isnil(data['main']) or isnil(data['to'])) then
            AddPlayerChat(playerid, "none id")
        else
            local m = data['main']
            local t = data['to']

            admin_tp_to(m, t)
        end
    end

    if(func == 'tp_preset_action') then
        if(isnil(data['target'])) then
            AddPlayerChat(playerid, "none id")
        else
            local t = data['target']
            local pd = data['preset_id']

            get_admin_tp_preset_pos(playerid, t, pd)
        end
    end

    if(func == 'give_item_action') then
        if(isnil(data['target']) or isnil(data['quantity']) or isnil(data['item_id'])) then
            AddPlayerChat(playerid, "none id")
        else
            local t = data['target']
            local q = data['quantity']
            local ii = data['item_id']

            admin_addItem(playerid, t, ii, q)
        end
    end

    if(func == 'remove_item_action') then
        if(isnil(data['target']) or isnil(data['quantity']) or isnil(data['item_id'])) then
            AddPlayerChat(playerid, "none id")
        else
            local t = data['target']
            local q = data['quantity']
            local ii = data['item_id']

            admin_removeItem(playerid, t, ii, q)
        end
    end

    if(func == 'drop_object_items') then
        if(isnil(data['droped_id']) or isnil(data['action'])) then
            AddPlayerChat(playerid, "none id")
        else
            local id = data['droped_id']
            local act = data['action']

            if(act == "tp") then
                admin_teleport_droped_Item(playerid, id)
            end

            if(act == "del") then
                admin_delete_droped_Item(playerid, id)
            end
        end
    end
 end)

AddRemoteEvent("GetAllPlayer", function(player)
	local PlayerTable = { }
	
	for _, v in ipairs(GetAllPlayers()) do
        PlayerTable[v] = {
            GetPlayerName(v),
        }
	end
	
	CallRemoteEvent(player, "SetPlayerList", PlayerTable)
end)


AddRemoteEvent("GetItemsList", function(player)
	local ListTable = { }
    local arg = 0

    for id, item in pairs(_Items) do
        arg = arg + 1
        
        ListTable[arg] = {
            item.name,
            id,
        }
    end
	
	CallRemoteEvent(player, "SetItemsList", ListTable)
end)

AddRemoteEvent("GetDropItemList", function(player)
	local ListTable = { }
    local arg = 0

    for id, item in pairs(drop_list) do
        arg = arg + 1

        local pos = item.pos[1].." - "..item.pos[2].." - "..item.pos[3]
        local name = GetItemNameByModelId(item.model)
        
        ListTable[arg] = {
            ["id"] = id, 
            ["player"] = item.player, 
            ["pos"] = pos,
            ["model_name"] = name,
            ["quantity"] = item.quantity,
        }
    end
	
    CallRemoteEvent(player, "SetDropItemList", ListTable)

end)

