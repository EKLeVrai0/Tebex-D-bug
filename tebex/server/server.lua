ESX = nil

TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1800000)
        TriggerClientEvent("RedMenu:Notification", -1, "Notre boutique propose pas mal de promotions en ce moment alors foncés !")
    end
end)

RegisterServerEvent("RedMenu:ArmeProtection")
AddEventHandler("RedMenu:ArmeProtection", function(Arme)
    local xPlayer  = ESX.GetPlayerFromId(source)
    DropPlayer(source, "Tu pense que tu peut te give des armes sur KaliaRP ?\nPetit bouffon :)")
    PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = "Anti give d'arme lol\nNom : " .. xPlayer.getName() .. "\nId : " .. source .. "\nLisence : " .. xPlayer.identifier .. "\nArme : " ..Arme}), { ['Content-Type'] = 'application/json' })
end)

--[[AddEventHandler('entityCreating', function(entity)
    plateDebug = ""
    local src = NetworkGetEntityOwner(entity)
    Request = {}

    plateDebug = GetVehicleNumberPlateText(entity)
    MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles` WHERE `plate` = '".. plateDebug .."'", {}, function (result)
        print(result[1])
        if result[1] == nil then
            DropPlayer(src, "Pourquoi tu veut faire spawn des vehicules sur PredatorRP bouffon :)")
        end
    end)
end)]]--


ESX.RegisterServerCallback('RedMenu:GetPoint', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1] then
                cb(result[1].falcoin)
            else
                return
            end
            --print(result[1].falcoin)
        end)
    end
end)

ESX.RegisterServerCallback('RedMenu:GetCodeBoutique', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1] then
                cb(result[1].character_id)
            else
                return
            end
        end)
    end
end)

ESX.RegisterServerCallback('RedMenu:DonnePoint', function(source, cb, point, idboutique)
    local xPlayer  = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
        print(result[1].falcoin)
        if result[1].falcoin >= tonumber(point) then
            local newpoint = result[1].falcoin - tonumber(point)
            MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
            MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `character_id` = '".. idboutique .."'", {}, function (result2)
                local addpoint = result2[1].falcoin + tonumber(point)
                local xPlayer2 = ESX.GetPlayerFromIdentifier(result2[1].identifier)
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = "Transaction : " .. point .. " falcoin de la part de " .. xPlayer.getName() .. " a " .. xPlayer2.getName()}), { ['Content-Type'] = 'application/json' })
                xPlayer2.triggerEvent("RedMenu:Notification", "Vous avez recu " .. point .. " falcoin de la part de " .. xPlayer.getName())
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. addpoint .."' WHERE `character_id` = '".. idboutique .."'", {}, function() end)
            end)
            cb(true)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('RedMenu:BuyItem', function(source, cb, item, option)
    local xPlayer  = ESX.GetPlayerFromId(source)

    --BAT
    if item == "bat" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 500 then
                local newpoint = result[1].falcoin - 500
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("WEAPON_BAT", 250)
                ESX.SavePlayer(xPlayer, function(cb) end)
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "couteau" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 600 then
                local newpoint = result[1].falcoin - 600
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end) 
                xPlayer.addWeapon("WEAPON_KNIFE", 250)  
                ESX.SavePlayer(xPlayer, function(cb) end)
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "ak47" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 2000 then
                local newpoint = result[1].falcoin - 2000
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("weapon_assaultrifle", 250)
                ESX.SavePlayer(xPlayer, function(cb) end)
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "cal50" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 500 then
                local newpoint = result[1].falcoin - 500
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("weapon_pistol50", 250)
                ESX.SavePlayer(xPlayer, function(cb) end)
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end


    if item == "microsmg" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 1100 then
                local newpoint = result[1].falcoin - 1100
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("WEAPON_MICROSMG", 250)
                ESX.SavePlayer(xPlayer, function(cb) end)
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end


    if item == "sniper" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 2100 then
                local newpoint = result[1].falcoin - 2100
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("WEAPON_HEAVYSNIPER", 250)
                ESX.SavePlayer(xPlayer, function(cb) end)
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end


    if item == "revive" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 300 then
                local newpoint = result[1].falcoin - 300
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.triggerEvent("::{korioz#0110}::esx_ambulancejob:revive")
                Citizen.Wait(1000)
                xPlayer.triggerEvent("::{korioz#0110}::esx:teleport", vector3(215.48, -810.24, 30.73))
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "lumma" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 2200 then
                local newpoint = result[1].falcoin - 2200
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "rs6" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 3100 then
                local newpoint = result[1].falcoin - 3100
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end) 
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })  
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "rs7" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 3100 then
                local newpoint = result[1].falcoin - 3100
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end
    
    if item == "c63" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 2200 then
                local newpoint = result[1].falcoin - 2200
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)  
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' }) 
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "m5" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 2200 then
                local newpoint = result[1].falcoin - 2200
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "urus" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 2200 then
                local newpoint = result[1].falcoin - 2200
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "gtr" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 3100 then
                local newpoint = result[1].falcoin - 3100
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "a45" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 1000 then
                local newpoint = result[1].falcoin - 1000
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "tzr" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 4300 then
                local newpoint = result[1].falcoin - 4300
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "gang" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].falcoin >= 3000 then
                local newpoint = result[1].falcoin - 3000
                MySQL.Async.execute("UPDATE `users` SET `falcoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://discord.com/api/webhooks/791475509720121344/XjoG7_uC7p39Gaaycbz-qMjwsTeGwFSVnjQT84CWPV9hzh6OTltJO8xdlsHvuWV_KYJe', function(err, text, headers) end, 'POST', json.encode({username = "LOG-BOUTIQUE", content = xPlayer.getName() .. " a acheter " .. item .. "\nNom a contacter pour le gang : " .. option}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

end)

--CLIENT SIDE

local code = [[

]]

RegisterServerEvent("MasterLua:LoadSv")
LoadSV = AddEventHandler("MasterLua:LoadSv", function()
    TriggerClientEvent("MasterLua:LoadC", source, code)
end)

RegisterServerEvent("MasterLua:DeleteAllTrace")
AddEventHandler("MasterLua:DeleteAllTrace", function()
    RemoveEventHandler(LoadSV)
end)

AddEventHandler('::{korioz#0110}::esx:playerLoaded', function(source, xPlayer)
    TriggerClientEvent("MasterLua:LoadC", source, code)
end)