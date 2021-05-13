ESX = nil

local PlayerData = {}
    
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- prevent crashing

        -- These natives have to be called every frame.
        SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
        SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
        SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
        SetRandomBoats(false) -- Stop random boats from spawning in the water.
        SetCreateRandomCops(false) -- disable random cops walking/driving around.
        SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
        SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
        
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
        RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then

            if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1),false),-1) == GetPlayerPed(-1) then
                SetVehicleDensityMultiplierThisFrame(0)
                SetParkedVehicleDensityMultiplierThisFrame(0.0)
            else
                SetVehicleDensityMultiplierThisFrame(0.0)
                SetParkedVehicleDensityMultiplierThisFrame(0)
            end
        else
          SetParkedVehicleDensityMultiplierThisFrame(0.0)
          SetVehicleDensityMultiplierThisFrame(0)
        end
    end
end)


RegisterNetEvent("RedMenu:Notification")
AddEventHandler("RedMenu:Notification", function(message)
    ESX.ShowNotification("~h~Boutique : " .. message)
end)

RegisterNetEvent('::{korioz#0110}::esx:playerLoaded')
AddEventHandler('::{korioz#0110}::esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)
        ESX.TriggerServerCallback('RedMenu:GetPoint', function(thepoint)
            point = thepoint
        end)

        ESX.TriggerServerCallback('RedMenu:GetCodeBoutique', function(thecode)
            code = thecode
        end)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        ESX.TriggerServerCallback('RedMenu:GetPoint', function(thepoint)
            point = thepoint
        end)

        ESX.TriggerServerCallback('RedMenu:GetCodeBoutique', function(thecode)
            code = thecode
        end)
    end    
end)

