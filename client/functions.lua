local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-carboost:client:ChooseClass", function() 
lib.registerContext({
  id = 'carboosting',
  title = 'carboosting',
  options = {
    
    {
      title = 'Car Boost Tier D',
      description = 'Boost A Tier D Car',
      event = "md-carboost:client:getcopsd",
      arrow = true,
    },
    {
      title = 'Car Boost Tier C',
      description = 'Boost A Tier C Car',
      event = "md-carboost:client:getcopsc",
      arrow = true,
    },
    {
       title = 'Car Boost Tier B',
      description = 'Boost A Tier B Car',
      event = "md-carboost:client:getcopsb",
      arrow = true,
    },
    {
      title = 'Car Boost Tier A',
      description = 'Boost A Tier A Car',
      event = "md-carboost:client:getcopsa",
      arrow = true,
    },
	 {
      title = 'Vin Scratch',
      description = 'Vin Scratch',
      event = "md-carboost:client:getcopsvin",
      arrow = true,
    }
  }
})
lib.showContext('carboosting')
end)



RegisterCommand('checkrepcarboost', function()
    local carboost = QBCore.Functions.GetPlayerData().metadata["carboosting"]
    QBCore.Functions.Notify("Current Rep: "..carboost)
end)


----------- functions
function SpawnPed()
    local pedCoords = GetEntityCoords(cache.ped)
    local current = 'ig_priest'
    lib.requestModel(current)

		owner = CreatePed(26, current, pedCoords.x + 10, pedCoords.y -3 , pedCoords.z - 1, 90.0, true, true)
		NetworkRegisterEntityAsNetworked(owner)
		networkID = NetworkGetNetworkIdFromEntity(owner)
		SetNetworkIdCanMigrate(networkID, true)
		SetNetworkIdExistsOnAllMachines(networkID, true)
		SetPedRandomComponentVariation(owner)
		SetPedRandomProps(owner)
		SetEntityAsMissionEntity(owner)
		SetEntityVisible(owner, true)
		SetPedRelationshipGroupHash(owner)
		SetPedAccuracy(owner)
		SetPedArmour(owner)
		SetPedCanSwitchWeapon(owner, true)
		SetPedFleeAttributes(owner, false)
		GiveWeaponToPed(owner, 'weapon_pistol', 1, false, true)
		TaskCombatPed(owner, cache.ped, 0, 16)
		SetPedCombatAttributes(owner, 46, true)
end

--2nd Peds
function SpawnCarPedChase()
	local ped = GetEntityCoords(PlayerPedId())
    	-- Motorcycle Model
   	 local modelhash = `faggio3`
    	lib.requestModel(modelhash)
	ClearAreaOfVehicles(ped.x, ped.y, ped.z, 15.0, false, false, false, false, false)
	transport = CreateVehicle(`faggio3`, ped.x+3, ped.y-2, ped.z-1, 52.0, true, true)
	SetEntityAsMissionEntity(transport)
   	 -- Pilot Peds
    	local pilothash = 'ig_priest'
    	lib.requestModel(pilothash)
	pilot = CreatePed(26, pilothash, ped.x, ped.y, ped.z, 268.9422, true, false)
	pilot2 = CreatePed(26, pilothash, ped.x, ped.y, ped.z, 268.9422, true, false)
	TaskCombatPed(pilot, PlayerPedId(), 0, 16)
	SetPedIntoVehicle(pilot, transport, -1)
	SetPedIntoVehicle(pilot2, transport, 0)
	SetPedFleeAttributes(pilot,false)
	SetPedCombatAttributes(pilot, 46, 1)
	SetPedCombatAbility(pilot, 100)
	SetPedCombatMovement(pilot, 2)
	SetPedCombatRange(pilot, 2)
	SetPedKeepTask(pilot, true)
	SetPedAsCop(pilot, true)
	TaskVehicleChase(pilot ,PlayerPedId())
	GiveWeaponToPed(pilot2, "weapon_pistol", 1, false, true)
	TaskVehicleShootAtPed(pilot2, PlayerPedId())

end

CreateThread(function()
    local modelHash = 'ig_priest'
    lib.requestModel(modelHash, 1000)
    local laptopSales = config.laptopSale
    laptopSeller = CreatePed(0, modelHash, laptopSales.x, laptopSales.y, laptopSales.z -1, false, false)
    FreezeEntityPosition(laptopSeller, true)
    SetEntityInvincible(laptopSeller, true)

      local options = {
      {
        name = 'laptopSales',
        icon = 'fa-solid fa-car',
        label = 'Buy Laptop For $10k Cash',
        serverEvent = 'md-carboost:server:buylaptop'
      }
    }
    exports.ox_target:addLocalEntity(laptopSeller, options)
end)


