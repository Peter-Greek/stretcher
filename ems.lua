-- Coded by Xerxes468893#0001 (Peter Greek) For BCDOJRP, released to the public

strNames = { 'v_med_bed1', 'v_med_bed2','prop_ld_binbag_01'} -- Add more model strings here if you'd like
strHashes = {}
animDict = 'missfbi5ig_0'
animName = 'lyinginpain_loop_steve'
isOnstr = false
local strTable = {}
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
    for k,v in ipairs(strNames) do
        table.insert( strHashes, GetHashKey(v))
    end
end) 

function VehicleInFront()
  local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

local open = false
RegisterNetEvent("ARPF-EMS:opendoors")
AddEventHandler("ARPF-EMS:opendoors", function()
veh = VehicleInFront()
if open == false then
    open = true
    SetVehicleDoorOpen(veh, 2, false, false)
    Citizen.Wait(1000)
    SetVehicleDoorOpen(veh, 3, false, false)
elseif open == true then
    open = false
    SetVehicleDoorShut(veh, 2, false)
    SetVehicleDoorShut(veh, 3, false)
end
end)

local incar = false
RegisterNetEvent("ARPF-EMS:togglestrincar")
AddEventHandler("ARPF-EMS:togglestrincar", function()
	
	local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if IsEntityAttachedToAnyVehicle(closestObject) then
    	incar = true
    elseif IsEntityAttachedToEntity(closestObject, veh) then 
    	incar = true
    end
    if incar == false then 
        StreachertoCar()
        incar = true
    elseif incar == true then
        incar = false
        StretcheroutCar()
    end
end)



function StreachertoCar()
    local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            AttachEntityToEntity(closestObject, veh, 0.0, 0.0, -3.7, 0.0, 0.0, 0.0, 90.0, false, false, true, false, 2, true)
            FreezeEntityPosition(closestObject, true)
        else
            print("car dose not exist ")
        end
    else
        print("nothing around here dumb ass")
    end
end

function StretcheroutCar()
    local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            DetachEntity(closestObject, true, true)
            FreezeEntityPosition(closestObject, false)
            local coords = GetEntityCoords(closestObject, false)
        SetEntityCoords(closestObject, coords.x-3,coords.y,coords.z)
        PlaceObjectOnGroundProperly(closestObject)
        else
            print("dosenot exist car")
        end
    else
        print("nothing around here dumb ass")
    end
end
-----------------------------------------------------------------------------------------------------------------------
--[[
test sync to server 
attchedStr = {}

if then 
	table.insert('attchedStr',['obj'] = closestObject, ['to'] = veh)
end 
TriggerServerEvent('stretcher:table:update',attchedStr)

ARPF-EMS:stretcherSync
ARPF-EMS:server:stretcherSync

strTable
]]

RegisterCommand('spawnstr', function() 
    LoadModel('prop_ld_binbag_01')
    local str = CreateObject(GetHashKey('prop_ld_binbag_01'), GetEntityCoords(PlayerPedId()), true)
end, false)

RegisterCommand('delStr', function(source, args)
	local object = GetHashKey('prop_ld_binbag_01')
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 2.5, object, true) then
        local obj = GetClosestObjectOfType(x, y, z, 2.5, object, false, false, false)
        for q,d in ipairs(strTable) do
        	if d['obj'] == obj then
        		local attachedToWhat = GetEntityAttachedTo(obj) and not nil or "none" 
        		DeleteObject(obj)
        		TriggerServerEvent("ARPF-EMS:server:stretcherSync",3,q,attachedToWhat,false)
        	end
        end
    end

end, false)


RegisterNetEvent("ARPF-EMS:stretcherSync")
AddEventHandler("ARPF-EMS:stretcherSync", function(tableUpdate)
	strTable = tableUpdate
end)