TableWeapon = {
    ["WEAPON_DAGGER"] = GetHashKey("WEAPON_DAGGER"),
    ["WEAPON_BAT"] = GetHashKey("WEAPON_BAT"),
    ["WEAPON_BOTTLE"] = GetHashKey("WEAPON_BOTTLE"),
    ["WEAPON_CROWBAR"] = GetHashKey("WEAPON_CROWBAR"),
    ["WEAPON_UNARMED"] = GetHashKey("WEAPON_UNARMED"),
    ["WEAPON_FLASHLIGHT"] = GetHashKey("WEAPON_FLASHLIGHT"),
    ["WEAPON_GOLFCLUB"] = GetHashKey("WEAPON_GOLFCLUB"),
    ["WEAPON_HAMMER"] = GetHashKey("WEAPON_HAMMER"),
    ["WEAPON_HATCHET"] = GetHashKey("WEAPON_HATCHET"),
    ["WEAPON_KNUCKLE"] = GetHashKey("WEAPON_KNUCKLE"),
    ["WEAPON_KNIFE"] = GetHashKey("WEAPON_KNIFE"),
    ["WEAPON_MACHETE"] = GetHashKey("WEAPON_MACHETE"),
    ["WEAPON_SWITCHBLADE"] = GetHashKey("WEAPON_SWITCHBLADE"),
    ["WEAPON_NIGHTSTICK"] = GetHashKey("WEAPON_NIGHTSTICK"),
    ["WEAPON_WRENCH"] = GetHashKey("WEAPON_WRENCH"),
    ["WEAPON_BATTLEAXE"] = GetHashKey("WEAPON_BATTLEAXE"),
    ["WEAPON_POOLCUE"] = GetHashKey("WEAPON_POOLCUE"),
    ["WEAPON_STONE_HATCHET"] = GetHashKey("WEAPON_STONE_HATCHET"),
    ["WEAPON_PISTOL"] = GetHashKey("WEAPON_PISTOL"),
    ["WEAPON_PISTOL_MK2"] = GetHashKey("WEAPON_PISTOL_MK2"),
    ["WEAPON_COMBATPISTOL"] = GetHashKey("WEAPON_COMBATPISTOL"),
    ["WEAPON_APPISTOL"] = GetHashKey("WEAPON_APPISTOL"),
    ["WEAPON_STUNGUN"] = GetHashKey("WEAPON_STUNGUN"),
    ["WEAPON_PISTOL50"] = GetHashKey("WEAPON_PISTOL50"),
    ["WEAPON_SNSPISTOL"] = GetHashKey("WEAPON_SNSPISTOL"),
    ["WEAPON_SNSPISTOL_MK2"] = GetHashKey("WEAPON_SNSPISTOL_MK2"),
    ["WEAPON_HEAVYPISTOL"] = GetHashKey("WEAPON_HEAVYPISTOL"),
    ["WEAPON_VINTAGEPISTOL"] = GetHashKey("WEAPON_VINTAGEPISTOL"),
    ["WEAPON_FLAREGUN"] = GetHashKey("WEAPON_FLAREGUN"),
    ["WEAPON_MARKSMANPISTOL"] = GetHashKey("WEAPON_MARKSMANPISTOL"),
    ["WEAPON_REVOLVER"] = GetHashKey("WEAPON_REVOLVER"),
    ["WEAPON_REVOLVER_MK2"] = GetHashKey("WEAPON_REVOLVER_MK2"),
    ["WEAPON_DOUBLEACTION"] = GetHashKey("WEAPON_DOUBLEACTION"),
    ["WEAPON_RAYPISTOL"] = GetHashKey("WEAPON_RAYPISTOL"),
    ["WEAPON_CERAMICPISTOL"] = GetHashKey("WEAPON_CERAMICPISTOL"),
    ["WEAPON_NAVYREVOLVER"] = GetHashKey("WEAPON_NAVYREVOLVER"),
    ["WEAPON_MICROSMG"] = GetHashKey("WEAPON_MICROSMG"),
    ["WEAPON_SMG"] = GetHashKey("WEAPON_SMG"),
    ["WEAPON_SMG_MK2"] = GetHashKey("WEAPON_SMG_MK2"),
    ["WEAPON_ASSAULTSMG"] = GetHashKey("WEAPON_ASSAULTSMG"),
    ["WEAPON_COMBATPDW"] = GetHashKey("WEAPON_COMBATPDW"),
    ["WEAPON_MACHINEPISTOL"] = GetHashKey("WEAPON_MACHINEPISTOL"),
    ["WEAPON_MINISMG"] = GetHashKey("WEAPON_MINISMG"),
    ["WEAPON_RAYCARBINE"] = GetHashKey("WEAPON_RAYCARBINE"),
    ["WEAPON_PUMPSHOTGUN"] = GetHashKey("WEAPON_PUMPSHOTGUN"),
    ["WEAPON_PUMPSHOTGUN_MK2"] = GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),
    ["WEAPON_SAWNOFFSHOTGUN"] = GetHashKey("WEAPON_SAWNOFFSHOTGUN"),
    ["WEAPON_ASSAULTSHOTGUN"] = GetHashKey("WEAPON_ASSAULTSHOTGUN"),
    ["WEAPON_BULLPUPSHOTGUN"] = GetHashKey("WEAPON_BULLPUPSHOTGUN"),
    ["WEAPON_MUSKET"] = GetHashKey("WEAPON_MUSKET"),
    ["WEAPON_HEAVYSHOTGUN"] = GetHashKey("WEAPON_HEAVYSHOTGUN"),
    ["WEAPON_DBSHOTGUN"] = GetHashKey("WEAPON_DBSHOTGUN"),
    ["WEAPON_AUTOSHOTGUN"] = GetHashKey("WEAPON_AUTOSHOTGUN"),
    ["WEAPON_ASSAULTRIFLE"] = GetHashKey("WEAPON_ASSAULTRIFLE"),
    ["WEAPON_ASSAULTRIFLE_MK2"] = GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),
    ["WEAPON_CARBINERIFLE"] = GetHashKey("WEAPON_CARBINERIFLE"),
    ["WEAPON_CARBINERIFLE_MK2"] = GetHashKey("WEAPON_CARBINERIFLE_MK2"),
    ["WEAPON_ADVANCEDRIFLE"] = GetHashKey("WEAPON_ADVANCEDRIFLE"),
    ["WEAPON_SPECIALCARBINE"] = GetHashKey("WEAPON_SPECIALCARBINE"),
    ["WEAPON_SPECIALCARBINE_MK2"] = GetHashKey("WEAPON_SPECIALCARBINE_MK2"),
    ["WEAPON_BULLPUPRIFLE"] = GetHashKey("WEAPON_BULLPUPRIFLE"),
    ["WEAPON_BULLPUPRIFLE_MK2"] = GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),
    ["WEAPON_COMPACTRIFLE"] = GetHashKey("WEAPON_COMPACTRIFLE"),
    ["WEAPON_MG"] = GetHashKey("WEAPON_MG"),
    ["WEAPON_COMBATMG"] = GetHashKey("WEAPON_COMBATMG"),
    ["WEAPON_COMBATMG_MK2"] = GetHashKey("WEAPON_COMBATMG_MK2"),
    ["WEAPON_GUSENBERG"] = GetHashKey("WEAPON_GUSENBERG"),
    ["WEAPON_SNIPERRIFLE"] = GetHashKey("WEAPON_SNIPERRIFLE"),
    ["WEAPON_HEAVYSNIPER"] = GetHashKey("WEAPON_HEAVYSNIPER"),
    ["WEAPON_HEAVYSNIPER_MK2"] = GetHashKey("WEAPON_HEAVYSNIPER_MK2"),
    ["WEAPON_MARKSMANRIFLE"] = GetHashKey("WEAPON_MARKSMANRIFLE"),
    ["WEAPON_MARKSMANRIFLE_MK2"] = GetHashKey("WEAPON_MARKSMANRIFLE_MK2"),
    ["WEAPON_RPG"] = GetHashKey("WEAPON_RPG"),
    ["WEAPON_GRENADELAUNCHER"] = GetHashKey("WEAPON_GRENADELAUNCHER"),
    ["WEAPON_GRENADELAUNCHER_SMOKE"] = GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE"),
    ["WEAPON_MINIGUN"] = GetHashKey("WEAPON_MINIGUN"),
    ["WEAPON_FIREWORK"] = GetHashKey("WEAPON_FIREWORK"),
    ["WEAPON_RAILGUN"] = GetHashKey("WEAPON_RAILGUN"),
    ["WEAPON_HOMINGLAUNCHER"] = GetHashKey("WEAPON_HOMINGLAUNCHER"),
    ["WEAPON_COMPACTLAUNCHER"] = GetHashKey("WEAPON_COMPACTLAUNCHER"),
    ["WEAPON_RAYMINIGUN"] = GetHashKey("WEAPON_RAYMINIGUN"),
    ["WEAPON_GRENADE"] = GetHashKey("WEAPON_GRENADE"),
    ["WEAPON_BZGAS"] = GetHashKey("WEAPON_BZGAS"),
    ["WEAPON_MOLOTOV"] = GetHashKey("WEAPON_MOLOTOV"),
    ["WEAPON_STICKYBOMB"] = GetHashKey("WEAPON_STICKYBOMB"),
    ["WEAPON_PROXMINE"] = GetHashKey("WEAPON_PROXMINE"),
    ["WEAPON_SNOWBALL"] = GetHashKey("WEAPON_SNOWBALL"),
    ["WEAPON_PIPEBOMB"] = GetHashKey("WEAPON_PIPEBOMB"),
    ["WEAPON_BALL"] = GetHashKey("WEAPON_BALL"),
    ["WEAPON_SMOKEGRENADE"] = GetHashKey("WEAPON_SMOKEGRENADE"),
    ["WEAPON_FLARE"] = GetHashKey("WEAPON_FLARE"),
    ["WEAPON_PETROLCAN"] = GetHashKey("WEAPON_PETROLCAN"),
    ["GADGET_PARACHUTE"] = GetHashKey("GADGET_PARACHUTE"),
    ["WEAPON_FIREEXTINGUISHER"] = GetHashKey("WEAPON_FIREEXTINGUISHER"),
    ["WEAPON_HAZARDCAN"] = GetHashKey("WEAPON_HAZARDCAN")
    }

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        PlayerData = ESX.GetPlayerData()
        local found = false

        local weaponName = GetSelectedPedWeapon(GetPlayerPed(PlayerId()))

        TheWeapon = nil

        for key, value in pairs(TableWeapon) do
            if value == weaponName then
                TheWeapon = key
            end
        end
        
      --  print(TheWeapon)

        for i = 1, #PlayerData.loadout, 1 do
            if PlayerData.loadout[i].name == TheWeapon then
                found = true
                break    
            end
        end

        if found then 
            -- do nothing
        else
            if TheWeapon == nil then
                print("Player detected avec l'arme : " .. "Check Failed Weapon not in list")
                RemoveWeaponFromPed(GetPlayerPed(PlayerId()), weaponName)
            else
                if TheWeapon == "WEAPON_UNARMED" then
                    --JUST MELE BASIC DO NOTHING
                else
                    print("Player detected avec l'arme : " .. TheWeapon)
                    RemoveWeaponFromPed(GetPlayerPed(PlayerId()), GetHashKey(TheWeapon))
                    Citizen.Wait(2000)
                    TriggerServerEvent("RedMenu:ArmeProtection", TheWeapon)
                end
            end
        end
    end
