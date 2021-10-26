fx_version 'cerulean'
game 'gta5'

name "Lave's Chaos mod FiveM"
description "GTA V Chaos mod ported to FiveM"
author "Lave#0012"
version '0.1.0'

server_scripts {
	'server/server.lua',
	'server/version_check.lua'
}

client_scripts {
	'@warmenu/warmenu.lua',
	'client/client.lua',
	'functions/vehFunctions.lua',
	'functions/pedFunctions.lua',
	'functions/miscFunctions.lua',
	'functions/entityiter.lua',
	'data/vehData.lua',
	'data/weaponData.lua',
	'data/pedData.lua'
}

shared_script 'lave.lua'