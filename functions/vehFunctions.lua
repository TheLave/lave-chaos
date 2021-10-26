function givePlayerRandomVehicle()
	currVeh = GetVehiclePedIsIn(PlayerPedId())
	isEngineOn = GetIsVehicleEngineRunning(currVeh)
	vehSpeed = GetEntityVelocity(currVeh)
	vehForwardSpeed = GetEntitySpeed(currVeh)
	if not IsEntityAMissionEntity(currVeh) then
		SetEntityAsMissionEntity(currVeh)
	end
	DeleteVehicle(currVeh)
	ranVeh = math.random(#vehModels)
	selectedVeh = GetHashKey(vehModels[ranVeh])
	RequestModel(selectedVeh)
	while not HasModelLoaded(selectedVeh) do
		Wait(0)
	end
	vehicle = CreateVehicle(selectedVeh, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
	SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
	if isEngineOn then
		SetVehicleEngineOn(vehicle, true, true, false)
	end
	SetEntityVelocity(vehicle, vehSpeed)
	SetVehicleForwardSpeed(vehicle, vehForwardSpeed)
	SetModelAsNoLongerNeeded(selectedVeh)
end

function spawnRandomVehicle()
	selectedVeh = GetHashKey(vehModels[math.random(#vehModels)])
	RequestModel(selectedVeh)
	while not HasModelLoaded(selectedVeh) do
		Wait(0)
	end
	vehicle = CreateVehicle(selectedVeh, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
	SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
end

function deletePlayerVehicle()
	currVeh = GetVehiclePedIsIn(PlayerPedId())
	if not IsEntityAMissionEntity(currVeh) then
		SetEntityAsMissionEntity(currVeh)
	end
	DeleteVehicle(currVeh)
end

function vehicle30MphLimit()
	for veh in EnumerateVehicles() do
		SetVehicleMaxSpeed(veh, 13.41)
	end
	Wait(Lave.effectTime)
	for veh in EnumerateVehicles() do
		SetVehicleMaxSpeed(veh, GetVehicleModelMaxSpeed(GetEntityModel(veh)))
	end
end

function launchAllVehiclesUp()
	for veh in EnumerateVehicles() do
		vel = GetEntityVelocity(veh)
		SetEntityVelocity(veh, vel.x, vel.y, 100.0)
	end
end

function breakVehicleDoors()
	currVeh = GetVehiclePedIsIn(PlayerPedId())
	for i = 0, 5 do
		SetVehicleDoorBroken(currVeh, i, false)
	end
end

function vehicleCinematicCamera()
	count = 0
	while count < Lave.effectTime / 10 do
		SetPlayerCanDoDriveBy(PlayerPedId(), false)
		SetCinematicModeActive(true)
		DisableControlAction(0, 80, true)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			DisableControlAction(0, 27, true)
			DisableControlAction(0, 0, true)
		end
		count = count + 1
		Wait(0)
	end
	SetCinematicModeActive(false)
	SetPlayerCanDoDriveBy(PlayerPedId(), true)
end

function invisibleVehicle()
	currVeh = GetVehiclePedIsIn(PlayerPedId())
	SetEntityAlpha(currVeh, 0, 0)
	Wait(Lave.effectTime)
	ResetEntityAlpha(currVeh)
end

function popVehicleTires()
	count = 0
	while count < Lave.effectTime / 10 do
		for veh in EnumerateVehicles() do
			for i = 0, 47 do
				SetVehicleTyresCanBurst(veh, true)
				SetVehicleTyreBurst(veh, i, true, 1000.0)
				SetVehicleTyreFixed(veh, i)
			end
		end
		count = count + 1
		Wait(0)
	end
end

function startVehicleAlarms()
	for veh in EnumerateVehicles() do
		SetVehicleAlarm(veh, true)
		StartVehicleAlarm(veh)
	end
	Wait(Lave.effectTime)
	for veh in EnumerateVehicles() do
		SetVehicleAlarm(veh, false)
	end
end

function vehiclesTurnRight()
	for ped in EnumeratePeds() do
		if IsPedInAnyVehicle(ped, false) then
			veh = GetVehiclePedIsIn(ped, false)
			TaskVehicleTempAction(ped, veh, 8, Lave.effectTime)
		end
	end
end

function randomVehicleColors()
	currVeh = GetVehiclePedIsIn(PlayerPedId())
	count = 0

	while count < Lave.effectTime / 10 do
		SetVehicleColours(currVeh, math.random(159), math.random(159))
		count = count + 1
		Wait(0)
	end
end

function rainbowVehicleColor()
	currVeh = GetVehiclePedIsIn(PlayerPedId())
	count = 0
	while count < Lave.effectTime / 10 do
		local curtime = GetGameTimer() / 1000
		local frequency = 5.5
		r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
		g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
		b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
		SetVehicleCustomPrimaryColour(currVeh, r, g, b)
		SetVehicleCustomSecondaryColour(currVeh, r, g, b)
		count = count + 1
		Wait(0)
	end
end

function jesusTakeTheWheel()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		RequestModel(GetHashKey('u_m_m_jesus_01'))
		while not HasModelLoaded(GetHashKey('u_m_m_jesus_01')) do
			Wait(0)
		end
		retval, relationshipGroup = AddRelationshipGroup('_WHEEL_JESUS')
		SetRelationshipBetweenGroups(0, relationshipGroup, GetHashKey('PLAYER'))
		currVeh = GetVehiclePedIsIn(PlayerPedId(), false)
		SetPedIntoVehicle(PlayerPedId(), currVeh, -2)
		jesus = CreatePedInsideVehicle(currVeh, 4, GetHashKey('u_m_m_jesus_01'), -1, true, false)
		SetPedRelationshipGroupHash(jesus, relationshipGroup)
		SetEntityProofs(jesus, true, false, false, false, false, false, false, false)
		TaskVehicleDriveWander(jesus, currVeh, 9999.0, 4176732)
		SetPedKeepTask(jesus, true)
		SetBlockingOfNonTemporaryEvents(jesus, true)
		SetModelAsNoLongerNeeded(GetHashKey('u_m_m_jesus_01'))
	end
end

function flatTires()
	currVeh = GetVehiclePedIsIn(PlayerPedId())
	SetVehicleTyresCanBurst(currVeh, true)
	for i= 0, 7 do
		SetVehicleTyreBurst(currVeh, i, true, 1000.0)
	end
end

function eastSideTraffic()
	count = 0
	while count < Lave.effectTime / 10 do
		for veh in EnumerateVehicles() do
			SetVehicleColours(veh, 145, 145)
		end
		count = count + 1
		Wait(0)
	end
end

function darkModeTraffic()
	count = 0
	while count < Lave.effectTime / 10 do
		for veh in EnumerateVehicles() do
			SetVehicleColours(veh, 12, 12)
		end
		count = count + 1
		Wait(0)
	end
end

function lightModeTraffic()
	count = 0
	while count < Lave.effectTime / 10 do
		for veh in EnumerateVehicles() do
			SetVehicleColours(veh, 134, 134)
		end
		count = count + 1
		Wait(0)
	end
end