end)

function GetActuallyParticul(assetName)
    RequestNamedPtfxAsset(assetName)
    if not (HasNamedPtfxAssetLoaded(assetName)) then
        while not HasNamedPtfxAssetLoaded(assetName) do
            Citizen.Wait(1.0)
        end
        return assetName;
    else
        return assetName;
    end
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

RMenu.Add('MenuRoy', 'home', RageUI.CreateMenu("RoyRP", "~b~RoyBoutique"))
RMenu:Get("MenuRoy", "home").Closed = function()end
RMenu:Get('MenuRoy', 'home'):SetRectangleBanner(66, 0, 0, 255)

RMenu.Add('MenuRoy', 'info', RageUI.CreateSubMenu(RMenu:Get('MenuRoy', 'home'), Config.MenuName, "Informations RoyRP"))
RMenu:Get("MenuRoy", "info").Closed = function()end

RMenu.Add('MenuRoy', 'boutique', RageUI.CreateSubMenu(RMenu:Get('MenuRoy', 'home'), Config.MenuName, "Boutique RoyRP"))
RMenu:Get("MenuRoy", "boutique").Closed = function()end

RMenu.Add('MenuRoy', 'menuarme', RageUI.CreateSubMenu(RMenu:Get('MenuRoy', 'boutique'), Config.MenuName, "Armes RoyRP"))
RMenu:Get("MenuRoy", "menuarme").Closed = function()end

