## md-carboost


<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img align="center" src="https://cdn.discordapp.com/attachments/1164709522691076120/1185676859363557457/Discord_logo.svg.png?ex=65907aa0&is=657e05a0&hm=dd2a8924c3a3d84507747ab2bac036e5fc219c697e084c9aa13ba468ff725bde&" width="100">
  </a><br>
  <a href="https://discord.gg/sAMzrB4DDx">Mustache Scripts Discord</a><br>
</div>


## **Features: Car Heists & VinScratching**

**Car Heists:**
- **Objective:** Spawn at specified location, purchase a laptop for 10k, and start as Class D.
- **Actions:**
  1. Reach locations, boost cars.
  2. Deliver the boosted car to a drop-off.
  3. Strip doors, hood, and trunk for additional rewards.
  4. Destroy the vehicle for money and reputation.

**Additional Features for Classes B-A:**
- Lockpicking is replaced with engaging minigames via third eye.
- Chance for the car's owner to spawn with a pistol.
- Potential threat: 2 hostile peds on a faggio may chase and attack.

**VinScratching:**
- **Procedure:**
  1. Similar to Car Heists but with unique elements.
  2. Owner always spawns.
  3. 2 hostile peds on faggios consistently appear.
  4. While driving, encounter another 2 hostile peds on faggios.
  5. Arrive at the location, sit in your car, and wait for the VinScratching process to commence.

## Dependencies :

- [ox_lib](https://github.com/overextended/ox_lib/releases)

- [ox_target](https://github.com/overextended/ox_target/releases)

- [qb-core](https://github.com/qbcore-framework/qb-core)

- [ps-ui](https://github.com/Project-Sloth/ps-ui)

- [ps-dispatch](https://github.com/Project-Sloth/ps-dispatch/releases)


## Setup :

- Add the following to `qb-core/server/player.lua` inside your existing playerdata

```lua
PlayerData.metadata['carboosting'] = PlayerData.metadata['carboosting'] or 0
```

![](https://cdn.discordapp.com/attachments/1164709522691076120/1185672430895759482/image.png?ex=65907680&is=657e0180&hm=967eeeb9c0ac9d108b37eb48ebe2377f17f18d575205531773059c34fea3ccfc&)


- Add the following Items to `qb-core/shared/items.lua`

```lua
["car_door"] 					 	 = {["name"] = "car_door", 			  	  		["label"] = "car door", 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "car_door.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false, ["combinable"] = nil,   ["description"] = ""},
["car_hood"] 					 	 = {["name"] = "car_hood", 			  	  		["label"] = "car_hood", 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "car_hood.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false, ["combinable"] = nil,   ["description"] = ""},
["car_trunk"] 					 	 = {["name"] = "car_trunk", 			  	  	["label"] = "car_trunk", 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "car_trunk.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false, ["combinable"] = nil,   ["description"] = ""},
["mdlaptop"] 					 	 = {["name"] = "mdlaptop", 			  	  	    ["label"] = "Car Boost Laptop",     ["weight"] = 2000, 		["type"] = "item", 		["image"] = "mansionlaptop.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false, ["combinable"] = nil,   ["description"] = ""},
```
![](https://cdn.discordapp.com/attachments/1164709522691076120/1185674178762920086/image.png?ex=65907820&is=657e0320&hm=4097894e5037bff88ebe91bb804236a0b1a62ac73a110b4576e01ac97dec441c&)

- Add items images to `qb-inventory/html/images`



- Modify `md-carboost/config.lua` to your liking and enjoy
