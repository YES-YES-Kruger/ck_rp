local admin_ui
local admin_key = "F5"

function OpenUIAdmin()
    if admin_ui ~= nil then
        SetIgnoreLookInput(true)
        SetIgnoreMoveInput(true)
        ShowMouseCursor(true)
        SetInputMode(INPUT_GAMEANDUI)
        SetWebVisibility(admin_ui, WEB_VISIBLE)
        CloseUISurvival_warn()
    end
end

function CloseUIAdmin()
    SetIgnoreLookInput(false)
    SetIgnoreMoveInput(false)
    ShowMouseCursor(false)
    SetInputMode(INPUT_GAME)
    SetWebVisibility(admin_ui, WEB_HIDDEN)
    OpenUISurvival_warn()
end

function OnPackageStart()
    admin_ui = CreateWebUI(0, 0, 0, 0, 1, 60)
    LoadWebFile(admin_ui,'http://asset/' .. GetPackageName() .. '/admin/files/ui_admin.html')
    SetWebAlignment(admin_ui, 0.0, 0.0)
    SetWebAnchors(admin_ui, 0.0, 0.0, 1.0, 1.0)
    SetWebVisibility(admin_ui, WEB_HIDDEN)
end
AddEvent("OnPackageStart", OnPackageStart)

AddEvent("OnKeyPress", function(key)
    if key == admin_key then
        if GetWebVisibility(admin_ui) == WEB_HIDDEN then
            OpenUIAdmin()
        else
            CloseUIAdmin()
        end
    end
end)

function CallExecute(rslt)
    CallRemoteEvent("Exucute", rslt)
    CloseUIAdmin()
end
AddEvent("CallExecute", CallExecute)

function CallClose()
    CloseUIAdmin()
end
AddEvent("CallClose", CallClose)