local changed = false
Citizen.CreateThreadNow(function()
	while true do 
		Citizen.Wait(10)
		TableID = 0 
		local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local closestObject = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_ld_binbag_01"), false)
        if DoesEntityExist(closestObject) then
            local strCoords = GetEntityCoords(closestObject)
            for i,v in ipairs(strTable) do
			 	local strobj = v['obj']
				if strobj == closestObject then
					TableID = i 
				elseif strobj ~= closestObject and TableID <= 0 then 
					TableID = -1 -- this means that the new stretcher is not in the table and after checking all of the stretches it will then add the new one to the table and then send it to the server to then update all the clients on the server
					print("not the right stretcher")
				end  
			end
			if TableID == -1 then -- add to server table 
				local attachedToWhat = GetEntityAttachedTo(closestObject) and not nil or "none" 
				local state = 2
				local tableNum = -1
				local what = attachedToWhat
				local sync = false
				TriggerServerEvent("ARPF-EMS:server:stretcherSync",state,tableNum,what,sync)
			elseif TableID > 0 then -- check if the stretcher has a changed state
			end 

			for k,u in pairs(strTable) do
        		local strobj = strTable[k]['obj']
        		--local strobj = u['obj'] -- one of these are faster 
        		if DoesEntityExist(strobj) then
        		 	local pedCoords = GetEntityCoords(ped)
					local strCoords = GetEntityCoords(closestObject)
					local distances = GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, strCoords.x, strCoords.y, strCoords.z, true)
        			local attachedToWhat = GetEntityAttachedTo(strobj) and not nil or "none"
			        if 	distances < 5 then 
			        	if IsEntityAttachedToAnyPed(strobj) or IsEntityAttachedToAnyVehicle(strobj) or IsEntityAttachedToAnyObject(strobj) then 
							if attachedToWhat ~= v['to'] then -- even if somehow v['to'] == nil then it will change to "none"
								v['to'] = attachedToWhat
								local changed = true
							end
						else
							if attachedToWhat == v['to'] then 
								local change = false
							else 
								print(attachedToWhat)
								print("this fucked up if it gets here and nothing is shown")
							end
						end
					end
	        	else
	        	-- insert deleting into the deleting command TriggerServerEvent("ARPF-EMS:server:stretcherSync",state,tableNum,what,sync)	
	        	end
        	end  
        end
	end
end)
		
--[[if IsEntityAttachedToAnyPed(strobj) then 
	newWhat = GetEntityAttachedTo(strobj)
	if newWhat ~= v['to'] then 
		v['to'] = newWhat
		local changed = true
	end
elseif IsEntityAttachedToAnyVehicle(strobj) then
	newWhat = GetEntityAttachedTo(strobj)
	if newWhat ~= v['to'] then 
		v['to'] = newWhat
		local changed = true
	end
elseif IsEntityAttachedToAnyObject(strobj) then 
	newWhat = GetEntityAttachedTo(strobj)
	if newWhat ~= v['to'] then 
		v['to'] = newWhat
		local changed = true
	end
else
	if GetEntityAttachedTo(strobj) == nil or GetEntityAttachedTo(strobj) == v['to'] then 
		local change = false 
	end
end]]

RegisterNetEvent("ARPF-EMS:pushstreacherss")
AddEventHandler("ARPF-EMS:pushstreacherss", function()
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
        if DoesEntityExist(closestObject) then
            local strCoords = GetEntityCoords(closestObject)
            local strVecForward = GetEntityForwardVector(closestObject)
            local sitCoords = (strCoords + strVecForward * - 0.5)
            local pickupCoords = (strCoords + strVecForward * 0.3)
            if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 2.0 then
                PickUp(closestObject)
            end
        end 
end)


RegisterNetEvent("ARPF-EMS:getintostretcher")
AddEventHandler("ARPF-EMS:getintostretcher", function()
 local pP = GetPlayerPed(-1)
 local ped = PlayerPedId()
 local pedCoords = GetEntityCoords(ped)
 local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
     local strCoords = GetEntityCoords(closestObject)
     local strVecForward = GetEntityForwardVector(closestObject)
     local sitCoords = (strCoords + strVecForward * - 0.5)
     local pickupCoords = (strCoords + strVecForward * 0.3)
        if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 then
            TriggerEvent('sit', closestObject) 
        end
    end
end)


function revivePed(ped)
  local playerPos = GetEntityCoords(ped, true)

  NetworkResurrectLocalPlayer(playerPos, true, true, false)
  SetPlayerInvincible(ped, false)
  ClearPedBloodDamage(ped)
end

