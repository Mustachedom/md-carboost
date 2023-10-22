local QBCore = exports['qb-core']:GetCoreObject()
local timeOut = false
local vintimeout = false
QBCore.Functions.CreateUseableItem("mdlaptop", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        TriggerClientEvent("md-carboost:client:ChooseClass", src)
    
end)

RegisterServerEvent('md-carboost:server:getcopsd', function()
	local copsOnDuty = 0
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
    	local Player = QBCore.Functions.GetPlayer(v)
    	if Player ~= nil then
    		if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.type == "leo") and Player.PlayerData.job.onduty then
    			copsOnDuty = copsOnDuty + 1
    		end
    	end
    end
    if copsOnDuty >= Config.ActivePolice then
		if not timeOut then
			timeOut = true
			TriggerClientEvent("md-carboost:client:ClassD", src)
				Citizen.CreateThread(function()
					Citizen.Wait(60 * 1000 * 5)
					timeOut = false
				end)
				
		else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least 5 Minutes before ordering another boost' )
		end	
    else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least '..Config.ActivePolice.. ' police to boost a car')
    end
end)

RegisterServerEvent('md-carboost:server:getcopsc', function()
	local copsOnDuty = 0
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
    	local Player = QBCore.Functions.GetPlayer(v)
    	if Player ~= nil then
    		if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.type == "leo") and Player.PlayerData.job.onduty then
    			copsOnDuty = copsOnDuty + 1
    		end
    	end
    end
    if copsOnDuty >= Config.ActivePolice then
		if not timeOut then
			timeOut = true
			TriggerClientEvent("md-carboost:client:ClassC", src)
				Citizen.CreateThread(function()
					Citizen.Wait(60 * 1000 * 5)
					timeOut = false
				end)
				
		else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least 5 Minutes ' )
		end	
    else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least '..Config.ActivePolice.. ' police to boost a car')
    end
end)

RegisterServerEvent('md-carboost:server:getcopsb', function()
	local copsOnDuty = 0
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
    	local Player = QBCore.Functions.GetPlayer(v)
    	if Player ~= nil then
    		if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.type == "leo") and Player.PlayerData.job.onduty then
    			copsOnDuty = copsOnDuty + 1
    		end
    	end
    end
    if copsOnDuty >= Config.ActivePolice then
		if not timeOut then
			timeOut = true
			TriggerClientEvent("md-carboost:client:ClassB", src)
				Citizen.CreateThread(function()
					Citizen.Wait(60 * 1000 * 5)
					timeOut = false
				end)
				
		else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least 5 Minutes ' )
		end	
    else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least '..Config.ActivePolice.. ' police to boost a car')
    end
end)

RegisterServerEvent('md-carboost:server:getcopsa', function()
	local copsOnDuty = 0
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
    	local Player = QBCore.Functions.GetPlayer(v)
    	if Player ~= nil then
    		if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.type == "leo") and Player.PlayerData.job.onduty then
    			copsOnDuty = copsOnDuty + 1
    		end
    	end
    end
    if copsOnDuty >= Config.ActivePolice then
		if not timeOut then
			timeOut = true
			TriggerClientEvent("md-carboost:client:ClassA", src)
				Citizen.CreateThread(function()
					Citizen.Wait(60 * 1000 * 5)
					timeOut = false
				end)
				
		else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least 5 Minutes ' )
		end	
    else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least '..Config.ActivePolice.. ' police to boost a car')
    end
end)

RegisterServerEvent('md-carboost:server:getcopsvin', function()
	local copsOnDuty = 0
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
    	local Player = QBCore.Functions.GetPlayer(v)
    	if Player ~= nil then
    		if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.type == "leo") and Player.PlayerData.job.onduty then
    			copsOnDuty = copsOnDuty + 1
    		end
    	end
    end
    if copsOnDuty >= Config.ActivePolice then
		if not vintimeout then
			vintimeout = true
			TriggerClientEvent("md-carboost:client:VinScratch", src)
				Citizen.CreateThread(function()
					Citizen.Wait(60 * 1000 * 5)
					vintimeout = false
				end)
				
		else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least 5 Minutes or 60 minutes between successful vin scratch' )
		end	
    else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least '..Config.ActivePolice.. ' police to boost a car')
    end
