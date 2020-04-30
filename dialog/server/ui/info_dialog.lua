local dialog = {
    id = "info",
    key = "I",
    type = "release",
    dysplay_on_spawn = false,
    view = "ui_info.html"
}

function dialog:GetId()
    return dialog.id
end

function dialog:GetKey()
    return dialog.key
end

function dialog:GetDysplayOnSpawn()
    return dialog.dysplay_on_spawn
end

function dialog:GetView()
    return dialog.view
end

function dialog:GetType()
    return dialog.type
end

function dialog:onCreate(playerId, DialogId)
end

function dialog:onOpen(playerId, DialogId)
end

function dialog:OnClose(playerId, DialogId)
end

function dialog:OnLoadComplete(playerId, DialogId)
    ExecWebJs(playerId, DialogId, "addKey('inventory', '".._Key_ui['survival'].."')")
    ExecWebJs(playerId, DialogId, "addKey('interaction', '".._Key_ui['interact'].."')")
end

AddDialog(dialog)