-- Anim Taken from bed script from FFourms
local inBedDicts = "anim@gangops@morgue@table@"
local inBedAnims = "ko_front"
RegisterNetEvent('sit')
AddEventHandler('sit', function(strObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()
    local playPed = GetPlayerPed(-1)
    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), inBedDicts, inBedAnims, 3) then
            ShowNotification("Somebody is already using the Stretcher!")
            return
        end
    end

    LoadAnim(inBedDicts)
  if IsPedDeadOrDying(playPed) then
    revivePed(playPed)
    AttachEntityToEntity(PlayerPedId(), strObject, 0, 0, 0.0, 2.1, 0.0, 0.0, 270.0, 0.0, false, false, false, false, 2, true)
    local heading = GetEntityHeading(strObject)
    wasdead = true
    while IsEntityAttachedToEntity(PlayerPedId(), strObject) do
        Citizen.Wait(5)

        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(PlayerPedId(), true, true)
        end

        if not IsEntityPlayingAnim(PlayerPedId(), inBedDicts, inBedAnims, 3) then
            TaskPlayAnim(PlayerPedId(), inBedDicts, inBedAnims, 8.0, 8.0, -1, 69, 1, false, false, false)
        end

        if IsControlPressed(0, 32) then
            PlaceObjectOnGroundProperly(strObject)
        end
        if IsControlJustPressed(0, 73) then
            TriggerEvent("unsit", strObject)
        end
    end 
  elseif not IsPedDeadOrDying(playPed) then
    AttachEntityToEntity(PlayerPedId(), strObject, 0, 0, 0.0, 2.1, 0.0, 0.0, 270.0, 0.0, false, false, false, false, 2, true)
    local heading = GetEntityHeading(strObject)
    wasdead = false
    while IsEntityAttachedToEntity(PlayerPedId(), strObject) do
        Citizen.Wait(5)

        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(PlayerPedId(), true, true)
        end

        if not IsEntityPlayingAnim(PlayerPedId(), inBedDicts, inBedAnims, 3) then
            TaskPlayAnim(PlayerPedId(), inBedDicts, inBedAnims, 8.0, 8.0, -1, 69, 1, false, false, false)
        end

        if IsControlPressed(0, 32) then
            PlaceObjectOnGroundProperly(strObject)
        elseif IsControlJustPressed(0, 73) then
          TriggerEvent("unsit", strObject)
        end
    end 
  end      
end)


RegisterNetEvent('unsit')
AddEventHandler('unsit', function(strObject)   
    if wasdead == true then
        pedss = GetPlayerPed(-1)
        DetachEntity(PlayerPedId(), true, true)
        local x, y, z = table.unpack(GetEntityCoords(strObject) + GetEntityForwardVector(strObject) * - 0.7)
        SetEntityCoords(PlayerPedId(), x,y,z)
        hels = GetEntityHealth(pedss)
        SetEntityHealth(pedss, hels -200)
        wasdead = false
    elseif wasdead == false then
        DetachEntity(PlayerPedId(), true, true)
        local x, y, z = table.unpack(GetEntityCoords(strObject) + GetEntityForwardVector(strObject) * - 0.7)
        SetEntityCoords(PlayerPedId(), x,y,z)
    end
end)

-------------------------------- FUNCTIONS ----------------------------------------------------------------------------

function PickUp(strObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
            ShowNotification("Somebody is already pushing the Stretcher!")
            return
        end
    end

    NetworkRequestControlOfEntity(strObject)
    --[[

    # naitives to be used 
    SlideObject(object, toX, toY, toZ, speedX, speedY, speedZ, collision)
    AttachEntityToEntity(PlayerPedId(), strObject, GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.6, -1.43, 180.0, 170.0, 90.0, 0.0, false, false, true, false, 2, true) 
    AttachEntityToEntity(entity1, entity2, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, vertexIndex, fixedRot)
   	ApplyForceToEntity(entity, forceFlags, x, y, z, offX, offY, offZ, boneIndex, isDirectionRel, ignoreUpVec, isForceRel, p12, p13)
    SetObjectPhysicsParams(object, weight, p2, p3, p4, p5, gravity, p7, p8, p9, p10, buoyancy)
    ActivatePhysics(entity)
    GetEntityPhysicsHeading(entity)
    DoesEntityHavePhysics(entity)
    AttachEntityToEntityPhysically(entity1, entity2, boneIndex1, boneIndex2, xPos1, yPos1, zPos1, xPos2, yPos2, zPos2, xRot, yRot, zRot, breakForce, fixedRot, p15, collision, teleport, p18)
    SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(object, toggle)
    ]]

    LoadAnim("anim@heists@box_carry@")
    local pedid = PlayerPedId()
    AttachEntityToEntity(strObject, pedid, GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.6, -1.43, 180.0, 170.0, 90.0, 0.0, false, false, true, false, 2, true)
    while IsEntityAttachedToEntity(strObject, pedid) do
        Citizen.Wait(5)

        if not IsEntityPlayingAnim(pedid, 'anim@heists@box_carry@', 'idle', 3) then
            TaskPlayAnim(pedid, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
        end

        if IsPedDeadOrDying(pedid) or IsControlJustPressed(0, 73) then
            DetachEntity(strObject, true, true)
        end
    end
end

function DrawText3Ds(coords, text, scale)
    local x,y,z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 370

    DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 41, 11, 41, 100)
end

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        
        Citizen.Wait(1)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        
        Citizen.Wait(1)
    end
end

function ShowNotification(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringWebsite(msg)
    DrawNotification(false, true)
end

