local menuStyle = {titleColor = {255,255,255}, titleBackgroundColor = {40,53,147}, subTitleColor = {255, 255, 255}}
local vehFunctions = {'givePlayerRandomVehicle', 'spawnRandomVehicle', 'deletePlayerVehicle', 'vehicle30MphLimit', 'launchAllVehiclesUp', 'breakVehicleDoors', 'vehicleCinematicCamera', 'invisibleVehicle', 'popVehicleTires', 'startVehicleAlarms', 'vehiclesTurnRight', 'randomVehicleColors', 'rainbowVehicleColor', 'jesusTakeTheWheel', 'flatTires', 'eastSideTraffic', 'darkModeTraffic', 'lightModeTraffic'}
local pedFunctions = {'givePedRandomWeapon', 'setRandomPedModel', 'allPedsAreCops', 'pedsStopAndStare', 'forceMoveForward', 'onlyLRMovement', 'onlyFBMovement', 'playerSuicide', 'playerExplosiveAim', 'teleportAllPedsToPlayer', 'zombieApocalypse', 'playerIsObjMagnet', 'teleportPlayerToNorthYankton', 'rainbowWeapons', 'randomizePlayerOutfit', 'setNearbyPedsOnFire'}
local miscFunctions = {'speed02', 'speed04', 'speed06', 'blackout', 'ufoDeathRayVision', 'tacoShower'}

Citizen.CreateThread(function()
	WarMenu.CreateMenu('Chaos', 'Chaos', 'Chaos Test Menu', menuStyle)
	WarMenu.SetMenuTitle('FiveM Chaos Mod')
	WarMenu.CreateSubMenu('pedFunctions', 'Chaos', 'Ped Functions', menuStyle)
	WarMenu.CreateSubMenu('vehFunctions', 'Chaos', 'Vehicle Functions', menuStyle)
	WarMenu.CreateSubMenu('miscFunctions', 'Chaos', 'Misc. Functions', menuStyle)
	WarMenu.CreateSubMenu('closeMenu', 'Chaos', nil, menuStyle)

	while true do
		if WarMenu.IsMenuOpened('Chaos') then
			if WarMenu.MenuButton('Ped Functions', 'pedFunctions') then
			elseif WarMenu.MenuButton('Vehicle Functions', 'vehFunctions') then
			elseif WarMenu.MenuButton('Misc. Functions', 'miscFunctions') then
			elseif WarMenu.MenuButton('Exit', 'closeMenu') then
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('pedFunctions') then
			for k,v in pairs(pedFunctions) do
				if WarMenu.Button(v) then
					_G[v]()
				end
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('vehFunctions') then
			for k,v in pairs(vehFunctions) do
				if WarMenu.Button(v) then
					_G[v]()
				end
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('miscFunctions') then
			for k,v in pairs(miscFunctions) do
				if WarMenu.Button(v) then
					_G[v]()
				end
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('closeMenu') then
			WarMenu.CloseMenu()
		elseif IsDisabledControlJustReleased(0, 11) then
			WarMenu.OpenMenu('Chaos')
		end
		Citizen.Wait(0)
	end
end)