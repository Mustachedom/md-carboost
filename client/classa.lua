local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-carboost:client:getcopsa")
AddEventHandler("md-carboost:client:getcopsa", function() 
TriggerServerEvent('md-carboost:server:getcopsa')
end)

RegisterNetEvent("md-carboost:client:ClassA")
AddEventHandler("md-carboost:client:ClassA", function() 
	local myRep = QBCore.Functions.GetPlayerData().metadata["carboosting"]
	local coords = Config.ClassA[math.random(#Config.ClassA)]
	local ModelHash = Config.ClassAVehicles[math.random(#Config.ClassAVehicles)] 
	local zonemath = math.random(1,100)
	local zonemath2 = math.random(1,100)
	local policechance1 = math.random(1,100)
	local policechance2 = math.random(1,100)
	if myRep <= Config.ClassArep then
		lib.notify({ title = "Not Enough", description = "you need at least " .. Config.ClassArep .. " boosts done", type = "error" })
	else	
	 lib.requestModel(ModelHash)
	local carboosta = CreateVehicle(ModelHash,coords.x, coords.y, coords.z-1, coords.h, true, false)
    SetEntityHeading(carboosta, coords.w)
	SetEntityAsMissionEntity(carboosta, true, true)
    exports[Config.fuel]:SetFuel(carboosta, 100.0)
	local classaboost = AddBlipForRadius(coords, 200.0) -- need to have .0
	SetBlipColour(classaboost, 1)
	SetBlipAlpha(classaboost, 128)
	if policechance1 <= 60 then
		local dispatchData = { message = "Car Boost", codeName = 'carboosting', code = '10-50', icon = 'fas fa-car', priority = 2, coords = coords,  vehicle = ModelHash, plate = ModelHash.plate, color = ModelHash.color, class = ModelHash.class, doors = ModelHash.doors, jobs = { 'leo', "police" } }
		TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
    end	
    EndTextCommandSetBlipName(classaboost)
	 TriggerServerEvent('qb-phone:server:sendNewMail', {
               sender = "Car Boost",
               subject = "Get This For Me",
               message = "You Are Looking for A " .. ModelHash.. " With A License Plate " .. QBCore.Functions.GetPlate(carboosta) .. " Hurry Up And Find It In The Zone. You Wont Be Able To Do This As Easy As The Class D Vehicles. You May Have To Third Eye To Hack Stuff",
               button = {}
           })
	FreezeEntityPosition(carboosta, true)
	local hacks = {
					{
						 name = 'hackcar',
						 icon = 'fa-solid fa-car',
						label = 'Hack Car',
						onSelect = function()
							exports['ps-ui']:Scrambler(function(success)
								if success then
									FreezeEntityPosition(carboosta, false)
									TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(carboosta))
									exports.ox_target:removeLocalEntity(carboosta, 'hackcar')
								else
										lib.notify({ title = "Cmon", description = "You Suck", type = "error" })
								end
							end, "numeric", 30, 0)
							end
					}
	}				
	exports.ox_target:addLocalEntity(carboosta, hacks)
	 zonemath = lib.zones.sphere({
    coords = coords,
    radius = 4,
    debug = false,
    inside = function()
						
			 end,
    onEnter = function()
				SpawnPed()
				 RemoveBlip(classaboost)
			end,
    onExit = function()
		SpawnCarPedChase()
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
			if policechance2 <= 60 then
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
					FreezeEntityPosition(carboosta, true)
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
							    exports.ox_target:removeLocalEntity(carboosta, 'removehood')
								TriggerServerEvent('md-carboost:server:removehood')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboosta, 4, true)
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
								exports.ox_target:removeLocalEntity(carboosta, 'Door1')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboosta, 0, true)
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
								exports.ox_target:removeLocalEntity(carboosta, 'Door2')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboosta, 1, true)
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
								exports.ox_target:removeLocalEntity(carboosta, 'Door3')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboosta, 2, true)
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
								exports.ox_target:removeLocalEntity(carboosta, 'Door4')
								TriggerServerEvent('md-carboost:server:removedoor')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboosta, 3, true)
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
								exports.ox_target:removeLocalEntity(carboosta, 'removetrunk')
								TriggerServerEvent('md-carboost:server:removetrunk')
								ClearPedTasks(PlayerPedId())
								SetVehicleDoorBroken(carboosta, 5, true)
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
								TriggerServerEvent('md-carboost:server:successfuldropa')
								end)
							end 
            
					}
				}
				exports.ox_target:addLocalEntity(carboosta, options)
				exports.ox_target:addLocalEntity(prop_palm_sm_01a, options)
				end,
			onExit = function()
				end
		})
		end
		
})
end
end)

