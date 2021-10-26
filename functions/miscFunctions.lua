function speed02()
	SetTimeScale(0.2)
	Wait(Lave.effectTime * 0.2)
	SetTimeScale(1.0)
end

function speed04()
	SetTimeScale(0.4)
	Wait(Lave.effectTime * 0.4)
	SetTimeScale(1.0)
end

function speed06()
	SetTimeScale(0.6)
	Wait(Lave.effectTime * 0.6)
	SetTimeScale(1.0)
end

function blackout()
	SetArtificialLightsState(true)
	Wait(Lave.effectTime)
	SetArtificialLightsState(false)
end

function ufoDeathRayVision()
	if GetTimecycleModifierIndex() == -1 and GetTimecycleTransitionModifierIndex() == -1 then
		SetTransitionTimecycleModifier('ufo_deathray', 1.5)
	end
	Wait(Lave.effectTime)
	ClearTimecycleModifier()
end

function tacoShower()
	count = 0
	RequestModel(GetHashKey('prop_taco_01'))
	while not HasModelLoaded(GetHashKey('prop_taco_01')) do
		Wait(0)
	end
	while count < Lave.effectTime / 10 do
		pCoords = GetEntityCoords(PlayerPedId())
		taco = CreateObject(GetHashKey('prop_taco_01'), pCoords.x + math.random(-10, 10), pCoords.y + math.random(-10, 10), pCoords.z + math.random(5, 15), true, false, true)
		SetObjectPhysicsParams(taco, 100.0, 1.0, 1.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0)
		ApplyForceToEntityCenterOfMass(taco, 0, 50.0, 0, -10000.0, true, false, true, true)
		count = count + 1
		Wait(0)
	end
	SetModelAsNoLongerNeeded(GetHashKey('prop_taco_01'))
	for obj in EnumerateObjects() do
		if GetEntityModel(obj) == GetHashKey('prop_taco_01') then
			DeleteObject(obj)
		end
	end
end