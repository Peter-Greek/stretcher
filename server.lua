-- Coded by Xerxes468893#0001 (Peter Greek) For BCDOJRP, released to the public
print('Loaded ARPF by Xerxes468893 (Peter Greek) for BCDOJRP.') -- Do not Remove Pls!

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

