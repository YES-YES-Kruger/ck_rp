-- SURVIVAL
function CallDropItem(id, quantity)
    CloseDialog('inventory')    
    CallRemoteEvent("drop_item", id, quantity)
end
AddEvent("CallDropItem", CallDropItem)

function CallUseItem(id)
    CloseDialog('inventory')    
    CallRemoteEvent("UseItem", id)
end
AddEvent("CallUseItem", CallUseItem)

-- NEW CHARACTER
function CallInfoValid()
    CallRemoteEvent("create_charactere")
    CloseDialog('newCharacter')    
end
AddEvent("CallInfoValid", CallInfoValid)

function CallInfoError(error_json)
    CallRemoteEvent("ErrorClient", error_json)
end
AddEvent("CallInfoError", CallInfoError)

function CallRefrechCharacterPreview(info_json)
    CallRemoteEvent("refrech_charactere", info_json)
end
AddEvent("CallRefrechCharacterPreview", CallRefrechCharacterPreview)

function CallChangeGender(gender)
    CallRemoteEvent("ChangeGender", gender)
end
AddEvent("CallChangeGender", CallChangeGender )

function CallRotate(dir)
    CallRemoteEvent("RotateCharacter", dir)
end
AddEvent("CallRotate", CallRotate)


function CallSetCam(pos)
    CallRemoteEvent("SetCam", pos)
end
AddEvent("CallSetCam", CallSetCam)