end)




RegisterNetEvent('md-carboost:server:successfuldrop', function(deliveryData, inTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local curRep = Player.PlayerData.metadata["carboosting"]
    local payout = math.random(100,4000)
	if Player.Functions.AddMoney("cash", payout) then
		Player.Functions.SetMetaData('carboosting', (curRep + 1))
	end
	if not timeOut then
		timeOut = true
			Citizen.CreateThread(function()
				Citizen.Wait(60 * 1000 * 10)
				timeOut = false
			end)
			
	else
	TriggerClientEvent('QBCore:Notify', src,  'Need at least 10 Minutes After A Boost' )
	end	
    
end)

RegisterNetEvent('md-carboost:server:successfuldropc', function(deliveryData, inTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local curRep = Player.PlayerData.metadata["carboosting"]
    local payout = math.random(100,4000)
	if Player.Functions.AddMoney("cash", payout) then
		Player.Functions.SetMetaData('carboosting', (curRep + 2))
	end
	if not timeOut then
			timeOut = true
				Citizen.CreateThread(function()
					Citizen.Wait(60 * 1000 * 10)
					timeOut = false
				end)
				
	else
		TriggerClientEvent('QBCore:Notify', src,  'Need at least 10 Minutes After A Boost' )
	end	

end)

RegisterNetEvent('md-carboost:server:successfuldropb', function(deliveryData, inTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local curRep = Player.PlayerData.metadata["carboosting"]
    local payout = math.random(100,4000)
	if Player.Functions.AddMoney("cash", payout) then
		Player.Functions.SetMetaData('carboosting', (curRep + 3))
	end
	if not timeOut then
		timeOut = true
			Citizen.CreateThread(function()
				Citizen.Wait(60 * 1000 * 10)
				timeOut = false
			end)
			
	else
	TriggerClientEvent('QBCore:Notify', src,  'Need at least 10 Minutes After A Boost' )
	end	
    
end)

RegisterNetEvent('md-carboost:server:successfuldropa', function(deliveryData, inTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local curRep = Player.PlayerData.metadata["carboosting"]
    local payout = math.random(100,4000)
	if Player.Functions.AddMoney("cash", payout) then
		Player.Functions.SetMetaData('carboosting', (curRep + 4))
	end
	if not timeOut then
		timeOut = true
			Citizen.CreateThread(function()
				Citizen.Wait(60 * 1000 * 10)
				timeOut = false
			end)
			
	else
	TriggerClientEvent('QBCore:Notify', src,  'Need at least 10 Minutes After A Boost' )
	end	
   
end)


RegisterNetEvent('md-carboost:server:removetrunk', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
   
	if Player.Functions.AddItem("car_trunk", 1) then
	end
end)

RegisterNetEvent('md-carboost:server:removehood', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
   
	if Player.Functions.AddItem("car_hood", 1) then
	end
end)

RegisterNetEvent('md-carboost:server:removedoor', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
   
	if Player.Functions.AddItem("car_door", 1) then
	end
end)

RegisterNetEvent('md-carboost:server:buylaptop', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
   
	if Player.Functions.RemoveMoney("cash", 10000) then
		Player.Functions.AddItem("mdlaptop", 1)
	end
end)

RegisterNetEvent('md-carboost:server:successfulvin', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local curRep = Player.PlayerData.metadata["carboosting"]
   
	if Player.Functions.SetMetaData('carboosting', (curRep + 10)) then
	end
	if not vintimeout then
			vintimeout = true
				Citizen.CreateThread(function()
					Citizen.Wait(60 * 1000 * 60)
					vintimeout = false
				end)
				
		else
    	TriggerClientEvent('QBCore:Notify', src,  'Need at least 60 Minutes After A VinScratch' )
		end	
end)

RegisterNetEvent('md-carboost:server:SaveCar', function(mods, vehicle, _, plate)
		local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
        if result[1] == nil then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                Player.PlayerData.license,
                Player.PlayerData.citizenid,
                vehicle.model,
                vehicle.hash,
                json.encode(mods),
                plate,
                0
            })
            TriggerClientEvent('QBCore:Notify', src, "You Scratched The Vin", 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, "Already Owned", 'error', 3000)
        end
end)