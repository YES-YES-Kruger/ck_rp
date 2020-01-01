-- setup var
playerData = {}

-- import package
playerData.ClassPlayer = import("account/class/player.lua")
db = import("database/server/sr_connect.lua")

-- request
local Request = {
    IfplayerAccountExist = "SELECT id FROM accounts WHERE steam_id = '?' LIMIT 1;",
    CreatePlayerAccount = "INSERT INTO accounts (id, admin, steam_id, health,name, cash) VALUES (NULL, '?', '?', '?', '?', '?');",
    GetPlayerAccount = "SELECT * FROM accounts WHERE steam_id = '?';",
    SaveAccount = "UPDATE accounts SET cash= ? WHERE steam_id = ? LIMIT 1;"
}

---- package
function cmd_commands(playerid)
    SaveAccountPlayer(playerid)
    AddPlayerChat(playerid, "[server] your data has been save")
	return
end
AddCommand("save", cmd_commands)


function OnPackageStop()
    -- Save all player data automatically 
    CreateTimer(function()
        for key, valeu in pairs(playerData) do
            print(key, value)
        end
        print("All accounts have been saved !")
    end, 1000)
end
AddEvent("OnPackageStop", OnPackageStop)

---- check player account
function OnPlayerSteamAuth(player)
    local steam_id = tostring(GetPlayerSteamId(player))
    
    if(steam_id == 0)then
        KickPlayer(player, "🚨 You are not connected steam 🚨")
    end

	local query = mariadb_prepare(db, Request.IfplayerAccountExist,
        steam_id)

    mariadb_async_query(db, query, OnAccountConnect, player)
end
AddEvent("OnPlayerSteamAuth", OnPlayerSteamAuth)

---- manage player account
function OnAccountConnect(player)
    if(mariadb_get_row_count() == 0)then
        CreatePlayerAccount(player)
    else
        LoadPlayerAccount(player)
    end
end

-- new account
function CreatePlayerAccount(player)
    local steam_id = tostring(GetPlayerSteamId(player))
    local player_name = GetPlayerName(player)

    local new_player_cash = 0

    print("[SERVER] create new account steam_id : " ..steam_id)
    local query = mariadb_prepare(db, Request.CreatePlayerAccount,
        0,
        steam_id,
        100,
        player_name,
        new_player_cash
    )

    mariadb_query(db, query)
    local id = mariadb_get_insert_id()


    SetPlayerName(player, player_name)


    createPlayerAcoount(id, 0, steam_id, 100, player_name, new_player_cash)

end

-- load account
function LoadPlayerAccount(player)
    local steam_id = tostring(GetPlayerSteamId(player))

    print("> Load player account ("..steam_id..")")


	local query = mariadb_prepare(db, Request.GetPlayerAccount,
        steam_id)

	mariadb_async_query(db, query, OnAccountLoaded, player)
end

function OnAccountLoaded(player)
    if (mariadb_get_row_count() == 0) then
		KickPlayer(player, "😨 An error occured while loading your account 😨")
    else
        local steam_id = tostring(GetPlayerSteamId(player))
        local player_name = GetPlayerName(player)
        local result = mariadb_get_assoc(1)
        

        if(result['name'] ~= player_name) then
            player_name = result['name']
        end

        SetPlayerName(player, player_name)
        SetPlayerHealth(player, tonumber(result['health']))

        createPlayerAcoount(result['id'], result['admin'], result['steam_id'], result['health'], player_name, result['cash'])

	end
end

---- Manage account list
--add
function createPlayerAcoount(id, admin, steamId, health, name, cash)
    local p = playerData.ClassPlayer.new(
        {
            ["id"] = id,
            ["admin"] = admin,
            ["steamId"] = steamId,
            ["health"] = health,
            ["name"] = name,
            ["cash"] =  cash
        })

    table.insert(playerData, p)       
end

--remove
function OnPlayerQuit(player)
    DestroyPlayerData(player)
end
AddEvent("OnPlayerQuit", OnPlayerQuit)

function DestroyPlayerData(player)
    local steam_id = tostring(GetPlayerSteamId(player))
    for key, valeu in pairs(playerData) do
        if(valeu.steamId == steam_id) then
            table.remove(playerData, key)
        end
    end
end

--sav
function SaveAccountPlayer(player)
    local steam_id = tostring(GetPlayerSteamId(player))
    local Data = {}
    for key, valeu in pairs(playerData) do
        if(valeu.steamId == steam_id) then
            Data = valeu
        end
    end

    local query = mariadb_prepare(db, Request.SaveAccount,
        Data.cash,
		Data.steamId
	)
        
	mariadb_query(db, query)
end

--utils
function getplayer(player)
    local steam_id = tostring(GetPlayerSteamId(player))
    for key, valeu in pairs(playerData) do
        if(valeu.steamId == steam_id) then
            return valeu
        end
    end
end