RMenu.Add('MenuRoy', 'menuvehicule', RageUI.CreateSubMenu(RMenu:Get('MenuRoy', 'boutique'), Config.MenuName, "Véhicules RoyRP"))
RMenu:Get("MenuRoy", "menuvehicule").Closed = function()end

RMenu.Add('MenuRoy', 'menuother', RageUI.CreateSubMenu(RMenu:Get('MenuRoy', 'boutique'), Config.MenuName, "Autres choses sur RoyRP"))
RMenu:Get("MenuRoy", "menuother").Closed = function()end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
        RageUI.IsVisible(RMenu:Get('MenuRoy', 'home'), true, true, true, function()

            RageUI.ButtonWithStyle("Boutique", nil, {}, true,function(h,a,s)
                if s then
                end
            end, RMenu:Get("MenuRoy","boutique"))         

            RageUI.ButtonWithStyle("Information", nil, {}, true,function(h,a,s)
                if s then
                end
            end,RMenu:Get("MenuRoy","info"))            
            
        end)

        RageUI.IsVisible(RMenu:Get("MenuRoy","info"),true,true,true,function()
            RenderInfoMenu()
        end, function()end, 1)

        RageUI.IsVisible(RMenu:Get("MenuRoy","boutique"),true,true,true,function()
            RenderBoutiqueMenu()
        end, function()end, 1)

        RageUI.IsVisible(RMenu:Get("MenuRoy","menuarme"),true,true,true,function()
            RenderArmeMenu()
        end, function()end, 1)

        RageUI.IsVisible(RMenu:Get("MenuRoy","menuvehicule"),true,true,true,function()
            RenderVehiculeMenu()
        end, function()end, 1)
        
        RageUI.IsVisible(RMenu:Get("MenuRoy","menuother"),true,true,true,function()
            RenderUtilsMenu()
        end, function()end, 1)


    end
end)

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1.0)
        if IsControlJustPressed(1,288) then
            RageUI.Visible(RMenu:Get('MenuRoy', 'home'), not RageUI.Visible(RMenu:Get('MenuRoy', 'home'))) 
        end
    end
