local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-carboost:client:getcopsd")
AddEventHandler("md-carboost:client:getcopsd", function() 
TriggerServerEvent('md-carboost:server:getcopsd')
end)

RegisterNetEvent("md-carboost:client:ClassD")
AddEventHandler("md-carboost:client:ClassD", function() 

	local coords = Config.ClassD[math.random(#Config.ClassD)]
	local ModelHash = Config.ClassDVehicles[math.random(#Config.ClassDVehicles)] 
	local zonemath = math.random(1,100)
	local zonemath2 = math.random(1,100)
	local policechance1 = math.random(1,100)
	local policechance2 = math.random(1,100)
	-------- how the car is spawned
	 lib.requestModel(ModelHash)
	local carboostd = CreateVehicle(ModelHash,coords.x, coords.y, coords.z-1, coords.h, true, false)
    SetEntityHeading(carboostd, coords.w)
	SetEntityAsMissionEntity(carboostd, true, true)
    exports[Config.fuel]:SetFuel(carboostd, 100.0)
	------- Blip For Radius
	local classdboost = AddBlipForRadius(coords, 200.0) -- need to have .0
	SetBlipColour(classdboost, 1)
	SetBlipAlpha(classdboost, 128)
	EndTextCommandSetBlipName(classdboost)
	---- Runs a random to see if it alerts police at the coord where the car is
	if policechance1 <= 20 then
		local dispatchData = { message = "Car Boost", codeName = 'carboosting', code = '10-50', icon = 'fas fa-car', priority = 2, coords = coords,  vehicle = ModelHash, plate = ModelHash.plate, color = ModelHash.color, class = ModelHash.class, doors = ModelHash.doors, jobs = { 'leo', "police" } }
		TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
    end	
    ------- sends email of car and plate doesnt need interactions
	 TriggerServerEvent('qb-phone:server:sendNewMail', {
               sender = "Car Boost",
               subject = "Get This For Me",
               message = "You Are Looking for A " .. ModelHash.. " Hurry Up And Find It In The Zone",
               button = {}
           })
	----- spawns zone
	 zonemath = lib.zones.sphere({
    coords = coords,
    radius = 4,
    debug = false,
    inside = function()		
			 end,
    onEnter = function()
				 RemoveBlip(classdboost)
			end,
    onExit = function()
        zonemath:remove()
		local location = Config.Dropoff[math.random(#Config.Dropoff)]
		local blip = AddBlipForCoord(location)
			SetBlipSprite(blip, 1)
			SetBlipDisplay(blip, 2)
			SetBlipScale(blip, 1.0)
			SetBlipAsShortRange(blip, false)
			SetBlipColour(blip, 27)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName("Chop Shop")
			EndTextCommandSetBlipName(blip)
			SetBlipRoute(blip, true)
			----- police call chance to get police the location of the drop off zone
			if policechance2 <= 20 then
					local dispatchData = { message = "Car Boost", codeName = 'carboosting', code = '10-50', icon = 'fas fa-car', priority = 2, coords = location,  vehicle = ModelHash, plate = ModelHash.plate, color = ModelHash.color, class = ModelHash.class, doors = ModelHash.doors, jobs = { 'leo', "police" } }
					TriggerServerEvent('ps-dispatch:server:notify', dispatchData)	
			end	
			---- zone two
			zonemath2 = lib.zones.sphere({
			coords = location,
			radius = 4,
			debug = false,
			inside = function()		
				end,
				onEnter = function()
					RemoveBlip(blip)
					FreezeEntityPosition(carboostd, true)
					zonemath2:remove()
					Wait(3000)
					local options = {
					{
						 name = 'hood',
						 icon = 'fa-solid fa-car',
						label = 'Remove Hood',
						bones = {'bonnet'},
						onSelect = function()
							
							 QBCore.Functions.Progressbar("drink_something", "Removing The Hood", 4000, false, true, {
								disableMovement = false,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = true,
								disableInventory = true,
								}, {
									animDict = "mini@repair",
									anim = "fixing_a_ped",
									flags = 49,
								}, {}, {}, function()-- Done
							    exports.ox_target:removeLocalEntity(carboostd, 'hood')
								TriggerServerEvent('md-carboost:server:removehood')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostd, 4, true)
								end)
							
							end 
            
					},
					{
						 name = 'Door1',
						 icon = 'fa-solid fa-car',
						label = 'Remove Door',
						bones = {'door_dside_f'},
						onSelect = function()
							
							 QBCore.Functions.Progressbar("drink_something", "Removing The Door", 4000, false, true, {
								disableMovement = false,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = true,
								disableInventory = true,
								}, {
									animDict = "mini@repair",
									anim = "fixing_a_ped",
									flags = 49,
								}, {}, {}, function()-- Done
								exports.ox_target:removeLocalEntity(carboostd, 'Door1')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostd, 0, true)
								end)
							end 
            
					},
					{
						 name = 'Door2',
						 icon = 'fa-solid fa-car',
						label = 'Remove Door',
						bones = {'door_pside_f'},
						onSelect = function()
							
							 QBCore.Functions.Progressbar("drink_something", "Removing The Door", 4000, false, true, {
								disableMovement = false,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = true,
								disableInventory = true,
								}, {
									animDict = "mini@repair",
									anim = "fixing_a_ped",
									flags = 49,
								}, {}, {}, function()-- Done
								exports.ox_target:removeLocalEntity(carboostd, 'Door2')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostd, 1, true)
								end)
							end 
            
					},
					
					{
						 name = 'Door3',
						 icon = 'fa-solid fa-car',
						label = 'Remove Door',
						bones = {'door_dside_r'},
						onSelect = function()
							
							 QBCore.Functions.Progressbar("drink_something", "Removing The Door", 4000, false, true, {
								disableMovement = false,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = true,
								disableInventory = true,
								}, {
									animDict = "mini@repair",
									anim = "fixing_a_ped",
									flags = 49,
								}, {}, {}, function()-- Done
								exports.ox_target:removeLocalEntity(carboostd, 'Door3')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostd, 2, true)
								end)
							end 
            
					},
					{
						 name = 'Door4',
						 icon = 'fa-solid fa-car',
						label = 'Remove Door',
						bones = {'door_pside_r'},
						onSelect = function()
							
							 QBCore.Functions.Progressbar("drink_something", "Removing The Hood", 4000, false, true, {
								disableMovement = false,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = true,
								disableInventory = true,
								}, {
									animDict = "mini@repair",
									anim = "fixing_a_ped",
									flags = 49,
								}, {}, {}, function()-- Done
								exports.ox_target:removeLocalEntity(carboostd, 'Door4')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostd, 3, true)
								end)
							end 
            
					},
					
					
					{
						 name = 'Boot',
						 icon = 'fa-solid fa-car',
						label = 'Remove Trunk',
						bones = {'boot'},
						onSelect = function()
							
							 QBCore.Functions.Progressbar("drink_something", "Removing The Trunk", 4000, false, true, {
								disableMovement = false,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = true,
								disableInventory = true,
								}, {
									animDict = "mini@repair",
									anim = "fixing_a_ped",
									flags = 49,
								}, {}, {}, function()-- Done
								exports.ox_target:removeLocalEntity(carboostd, 'Boot')
								TriggerServerEvent('md-carboost:server:removetrunk')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostd, 5, true)
								end)
							end 
            
					},
					{
						 name = 'Destroy Vehicle',
						 icon = 'fa-solid fa-car',
						label = 'Destroy Vehicle',
						onSelect = function()
							
							 QBCore.Functions.Progressbar("drink_something", "Removing The Trunk", 4000, false, true, {
								disableMovement = false,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = true,
								disableInventory = true,
								}, {
									animDict = "mini@repair",
									anim = "fixing_a_ped",
									flags = 49,
								}, {}, {}, function()-- Done
								DeleteVehicle(carboostd)
								ClearPedTasks(PlayerPedId())
								TriggerServerEvent('md-carboost:server:successfuldrop')
								end)
							end 
            
					},
				}
				exports.ox_target:addLocalEntity(carboostd, options)
				
				end,
			onExit = function()
				end
		})
		end
})
	 
end)


