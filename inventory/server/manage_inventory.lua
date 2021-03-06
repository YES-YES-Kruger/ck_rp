function AddPlayerItem(player, target, item_id, quantity)
    if(CheckIfValidItem(item_id) or isnil(target) or isnil(quantity)) then
        local decode_inventory = GetInventory(target)
        local new_currentWeight = math.floor(CalculateInvWeight(target) + GetInventoryItemWeight(item_id, quantity))

        if(GetInventoryMaxWeight(target) < new_currentWeight) then
            local toHight = -1 * (GetInventoryMaxWeight(target) - new_currentWeight)
            return toHight
        end

        local cur_quantity = GetItemsQuantity(decode_inventory, item_id)

        if(cur_quantity ~= false) then
            quantity = quantity + cur_quantity
        end

        local new_item = {}
        new_item['id'] = item_id
        new_item['quantity'] = quantity

        table.insert(decode_inventory, new_item) 

        SaveInventory(target, decode_inventory, new_currentWeight)

        return true
    else
        print('invalid item or params')
    end
end

function RemovePlayerItem(player, target, item_id, quantity)
    if(CheckIfValidItem(item_id) or isnil(target) or isnil(quantity)) then
        local decode_inventory = GetInventory(target)
        local cur_quantity = GetItemsQuantity(decode_inventory, item_id)
        local new_currentWeight = math.floor(CalculateInvWeight(target) - GetInventoryItemWeight(item_id, quantity))

        if(cur_quantity == 0 or tonumber(cur_quantity) < tonumber(quantity)) then
            return false
        else
            quantity =  tonumber(cur_quantity) - tonumber(quantity)
        end

        for i, v in pairs(decode_inventory) do
            local cur_id = v['id']
            local cur_quantity = v['quantity']
    
            if(cur_id == item_id) then
                if (tonumber(quantity) == 0) then
                    table.remove (decode_inventory, i)
                else
                    v['quantity'] = quantity
                end
            end
        end

        SaveInventory(target, decode_inventory, new_currentWeight)

        return true
    else
        print('invalid item or params')
    end
end