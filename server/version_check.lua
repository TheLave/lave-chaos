PerformHttpRequest("https://thelave.github.io/lave-chaos/version.txt", function(err, text, headers)
	Citizen.Wait(2000)
	local curVer = GetResourceMetadata(GetCurrentResourceName(), "version")
	if (text ~= nil) then
		if (string.find(text, curVer)) then
			print("\n^6The lave-chaos script is ^2up to date!\n^6Have fun!")
		else
			print("\n^6The lave-chaos script is ^1outdated!\n^6Please update to the latest version for new features and bug fixes!")
		end
	end
end)