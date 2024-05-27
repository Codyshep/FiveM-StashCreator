stashes = {
    {
        id = 'stash1', items = { 
            {name = 'bread', quantity = 1}
        }
    },
    {
        id = 'stash2', items = { 
            {name = 'water', quantity = 4},
            {name = 'socks', quantity = 2}
        }
    }
}

createStash = function(id)
    local stashExists = false

    for _, data in ipairs(stashes) do
        if data.id == id then
            stashExists = true
            break
        end
    end

    if not stashExists then
        table.insert(stashes, {id = id, items = {}})
        print('Stash created with ID: '..id)
    else
        print('Failed to create stash, ID already exists: '..id)
    end
end

updateStashItems = function(stashid, item, quantity)
    for _, data in ipairs(stashes) do
        if data.id == stashid then
            local itemExists = false
            for _, existingItem in ipairs(data.items) do
                if existingItem.name == item then
                    existingItem.quantity = math.floor(existingItem.quantity + quantity)
                    itemExists = true
                    break
                end
            end
            if not itemExists then
                table.insert(data.items, {name = item, quantity = quantity})
            end
            print('Stash updated with ID: '..stashid)
            return
        end
    end
    print('Failed to update stash, ID does not exist: '..stashid)
end

printStashData = function()
    for _, data in ipairs(stashes) do
        print('Registered Stash: '..data.id)
        print('Items In Stash:')
        for _, item in ipairs(data.items) do
            print('- Name: '..item.name..', Quantity: '..item.quantity)
        end
    end
end

-- createStash('stash3') | Creating a new stash
-- updateStashItems('stash3', 'apple', 3) | Adding Items To Stash & or updating stash items

RegisterCommand('stashAddItem', function(source, args)
    updateStashItems(args[1], args[2], args[3])
end)

RegisterCommand('stashView', function(source, args)
     printStashData()
end)

RegisterCommand('stashCreate', function(source, args)
    if #args[1] < 10 then
        createStash(tostring(args[1]))
    else
        print('cant be more than 10 characters')
    end
end)
