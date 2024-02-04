name "mustache-CarBoost"
author "mustache_dom"
description "CarBoost by mustache dom"
fx_version "cerulean"
game "gta5"

client_scripts {
	'client/**.lua',
	'@PolyZone/client.lua',
   	 '@PolyZone/CircleZone.lua',
   	 '@PolyZone/EntityZone.lua',
}

server_scripts {
    'server/**.lua',
	'@oxmysql/lib/MySQL.lua',
	
}

shared_scripts {
    'config.lua',
	'@ox_lib/init.lua',
	
}


lua54 'yes'


