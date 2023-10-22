local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent("md-carboost:client:getcopsvin")
AddEventHandler("md-carboost:client:getcopsvin", function() 

	TriggerServerEvent('md-carboost:server:getcopsvin')

end)
local function getVehicleFromVehList(hash)
	for _, v in pairs(QBCore.Shared.Vehicles) do
		if hash == v.hash then
			return v.model
		end
	end
end

RegisterNetEvent("md-carboost:client:VinScratch")
AddEventHandler("md-carboost:client:VinScratch", function() 
	local myRep = QBCore.Functions.GetPlayerData().metadata["carboosting"]
	local coords = Config.VinScratchLoc[math.random(#Config.VinScratchLoc)]
	local ModelHash = Config.VinScratch[math.random(#Config.VinScratch)] 
	local zonemath = math.random(1,100)
	local zonemath2 = math.random(1,100)
		if myRep <= Config.Vinscratchrep then
			lib.notify({ title = "Not Enough", description = "you need at least " .. Config.Vinscratchrep .. " boosts done", type = "error" })
		
		else	
		--- spawns car
		cooldown = true
		lib.requestModel(ModelHash)
		local vinscratchcar = CreateVehicle(ModelHash,coords.x, coords.y, coords.z-1, coords.h, true, false)
		SetEntityHeading(vinscratchcar, coords.w)
		SetEntityAsMissionEntity(vinscratchcar, true, true)
		exports[Config.fuel]:SetFuel(vinscratchcar, 100.0)
		SetVehicleOnGroundProperly(vinscratchcar)
		--- Blip
		local vinscratchblip = AddBlipForRadius(coords.x, coords.y, coords.z, 200.0) -- need to have .0
		SetBlipColour(vinscratchblip, 1)
		SetBlipAlpha(vinscratchblip, 128)
		EndTextCommandSetBlipName(vinscratchblip)
		---- preset to ps-dispatch. Gives location of where the car is to police as soon as the player gets it.
			local dispatchData = { message = "Vin Scratch", codeName = 'carboosting', code = '10-50', icon = 'fas fa-car', priority = 2, coords = coords,  vehicle = ModelHash, plate = ModelHash.plate, color = ModelHash.color, class = ModelHash.class, doors = ModelHash.doors, jobs = { 'leo', "police" } }
			TriggerServerEvent('ps-dispatch:server:notify', dispatchData)	
		--- emails player what car and license plate. Doesnt need to interact with the email for waypoint
		TriggerServerEvent('qb-phone:server:sendNewMail', {
				sender = "Car Boost",
				subject = "Get This For Me",
				message = "You Are Looking for A " .. ModelHash.. " With A License Plate " .. QBCore.Functions.GetPlate(vinscratchcar) .. " Hurry Up And Find It In The Zone. You Wont Be Able To Do This As Easy As The Class D Vehicles. You May Have To Third Eye To Hack Stuff",
				button = {}
			})
		----- this is so they can't use just a lockpick and need to actually do the hacks
		FreezeEntityPosition(vinscratchcar, true)
		------ hacks and target
		local hacks = {
			{
				name = 'hackcar',
				icon = 'fa-solid fa-car',
				label = 'Hack Car',
				onSelect = function()
						exports['ps-ui']:Circle(function(success)
							if success then
								Wait(1000)
								exports['ps-ui']:VarHack(function(success)
									if success then
										Wait(1000)
										exports['ps-ui']:Scrambler(function(success)
											if success then
												FreezeEntityPosition(vinscratchcar, false)
												TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vinscratchcar))
												exports.ox_target:removeLocalEntity(vinscratchcar, 'hackcar')
											else
												exports.ox_target:removeLocalEntity(vinscratchcar, 'hackcar')
												zonemath:remove()
												DeleteVehicle(vinscratchcar)
											end
											end, "numeric", 60, 0)
									else
										exports.ox_target:removeLocalEntity(vinscratchcar, 'hackcar')
										zonemath:remove()
										DeleteVehicle(vinscratchcar)
									end
									end, 2, 3)
							else
							exports.ox_target:removeLocalEntity(vinscratchcar, 'hackcar')
							zonemath:remove()
							DeleteVehicle(vinscratchcar)
							end
							end, 5, 8)
					end
			}
		}				
		exports.ox_target:addLocalEntity(vinscratchcar, hacks)
		---- first zone Pick Up Location
		zonemath = lib.zones.sphere({
		coords = coords,
		radius = 4,
		debug = false,
		inside = function()	
				end,
		onEnter = function()
					--- spawns a ped to shoot you and removes radius blip
					SpawnPed()
					RemoveBlip(vinscratchblip)
				end,
		onExit = function()
			--- spawns peds on faggio to shoot and chase you and gives waypoint to second zone
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
				----- alerts police where the dropoff zone is
				local dispatchData = { message = "Car Boost", codeName = 'carboosting', code = '10-50', icon = 'fas fa-car', priority = 2, coords = location,  vehicle = ModelHash, plate = ModelHash.plate, color = ModelHash.color, class = ModelHash.class, doors = ModelHash.doors, jobs = { 'leo', "police" } }
				TriggerServerEvent('ps-dispatch:server:notify', dispatchData)	
				---- Zone 2 where you drop off and vin scratch
				Wait(1000 * 50)
				SpawnCarPedChase()
				zonemath2 = lib.zones.sphere({
				coords = location,
				radius = 4,
				debug = false,
				inside = function()		
					end,
					onEnter = function()
						RemoveBlip(blip)
						FreezeEntityPosition(vinscratchcar, true)
						zonemath2:remove()
						Wait(3000)
						
						local ped = PlayerPedId()
						local veh = GetVehiclePedIsIn(ped)
						QBCore.Functions.Progressbar("drink_something", "Scratching The Vin", 20000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
						disableInventory = true,
						}, {
							animDict = "mini@repair",
							anim = "fixing_a_ped",
							flags = 49,
						}, {}, {}, function()
						FreezeEntityPosition(vinscratchcar, false)
						------ how you get the car to your vehicle list 
						if veh ~= nil and veh ~= 0 then
							local plate = QBCore.Functions.GetPlate(veh)
							local props = QBCore.Functions.GetVehicleProperties(veh)
							local hash = props.model
							local vehname = getVehicleFromVehList(hash)
							if QBCore.Shared.Vehicles[vehname] ~= nil and next(QBCore.Shared.Vehicles[vehname]) ~= nil then
								TriggerServerEvent('md-carboost:server:SaveCar', props, QBCore.Shared.Vehicles[vehname], GetHashKey(veh), plate)
								TriggerServerEvent('md-carboost:server:successfulvin')
							else
								QBCore.Functions.Notify("Not In A Car", 'error')
							end
						else
							QBCore.Functions.Notify("Doesnt Exist", 'error')
						end
							
						end)	
						end,
					onExit = function()
						end
				})
				end
				})
	
			end
end)