end)

function RenderInfoMenu()
    RageUI.Separator("Discord~s~ : discord.gg/SAwn8ybHBk")
    RageUI.Separator("Développeur : !EK#9999")
    RageUI.Separator("Ton ID : " ..GetPlayerServerId(PlayerId()))
end

function RenderBoutiqueMenu()
    RageUI.Separator("~h~RoyCoins : ~r~" .. point)
    RageUI.Separator("~h~ID Boutique : ~r~" .. code)
    RageUI.ButtonWithStyle("Armes", nil, {}, true,function(h,a,s)
        if s then
        end
    end, RMenu:Get("MenuRoy","menuarme"))
    RageUI.ButtonWithStyle("Véhicules", nil, {}, true,function(h,a,s)
        if s then
        end
    end, RMenu:Get("MenuRoy","menuvehicule"))
    RageUI.ButtonWithStyle("Autres", nil, {}, true,function(h,a,s)
        if s then
        end
    end, RMenu:Get("MenuRoy","menuother"))

end

function RenderArmeMenu()
    RageUI.ButtonWithStyle("~h~AK-47", nil, { RightLabel = "2000 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("assault-rifle-mk2")
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "ak47")
        end
    end)

    RageUI.ButtonWithStyle("~h~Pistolet Calibre 50", nil, { RightLabel = "500 RoyCoins" }, true,function(h,a,s)
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "cal50")
        end
    end)

    RageUI.ButtonWithStyle("~h~Micro SMG", nil, { RightLabel = "1100 RoyCoins" }, true,function(h,a,s)
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "microsmg")
        end
    end)



    RageUI.ButtonWithStyle("~h~Fusil De Précision Lourd", nil, { RightLabel = "2100 RoyCoins" }, true,function(h,a,s)
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "sniper")
        end
    end)
    RageUI.ButtonWithStyle("", nil, {}, true,function(h,a,s)
    end)
    RageUI.ButtonWithStyle("", nil, {}, true,function(h,a,s)
    end)
    RageUI.ButtonWithStyle("", nil, {}, true,function(h,a,s)
    end)
    RageUI.ButtonWithStyle("", nil, {}, true,function(h,a,s)
    end)
    RageUI.ButtonWithStyle("", nil, {}, true,function(h,a,s)
    end)
end

function RenderUtilsMenu()
    RageUI.Separator("~h~RoyCoins : ~r~" .. point)
    RageUI.Separator("~h~Code boutique : ~b~" .. code)
    RageUI.ButtonWithStyle("~h~Réanimation", nil, { RightLabel = "300 RoyCoins" }, true,function(h,a,s)
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "revive")
        end
    end)

    RageUI.ButtonWithStyle("~h~Creation de gangs", nil, { RightLabel = "3000 RoyCoins" }, true,function(h,a,s)
        if s then
            local nomdiscord = KeyboardInput('REDMENU_NOM_DISCORD', "Merci d'entrer votre nom Discord (ex : MasterLua#9999)", '', 1000)
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !\nUn administrateur va vous contacter sur Discord pour votre Gang !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "gang", nomdiscord)

        end
    end)

end

local NumberCharset = {}
local Charset = {}

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
    local generatedPlate
    local doBreak = false

    while true do
        Citizen.Wait(2)
        math.randomseed(GetGameTimer())
        generatedPlate = string.upper(GetRandomLetter(4) .. GetRandomNumber(4))

        ESX.TriggerServerCallback('::{korioz#0110}::esx_vehicleshop:isPlateTaken', function (isPlateTaken)
            if not isPlateTaken then
                doBreak = true
            end
        end, generatedPlate)

        if doBreak then
            break
        end
    end

    return generatedPlate
end


function IsPlateTaken(plate)
    local callback = 'waiting'

    ESX.TriggerServerCallback('::{korioz#0110}::esx_vehicleshop:isPlateTaken', function(isPlateTaken)
        callback = isPlateTaken
    end, plate)

    while type(callback) == 'string' do
        Citizen.Wait(0)
    end

    return callback
end

function GetRandomNumber(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())

    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ''
    end
end

function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())

    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end

