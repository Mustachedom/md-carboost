how to install
For Support go to 

https://discord.gg/sAMzrB4DDx

REQUIREMENTS
1)ox_lib
2)ox_target
3)qbcore
4)ps-ui
5)ps-dispatch

1) go to qb-core -> server folder -> player.lua

Place this 
```
PlayerData.metadata['carboosting'] = PlayerData.metadata['carboosting'] or 0
```

under neath

```
PlayerData.metadata['dealerrep'] = PlayerData.metadata['dealerrep'] or 0
```

save

2) add these items

```
["car_door"] 					 	 = {["name"] = "car_door", 			  	  		["label"] = "car door", 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "car_door.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false, ["combinable"] = nil,   ["description"] = ""},
["car_hood"] 					 	 = {["name"] = "car_hood", 			  	  		["label"] = "car_hood", 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "car_hood.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false, ["combinable"] = nil,   ["description"] = ""},
["car_trunk"] 					 	 = {["name"] = "car_trunk", 			  	  	["label"] = "car_trunk", 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "car_trunk.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false, ["combinable"] = nil,   ["description"] = ""},
["mdlaptop"] 					 	 = {["name"] = "mdlaptop", 			  	  	["label"] = "Car Boost Laptop", 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "mansionlaptop.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false, ["combinable"] = nil,   ["description"] = ""},

```

3) add images

4) fill out the config.

5) enjoy
