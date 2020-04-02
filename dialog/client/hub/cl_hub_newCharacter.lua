local new_character

-- manage ui
function OpenUINewCharacter()
    if new_character ~= nil then
        ShowMouseHub(true)
        LockPlayerInput(true)
        SetWebVisibility(new_character, WEB_VISIBLE)
        CloseUISurvival_warn()

        setupCamUi(GetPlayerId())
    end

end

function CloseUINewCharacter()
    ShowMouseHub(false)
    LockPlayerInput(false)
    SetWebVisibility(new_character, WEB_HIDDEN)

    OpenUISurvival_warn()

    RemoveCamUi(GetPlayerId())
end

-- package manager
function OnPlayerSpawn()
    new_character = CreateWebUI(0, 0, 0, 0, 1, 60)
    LoadWebFile(new_character,'http://asset/' .. GetPackageName() .. '/dialog/files/ui_new_character.html')
    SetWebAlignment(new_character, 0.0, 0.0)
    SetWebAnchors(new_character, 0.0, 0.0, 1.0, 1.0)
    SetWebVisibility(new_character, WEB_HIDDEN)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)

-- key mapping
AddEvent("OnKeyPress", function(key)
    if key == GetKeyMapServer("char") then
        if GetWebVisibility(new_character) == WEB_HIDDEN then
            OpenUINewCharacter()
        else
            CloseUINewCharacter()

        end
    end
end)

function setupCamUi(player)
    local x, y, z  = GetPlayerLocation(player)
    CallRemoteEvent("setupCamUi")
    SetCameraLocation(x -250, y, z +10 ,true)
    SetCameraRotation(0,0,0,true)
end

function RemoveCamUi(player)
    CallRemoteEvent("RemoveCamUi")
    SetCameraLocation(0, 0, 0, false)
    SetCameraRotation(0, 0, 0, false)
end

-- call ui
function CallInfoValid(info_json)
    AddPlayerChat(info_json)
    CallRemoteEvent("create_charactere", info_json)
    CloseUINewCharacter()
end
AddEvent("CallInfoValid", CallInfoValid)

function CallInfoError(error_json)
    AddPlayerChat("erro_json")
    AddPlayerChat(error_json)
    CloseUINewCharacter()
end
AddEvent("CallInfoError", CallInfoError)