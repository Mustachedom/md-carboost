local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-carboost:client:getcopsb")
AddEventHandler("md-carboost:client:getcopsb", function() 
TriggerServerEvent('md-carboost:server:getcopsb')
end)

RegisterNetEvent("md-carboost:client:ClassB")
AddEventHandler("md-carboost:client:ClassB", function() 
	local myRep = QBCore.Functions.GetPlayerData().metadata["carboosting"]
	local coords = Config.ClassB[math.random(#Config.ClassB)]
	local ModelHash = Config.ClassBVehicles[math.random(#Config.ClassBVehicles)] 
	local zonemath = math.random(1,100)
	local zonemath2 = math.random(1,100)
	local policechance1 = math.random(1,100)
	local policechance2 = math.random(1,100)
	local ownermath = math.random(1,100)
	local Chasemath = math.random(1,100)
	if myRep <= Config.ClassBrep then
		lib.notify({ title = "Not Enough", description = "you need at least " .. Config.ClassBrep .. " boosts done", type = "error" })
	else	
	 lib.requestModel(ModelHash)
	local carboostb = CreateVehicle(ModelHash,coords.x, coords.y, coords.z-1, coords.h, true, false)
    SetEntityHeading(carboostb, coords.w)
	SetEntityAsMissionEntity(carboostb, true, true)
    exports[Config.fuel]:SetFuel(carboostb, 100.0)
	local classbboost = AddBlipForRadius(coords, 200.0) -- need to have .0
	SetBlipColour(classbboost, 1)
	SetBlipAlpha(classbboost, 128)
	if policechance1 <= 40 then
		local dispatchData = { message = "Car Boost", codeName = 'carboosting', code = '10-50', icon = 'fas fa-car', priority = 2, coords = coords,  vehicle = ModelHash, plate = ModelHash.plate, color = ModelHash.color, class = ModelHash.class, doors = ModelHash.doors, jobs = { 'leo', "police" } }
		TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
    end	
    EndTextCommandSetBlipName(classbboost)
	 TriggerServerEvent('qb-phone:server:sendNewMail', {
               sender = "Car Boost",
               subject = "Get This For Me",
               message = "You Are Looking for A " .. ModelHash.. " With A License Plate " .. QBCore.Functions.GetPlate(carboostb) .. " Hurry Up And Find It In The Zone. You Wont Be Able To Do This As Easy As The Class D Vehicles. You May Have To Third Eye To Hack Stuff",
               button = {}
           })
	FreezeEntityPosition(carboostb, true)
	local hacks = {
					{
						 name = 'hackcar',
						 icon = 'fa-solid fa-car',
						label = 'Hack Car',
						onSelect = function()
							exports['ps-ui']:VarHack(function(success)
								if success then
									FreezeEntityPosition(carboostb, false)
									TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(carboostb))
									exports.ox_target:removeLocalEntity(carboostb, 'hackcar')
									else
										lib.notify({ title = "Cmon", description = "You Suck", type = "error" })
									end
								end, 4, 3)
							end 
					}
	}				
	exports.ox_target:addLocalEntity(carboostb, hacks)
	 zonemath = lib.zones.sphere({
    coords = coords,
    radius = 4,
    debug = false,
    inside = function()
			 			
			 end,
    onEnter = function()
				if ownermath <= 30 then
				 SpawnPed()
				end
			end,
    onExit = function()
			if Chasemath <= 30 then
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
			if policechance2 <= 40 then
					local dispatchData = { message = "Car Boost", codeName = 'carboosting', code = '10-50', icon = 'fas fa-car', priority = 2, coords = location,  vehicle = ModelHash, plate = ModelHash.plate, color = ModelHash.color, class = ModelHash.class, doors = ModelHash.doors, jobs = { 'leo', "police" } }
					TriggerServerEvent('ps-dispatch:server:notify', dispatchData)	
			end	
			zonemath2 = lib.zones.sphere({
			coords = location,
			radius = 4,
			debug = false,
			inside = function()		
				end,
				onEnter = function()
					RemoveBlip(blip)
					FreezeEntityPosition(carboostb, true)
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
							    exports.ox_target:removeLocalEntity(carboostb, 'removehood')
								TriggerServerEvent('md-carboost:server:removehood')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostb, 4, true)
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
								exports.ox_target:removeLocalEntity(carboostb, 'Door1')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostb, 0, true)
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
								exports.ox_target:removeLocalEntity(carboostb, 'Door2')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostb, 1, true)
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
								exports.ox_target:removeLocalEntity(carboostb, 'Door3')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostb, 2, true)
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
								exports.ox_target:removeLocalEntity(carboostb, 'Door4')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostb, 3, true)
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
								exports.ox_target:removeLocalEntity(carboostb, 'removetrunk')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboostb, 5, true)
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
								TriggerServerEvent('md-carboost:server:successfuldropb')
								end)
							end 
            
					},
				}
				exports.ox_target:addLocalEntity(carboostb, options)
				
				end,
			onExit = function()
				end
		})
		end
		
})
end
end)