RegisterNetEvent('o-buyer:server:sellPawnItems', function(itemName, itemAmount, itemPrice, menu)
    local menuType = menu
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local dist
    -- for _, value in pairs(Config.PawnLocation) do
    --     dist = #(playerCoords - value.coords)
    --     if #(playerCoords - value.coords) < 2 then
    --         dist = #(playerCoords - value.coords)
    --         break
    --     end
    -- end
    -- if dist > 5 then exploitBan(src, 'sellPawnItems Exploiting') return end
    if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
        if Config.BankMoney then
            Player.Functions.AddMoney('bank', totalPrice)
        else
            Player.Functions.AddMoney('cash', totalPrice)
        end
        TriggerClientEvent('QBCore:Notify', src, 'You sold ' .. itemAmount .. ' ' .. QBCore.Shared.Items[itemName].label .. ' for $' .. totalPrice, 'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough of that item", 'error')
    end
    if itemName == 'artpiece' or  itemName == 'goldbar' or itemName == 'diamond' or itemName == 'rolex' or itemName == 'necklace' or  itemName == 'goldchain' or itemName == 'paintinge' or itemName == 'paintingi' or itemName == 'paintingh' or  itemName == 'paintingj' or itemName == 'paintingf' or itemName == 'paintingg' then
	TriggerClientEvent('o-buyer:client:openMenu', src)
    elseif itemName == 'musicequipment' or  itemName == 'computer' or itemName == 'television' or itemName == 'microwave' then
        TriggerClientEvent('o-buyer:client:openPawnElec', src)
    elseif itemName == 'sea_boot' or  itemName == 'sea_tin' or itemName == 'fish_small' or itemName == 'fish_bass' or itemName == 'fish_bluefish' or  itemName == 'fish_cod' or itemName == 'fish_flounder' or itemName == 'fish_mackerel' or itemName == 'fish_dolphin' or  itemName == 'fish_shark' or itemName == 'fish_whale' or itemName == 'treasure_box' then
        TriggerClientEvent('o-buyer:client:openPawnFish', src)
    end
end)

lib.callback.register('o-buyer:server:getInv', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    return inventory
end)
