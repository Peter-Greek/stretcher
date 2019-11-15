-- Coded by Xerxes468893#0001 (Peter Greek) For BCDOJRP, released to the public
print('Loaded ARPF by Xerxes468893 (Peter Greek) for BCDOJRP.') -- Do not Remove Pls!
local str = {}
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(5000)
		TriggerClientEvent("ARPF-EMS:stretcherSync", -1,str)	
	end
end)

RegisterNetEvent("ARPF-EMS:server:stretcherSync")
AddEventHandler("ARPF-EMS:server:stretcherSync", function(state,tableID,obj,towhat,sync)
	if tonumber(sync) == 0 or sync == false or sync == nil then 
		if state == 1 then -- add
			if tableID < 0 then 
				str[#str + 1] = { ['obj'] = obj, ['to'] = towhat}
				TriggerClientEvent("ARPF-EMS:stretcherSync", -1,str)
			end 
		elseif state == 2 then -- change
			if tableID > 0 then 
				str[tableID] = { ['obj'] = obj, ['to'] = towhat}
				TriggerClientEvent("ARPF-EMS:stretcherSync", -1,str)
			end
		elseif state == 3 then -- remove 
			if tableID > 0 then
				table.remove(str,tableID)
				TriggerClientEvent("ARPF-EMS:stretcherSync", -1,str)
			end
		end
	elseif tonumber(sync) == 1 or sync == true then -- this is to only force sync all players and not do anything to the table
		TriggerClientEvent("ARPF-EMS:stretcherSync", -1,str)
	end 
end)



RegisterCommand("spawnstr", function(source, args, raw)
	local player = source 
	if (player > 0) then
		TriggerClientEvent("ARPF-EMS:spawnstretcher", source)
		CancelEvent()
	end
end, false)
--print("copy")
RegisterCommand("pushstr", function(source, args, raw)
	local player = source 
	if (player > 0) then
		--print("true")
		TriggerClientEvent("ARPF-EMS:pushstreacherss", source)
		CancelEvent()
	end
end, false)

RegisterCommand("getintostr", function(source, args, raw)
	local player = source 
	if (player > 0) then
		TriggerClientEvent("ARPF-EMS:getintostretcher", source)
		CancelEvent()
	end
end, false)

RegisterCommand("openbaydoors", function(source, args, raw)
	local player = source 
	if (player > 0) then
		TriggerClientEvent("ARPF-EMS:opendoors", source)
		CancelEvent()
	end
end, false)

RegisterCommand("togglestr", function(source, args, raw)
	local player = source 
	if (player > 0) then
		TriggerClientEvent("ARPF-EMS:togglestrincar", source)
		CancelEvent()
	end
end, false)

