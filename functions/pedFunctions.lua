function givePedRandomWeapon()
	randomWeapon = GetHashKey(weaponNames[math.random(#weaponNames)])
	for ped in EnumeratePeds() do
		GiveWeaponToPed(ped, randomWeapon, 250, false, false)
		if ped ~= PlayerPedId() then
			SetCurrentPedWeapon(ped, randomWeapon, true)
		end
	end
end

function setRandomPedModel()
	pedModel = GetHashKey(pedModels[math.random(#pedModels)])
	RequestModel(pedModel)
	while not HasModelLoaded(pedModel) do
		Citizen.Wait(0)
	end
	SetPlayerModel(PlayerId(), pedModel)
	SetPedRandomComponentVariation(PlayerPedId(), true)
	SetModelAsNoLongerNeeded(pedModel)
end

function allPedsAreCops()
	count = 0
	while count < Lave.effectTime / 10 do
		for ped in EnumeratePeds() do
			if ped ~= PlayerPedId() then
				SetPedAsCop(ped, true)
			else
				SetPlayerWantedLevel(PlayerId(), 1, false)
				SetPlayerWantedLevelNow(PlayerId(), false)
			end
		end
		count = count + 1
	end
end

function pedsStopAndStare()
	for ped in EnumeratePeds() do
		if IsPedInAnyVehicle(ped, true) then
			pedVeh = GetVehiclePedIsIn(ped, true)
			TaskLeaveVehicle(ped, pedVeh, 256)
			BringVehicleToHalt(pedVeh, 0.1, 10, 0)
		end
		if ped ~= PlayerPedId() then
			TaskTurnPedToFaceEntity(ped, PlayerPedId(), -1)
			TaskLookAtEntity(ped, PlayerPedId(), -1, 2048, 3)
		end
	end
end

function forceMoveForward()
	count = 0
	while count < Lave.effectTime / 10 do
		SimulatePlayerInputGait(PlayerId(), 5.0, 100, 1.0, true, false)
		SetControlNormal(0, 32, 1)
		SetControlNormal(0, 71, 1)
		SetControlNormal(0, 77, 1)
		SetControlNormal(0, 87, 1)
		SetControlNormal(0, 129, 1)
		SetControlNormal(0, 136, 1)
		SetControlNormal(0, 150, 1)
		SetControlNormal(0, 232, 1)
		SetControlNormal(0, 280, 1)

		DisableControlAction(0, 72, true)
		DisableControlAction(0, 76, true)
		DisableControlAction(0, 88, true)
		DisableControlAction(0, 138, true)
		DisableControlAction(0, 139, true)
		DisableControlAction(0, 152, true)
		DisableControlAction(0, 153, true)

		DisableControlAction(0, 25, true)
		DisableControlAction(0, 44, true)
		DisableControlAction(0, 50, true)
		DisableControlAction(0, 68, true)
		Wait(0)
		count = count + 1
	end
end

function onlyLRMovement()
	count = 0
	while count < Lave.effectTime / 10 do
		DisableControlAction(0, 8, true)
		DisableControlAction(0, 31, true)
		DisableControlAction(0, 32, true)
		DisableControlAction(0, 33, true)
		DisableControlAction(0, 71, true)
		DisableControlAction(0, 72, true)
		DisableControlAction(0, 87, true)
		DisableControlAction(0, 88, true)
		DisableControlAction(0, 126, true)
		DisableControlAction(0, 127, true)
		DisableControlAction(0, 128, true)
		DisableControlAction(0, 129, true)
		DisableControlAction(0, 130, true)
		DisableControlAction(0, 136, true)
		DisableControlAction(0, 137, true)
		DisableControlAction(0, 149, true)
		DisableControlAction(0, 150, true)
		DisableControlAction(0, 151, true)
		DisableControlAction(0, 280, true)
		DisableControlAction(0, 281, true)
		Wait(0)
		count = count + 1
	end
end

function onlyFBMovement()
	count = 0
	while count < Lave.effectTime / 10 do
		DisableControlAction(0, 9, true)
		DisableControlAction(0, 30, true)
		DisableControlAction(0, 34, true)
		DisableControlAction(0, 35, true)
		DisableControlAction(0, 59, true)
		DisableControlAction(0, 63, true)
		DisableControlAction(0, 64, true)
		DisableControlAction(0, 89, true)
		DisableControlAction(0, 90, true)
		DisableControlAction(0, 123, true)
		DisableControlAction(0, 124, true)
		DisableControlAction(0, 125, true)
		DisableControlAction(0, 133, true)
		DisableControlAction(0, 134, true)
		DisableControlAction(0, 146, true)
		DisableControlAction(0, 147, true)
		DisableControlAction(0, 148, true)
		DisableControlAction(0, 152, true)
		DisableControlAction(0, 153, true)
		DisableControlAction(0, 278, true)
		DisableControlAction(0, 279, true)
		Wait(0)
		count = count + 1
	end
end

function playerSuicide()
	if not IsPedInAnyVehicle(PlayerPedId(), false) and IsPedOnFoot(PlayerPedId()) and GetPedParachuteState(PlayerPedId()) == -1 then
		RequestAnimDict('mp_suicide')
		while not HasAnimDictLoaded('mp_suicide') do
			Wait(0)
		end
		GiveWeaponToPed(PlayerPedId(), GetHashKey('WEAPON_PISTOL'), 9999, true, true)
		TaskPlayAnim(PlayerPedId(), 'mp_suicide', 'pistol', 8.0, -1.0, 800.0, 1, 0.0, false, false, false)
		Wait(750)
		SetPedShootsAtCoord(PlayerPedId(), 0, 0, 0, true)
		RemoveAnimDict('mp_suicide')
	end
	SetEntityHealth(PlayerPedId(), 0, 0)
end

function playerExplosiveAim()
	count = 0
	while count < Lave.effectTime / 10 do
		StopGameplayCamShaking(true)
		target = nil
		retval, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
		if retval then
			if IsEntityAPed(target) or IsEntityAVehicle(target) and not IsEntityDead(target, false) then
				pos = GetEntityCoords(target, false)
				SetEntityHealth(target, 0, 0)
				SetEntityInvincible(target, false)
				AddExplosion(pos.x, pos.y, pos.z, 9, 100.0, true, false, 3.0, false)
			end
		end
		count = count + 1
		Wait(0)
	end
end

function teleportAllPedsToPlayer()
	for ped in EnumeratePeds() do
		if ped ~= PlayerPedId() then
			SetEntityCoords(ped, GetEntityCoords(PlayerPedId()), false, false, false, false)
		end
	end
end

function zombieApocalypse()
	for ped in EnumeratePeds() do
		if ped ~= PlayerPedId() then
			coords = GetEntityCoords(ped)
			DeleteEntity(ped)
			RequestModel(GetHashKey('u_m_y_zombie_01'))
			while not HasModelLoaded(GetHashKey('u_m_y_zombie_01')) do
				Wait(0)
			end
			zombie = CreatePed(26, GetHashKey('u_m_y_zombie_01'), coords, 0, true, false)
			SetPedRelationshipGroupHash(zombie, GetHashKey('_ZOMBIES'))
			TaskCombatPed(zombie, PlayerPedId(), 0, 16)
			SetModelAsNoLongerNeeded(GetHashKey('u_m_y_zombie_01'))
		end
	end
end

function playerIsObjMagnet()
	pCoords = GetEntityCoords(PlayerPedId())
	for obj in EnumerateObjects() do
		SetEntityCoords(obj, pCoords, false, false, false, false)
	end
	Wait(Lave.effectTime)
	SetEntityCoords(PlayerPedId(), pCoords.x + 5, pCoords.y + 5, pCoords.z, false, false, false, false)
end

function teleportPlayerToNorthYankton()
	pCoords = GetEntityCoords(PlayerPedId())
	SetEntityCoords(PlayerPedId(), 3217.697, -4834.826, 111.8152, false, false, false, false)
	Wait(Lave.effectTime)
	SetEntityCoords(PlayerPedId(), pCoords, false, false, false, false)
end

function rainbowWeapons()
	count = 0
	while count < Lave.effectTime / 1000 do
		retval, weapon = GetCurrentPedWeapon(PlayerPedId(), false)
		SetPedWeaponTintIndex(PlayerPedId(), weapon, math.random(1, 7))
		count = count + 1
		Wait(100)
	end
end

function randomizePlayerOutfit()
	SetPedRandomComponentVariation(PlayerPedId(), false)
end

function setNearbyPedsOnFire()
	for ped in EnumeratePeds() do
		StartEntityFire(ped)
	end
end