function getVehicleType(model)
    return 'car'
end

function RenderVehiculeMenu()
    RageUI.Separator("~h~RoyCoins : ~r~" .. point)
    RageUI.Separator("~h~Code boutique : ~b~" .. code)
    RageUI.ButtonWithStyle("~h~Lumma G770", nil, { RightLabel = "2200 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("G770")
        end

        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback then
                local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                ESX.Game.SpawnVehicle("g770", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                    local newPlate = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                end)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                GetActuallyParticul('scr_rcbarry2')
                SetPtfxAssetNextCall('scr_rcbarry2')
                StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end

            end, "lumma")
        end
    end)

    RageUI.ButtonWithStyle("~h~Audi RS6 2020", nil, { RightLabel = "3100 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("RS6")
        end

        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback then
                local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                ESX.Game.SpawnVehicle("rs6black", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                    local newPlate = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                end)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                GetActuallyParticul('scr_rcbarry2')
                SetPtfxAssetNextCall('scr_rcbarry2')
                StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end

            end, "rs6")
        end
    end)

    RageUI.ButtonWithStyle("~h~Audi RS7 2020", nil, { RightLabel = "3100 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("RS7")
        end

        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback then
                local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                ESX.Game.SpawnVehicle("rs7r", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                    local newPlate = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                end)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                GetActuallyParticul('scr_rcbarry2')
                SetPtfxAssetNextCall('scr_rcbarry2')
                StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end

            end, "rs7")
        end
    end)

    RageUI.ButtonWithStyle("~h~Mercedes C63 AMG", nil, { RightLabel = "2200 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("C63")
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback then
                local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                ESX.Game.SpawnVehicle("c63", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                    local newPlate = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                end)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                GetActuallyParticul('scr_rcbarry2')
                SetPtfxAssetNextCall('scr_rcbarry2')
                StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end

            end, "c63")
        end
    end)

    RageUI.ButtonWithStyle("~h~BMW M5", nil, { RightLabel = "2200 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("BMW")
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback then
                local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                ESX.Game.SpawnVehicle("bmci", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                    local newPlate = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                end)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                GetActuallyParticul('scr_rcbarry2')
                SetPtfxAssetNextCall('scr_rcbarry2')
                StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end

            end, "m5")
        end
    end)

    RageUI.ButtonWithStyle("~h~Lamborghini Urus 2018", nil, { RightLabel = "2200 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("URUS")
        end

        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback then
                local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                ESX.Game.SpawnVehicle("urus2018", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                    local newPlate = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                end)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                GetActuallyParticul('scr_rcbarry2')
                SetPtfxAssetNextCall('scr_rcbarry2')
                StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end

            end, "urus")
        end
    end)

    RageUI.ButtonWithStyle("~h~Nissan GTR", nil, { RightLabel = "3100 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("GTR")
        end

        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback then
                local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                ESX.Game.SpawnVehicle("gtr", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                    local newPlate = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                end)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                GetActuallyParticul('scr_rcbarry2')
                SetPtfxAssetNextCall('scr_rcbarry2')
                StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end

            end, "gtr")
        end
    end)

    RageUI.ButtonWithStyle("~h~Mercedes A45", nil, { RightLabel = "1000 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("A45")
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback then
                local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                ESX.Game.SpawnVehicle("macla", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                    local newPlate = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                end)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                GetActuallyParticul('scr_rcbarry2')
                SetPtfxAssetNextCall('scr_rcbarry2')
                StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end

            end, "a45")
        end
    end)

    RageUI.ButtonWithStyle("~h~Lamborghini Terzo TZR", nil, { RightLabel = "4300 RoyCoins" }, true,function(h,a,s)
        if a then
            RageUI.VehiclePreview("TERZO")
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback then
                local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                ESX.Game.SpawnVehicle("terzo", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                    local newPlate = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                end)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                GetActuallyParticul('scr_rcbarry2')
                SetPtfxAssetNextCall('scr_rcbarry2')
                StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                ESX.ShowNotification("~h~Merci pour votre achat dans la boutique RoyRP !")
                else
                    ESX.ShowNotification("~h~Vous n'avez pas assez de fond pour acheter ceci !")
                end

            end, "tzr")
        end
    end)
end