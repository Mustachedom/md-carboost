local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-carboost:client:getcopsc")
AddEventHandler("md-carboost:client:getcopsc", function() 
TriggerServerEvent('md-carboost:server:getcopsc')
end)

RegisterNetEvent("md-carboost:client:ClassC")
AddEventHandler("md-carboost:client:ClassC", function() 
	local myRep = QBCore.Functions.GetPlayerData().metadata["carboosting"]
	local coords = Config.ClassC[math.random(#Config.ClassC)]
	local ModelHash = Config.ClassCVehicles[math.random(#Config.ClassCVehicles)] 
	local zonemath = math.random(1,100)
	local zonemath2 = math.random(1,100)
	local policechance1 = math.random(1,10)
	local policechance2 = math.random(1,10)
	local ownermath = math.random(1,100)
	local Chasemath = math.random(1,100)
	if myRep <= Config.ClassCrep then
		lib.notify({ title = "Not Enough", description = "you need at least " .. Config.ClassCrep .. " boosts done", type = "error" })
	else	
	 lib.requestModel(ModelHash)
	local carboostc = CreateVehicle(ModelHash,coords.x, coords.y, coords.z-1, coords.h, true, false)
    SetEntityHeading(carboostc, coords.w)
	SetEntityAsMissionEntity(carboostc, true, true)
    exports[Config.fuel]:SetFuel(carboostc, 100.0)
	local classcboost = AddBlipForRadius(coords, 200.0) -- need to have .0
	SetBlipColour(classcboost, 1)
	SetBlipAlpha(classcboost, 128)
	if policechance1 <= 3 then
		local dispatchData = { message = "Car Boost", codeName = 'carboosting', code = '10-50', icon = 'fas fa-car', priority = 2, coords = coords,  vehicle = ModelHash, plate = ModelHash.plate, color = ModelHash.color, class = ModelHash.class, doors = ModelHash.doors, jobs = { 'leo', "police" } }
		TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
    end	
    EndTextCommandSetBlipName(classcboost)
	 TriggerServerEvent('qb-phone:server:sendNewMail', {
               sender = "Car Boost",
               subject = "Get This For Me",
               message = "You Are Looking for A " .. ModelHash.. " With A License Plate " .. QBCore.Functions.GetPlate(carboostc) .. " Hurry Up And Find It In The Zone. You Wont Be Able To Do This As Easy As The Class D Vehicles. You May Have To Third Eye To Hack Stuff",
               button = {}
           })
	FreezeEntityPosition(carboostc, true)
	local hacks = {
					{
						 name = 'hackcar',
						 icon = 'fa-solid fa-car',
						label = 'Hack Car',
						onSelect = function()
							exports['ps-ui']:Circle(function(success)
								if success then
									FreezeEntityPosition(carboostc, false)
									TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(carboostc))
									exports.ox_target:removeLocalEntity(carboostc, 'hackcar')
								else
									lib.notify({ title = "Cmon", description = "You Suck", type = "error" })
								end
								end, 4, 10)
							end 
					}
	}				
	exports.ox_target:addLocalEntity(carboostc, hacks)
	 zonemath = lib.zones.sphere({
    coords = coords,
    radius = 4,
    debug = true,
    inside = function()
			 			
			 end,
    onEnter = function()
				if ownermath <= 20 then
				 SpawnPed()
				end 
				RemoveBlip(classcboost)
			end,
    onExit = function()
		if Chasemath <= 20 then
			SpawnCarPedChase()
		end	
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
			if policechance2 <= 3 then
					local dispatchData = { message = "Car Boost", codeName = 'carboosting', code = '10-50', icon = 'fas fa-car', priority = 2, coords = location,  vehicle = ModelHash, plate = ModelHash.plate, color = ModelHash.color, class = ModelHash.class, doors = ModelHash.doors, jobs = { 'leo', "police" } }
					TriggerServerEvent('ps-dispatch:server:notify', dispatchData)	
			end	
			zonemath2 = lib.zones.sphere({
			coords = location,
			radius = 4,
			debug = true,
			inside = function()		
				end,
				onEnter = function()
					RemoveBlip(blip)
					FreezeEntityPosition(carboostc, true)
					zonemath2:remove()
					Wait(3000)
					local options = {
					{
						 name = 'removehood',
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
							    exports.ox_target:removeLocalEntity(carboostc, 'removehood')
								TriggerServerEvent('md-carboost:server:removehood')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostc, 4, true)
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
								exports.ox_target:removeLocalEntity(carboostc, 'Door1')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostc, 0, true)
								end)
							end 
            
					},
					{
						 name = 'Door2',
						 icon = 'fa-solid fa-car',
						label = 'Remove Door',
						bones = {'door_pside_f'},
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
								exports.ox_target:removeLocalEntity(carboostc, 'Door2')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostc, 1, true)
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
								exports.ox_target:removeLocalEntity(carboostc, 'Door3')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostc, 2, true)
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
								exports.ox_target:removeLocalEntity(carboostc, 'Door4')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostc, 3, true)
								end)
							end 
            
					},
					
					
					{
						 name = 'removetrunk',
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
								exports.ox_target:removeLocalEntity(carboostc, 'removetrunk')
								TriggerServerEvent('md-carboost:server:removetrunk')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostc, 5, true)
								end)
							end 
            
					},
					{
						 name = 'destroy',
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
								DeleteVehicle(carboostc)
								ClearPedTasks(PlayerPedId())
								TriggerServerEvent('md-carboost:server:successfuldropc')
								end)
							end 
            
					},
				}
				exports.ox_target:addLocalEntity(carboostc, options)
				
				end,
			onExit = function()
				end
		})
		end
		
})
end
end)

