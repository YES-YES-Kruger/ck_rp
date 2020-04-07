local save_playerHeading

local save_curent_character

function create_charactere(player, json)
    local data = json_decode(json)

    local p = getplayer(player)

    local FullName = data.fn .. " " .. data.n

    p:setName(FullName)
    SetPlayerName(player, FullName)
    ChangeClothingPlayer(player, player, "gender", data.g)
    ChangeClothingPresetPlayer(player, player, data.g, tonumber(data.p))
    ChangeClothingPlayer(player, player, "hair", data.h)

    ChangeClothingColorPlayer(player, player, "hair", data.hc)
    ChangeClothingColorPlayer(player, player, "shirt", data.hs)
    ChangeClothingColorPlayer(player, player, "pants", data.hp)

    SetPlayerClothing(player)

    SaveAccountPlayer(player)

    AddPlayerChat(player, "saved stuff")
end
AddRemoteEvent("create_charactere", create_charactere)

function refrech_charactere(player, json)
    local data = json_decode(json)
    local p = getplayer(player)
    
    ChangeClothingPlayer(player, player, "gender", data.g)
    ChangeClothingPresetPlayer(player, player, data.g, tonumber(data.p))
    ChangeClothingPlayer(player, player, "hair", data.h)

    ChangeClothingColorPlayer(player, player, "hair", data.hc)
    ChangeClothingColorPlayer(player, player, "shirt", data.hs)
    ChangeClothingColorPlayer(player, player, "pants", data.hp)

    SetPlayerClothing(player)
end
AddRemoteEvent("refrech_charactere", refrech_charactere)

function saveCurrentCharacter(player)
    local p = getplayer(player)
    save_curent_character = p.clothing
end
AddRemoteEvent("saveCurrentCharacter", saveCurrentCharacter)

function setupCamUi(player)
    local x, y, z  = GetPlayerLocation(player)
    save_playerHeading = GetPlayerHeading(player)
    CallRemoteEvent(player, "removeSkeletalMesh", "body")
    
    SetPlayerHeading(player, 170)
    SetPlayerDimension(player, tonumber(player) + 1)
end
AddRemoteEvent("setupCamUi", setupCamUi)

function RemoveCamUi(player)
    SetPlayerDimension(player, 0)
    SetPlayerHeading(player, save_playerHeading)
end
AddRemoteEvent("RemoveCamUi", RemoveCamUi)

function ErrorClient(player, json)
    local data = json_decode(json)

    local alert = ""

    local formKey = {
        ["fn"] = "First name", 
        ["n"] = "Name", 
        ["a"] = "Age",
    }

    local formError = {
        ["nn"] = "must be a numeric value", 
        ["ath"] = "to hight", 
        ["ath"] = "to low", 
        ["empty"] = "must not be empty",
        ["ws"] = "must not contain spaces",
    }

    for k, v in pairs(data) do
        alert = string.format('%s <strong>%s</strong> : %s<br>', alert, formKey[v[1]], formError[v[2]])
    end

    SendAlert(player, "warning", "Error form", alert)
end
AddRemoteEvent("ErrorClient", ErrorClient)

