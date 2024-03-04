
--[[ Spawn Template, defaults to values shown if line not provided

mob_spawn({

	name = "",

		- Name of mob, must be provided e.g. "mymod:my_mob"

	nodes = {"group:soil, "group:stone"},

		- Nodes to spawn on top of.

	neighbors = {"air"},

		- Nodes to spawn beside.

	min_light = 0,

		- Minimum light level.

	max_light = 15,

		- Maximum light level, 15 is sunlight only.

	interval = 30,

		- Spawn interval in seconds.

	chance = 5000,

		- Spawn chance, 1 in every 5000 nodes.

	active_object_count = 1,

		- Active mobs of this type in area.

	min_height = -31000,

		- Minimum height level.

	max_height = 31000,

		- Maximum height level.

	day_toggle = nil,

		- Daytime toggle, true to spawn during day, false for night, nil for both

	on_spawn = nil,

		- On spawn function to run when mob spawns in world

	on_map_load = nil,

		- On map load, when true mob only spawns in newly generated map areas
})
]]--

local function logTable(tableToLog)
    minetest.log("loggedTable", "Logging table contents:")
    
    -- Iterate over each key-value pair in the table
    for key, value in pairs(tableToLog) do
        -- Convert the value to a string for logging
        local valueString = tostring(value)
        
        -- Log the key-value pair
        minetest.log("loggedTable", key .. ": " .. valueString)
    end
    
    minetest.log("loggedTable", "End of table logging.")
end

--local monster_spawn_chance_multiplier = 1
--local wildlife_spawn_chance_multiplier = 1

--mob_biome_mapper_settings = {
    monster_spawn_chance_multiplier = tonumber(minetest.settings:get("monster_spawn_chance_multiplier")) or 1
    wildlife_spawn_chance_multiplier = tonumber(minetest.settings:get("wildlife_spawn_chance_multiplier")) or 1
--}

--spawn creatura mobs using spawnit if enabled otherwise creature spawn.
local function creatura_register_spawn(name, spawnparms)
	 -- Define default values for the parameters in case they are not provided
	 local name = name or ""
	 local nodes = spawnparms.nodes or {}
	 local min_light = spawnparms.min_light or 0
	 local max_light = spawnparms.max_light or 15
	 local interval = spawnparms.interval or 50
	 local chance = spawnparms.chance or (6000)
	 local min_height = spawnparms.min_height or -31000
	 local max_height = spawnparms.max_height or 31000
	 local min_time = spawnparms.min_time or 0
	 local max_time = spawnparms.max_time or 24000
	 local active_object_count = spawnparms.spawn_cap or 6
	 local min_group = spawnparms.min_group or 1
	 local max_group = spawnparms.max_group or 1
	 --local near = spawnparms.neighbors or {"any"}
	
	 local min_time_of_day = min_time/24000
	 local max_time_of_day = max_time/24000
	 

	 if minetest.get_modpath("spawnit") then
		 spawnit.register({
			 entity_name = name,
			 groups = { mob = 1 },  -- or "npc" or "animal", or something custom
			 cluster = (min_group+max_group)/2, -- maximum amount to spawn at once (cluster is within a single mapblock)
			 chance = chance/60, -- there will be a 1 in 100 chance of trying to spawn the mob (or cluster) per second, ish
			 per_player = true, -- if true, there will be a 1 in 100 chance of spawning a mob every second per connected player
		 
			 -- TODO: allow and/or/not/parentheses for these things
			 -- WARNING: that might break something!
			 on =  nodes, -- any solid full node. or, list of nodes, groups, "walkable" for any solid node (incl. mesh/nodebox)
			 --within = { "not walkable" },  -- all of the mob must be within these nodes
			-- near = near,  -- mob must be "touching" these. intersects "on".
			 min_y = min_height,
			 max_y = max_height,
			 min_node_light = min_light,
			 max_node_light = max_light,
			 min_natural_light = min_light,
			 max_natural_light = max_light,
			 min_time_of_day = min_time_of_day,  -- 0/1 is midnight, 0.25 is dawn-ish, 0.5 is noon, .75 is dusk-ish
			 max_time_of_day = max_time_of_day,  -- set min to 0, and max to 1, to indicate any time (default)
			 --spawn_in_protected = true,
			 --min_player_distance = 12,
			 --max_player_distance = nil,
		 
			 max_active = active_object_count * 30,
			 max_in_area = active_object_count * 3,
			 max_in_area_radius = 16,
		 
			 --collisionbox = nil, -- if not defined, this is inferred from the entity's definition
		 
			 --should_spawn = function()  end,
			 --check_pos = function(pos) end,  -- return true to allow spawning at that position, false to disallow
			 --after_spawn = function(pos, obj) end,  -- called after a mob has spawned
		 })
	 else
	creatura.register_abm_spawn(name, {
		chance = chance,
		interval = interval,
		min_light = min_light,
		max_light = max_light,
		min_height = min_height,
		max_height = max_height,
		min_group = min_group,
		max_group = max_group,
		min_time = min_time,
		max_time = max_time,
		spawn_cap = active_object_count,
		nodes = nodes
	})
	end
end

-- Define the function 'spawn' with a single argument 'spawnparms', which is a table
local function mob_spawn(spawnparms)
    -- Define default values for the parameters in case they are not provided
    local name = spawnparms.name or ""
    local nodes = spawnparms.nodes or {}
    local min_light = spawnparms.min_light or 0
	local max_light = spawnparms.max_light or 15
    local interval = spawnparms.interval or 50
    local chance = spawnparms.chance or (6000)
    local min_height = spawnparms.min_height or -31000
    local max_height = spawnparms.max_height or 31000
    local day_toggle = spawnparms.day_toggle or nil
    local active_object_count = spawnparms.active_object_count or 3
	local cluster = spawnparms.cluster or 1
	local near = spawnparms.neighbors or {"any"}
	--local on_spawn = nil

	local min_time_of_day = 0
	local max_time_of_day = 1
	if (day_toggle == true) then
		min_time_of_day = .25
		max_time_of_day = .75
	end
	if (day_toggle == false) then
		min_time_of_day = .75
		max_time_of_day = .25
	end
    
	if minetest.get_modpath("spawnit") then
		--[[minetest.log("x","name: "..name)
		minetest.log("x","cluster: "..cluster)
		minetest.log("x","chance: "..chance/60)
		logTable(nodes)
		logTable(near)
		minetest.log("x","min_height: "..min_height)
		minetest.log("x","max_height: "..max_height)
		minetest.log("x","min_light: "..min_light)
		minetest.log("x","max_light: "..max_light)
		minetest.log("x","min_time_of_day: "..min_time_of_day)
		minetest.log("x","max_time_of_day: "..max_time_of_day)

		--minetest.log("x","name: "..day_toggle)
		minetest.log("x","active_object_count: "..active_object_count*30)
		minetest.log("x","max_in_area: "..active_object_count*3)
		minetest.log("x","max_in_area_radius: "..16)]]
		spawnit.register({
			entity_name = name,
			groups = { mob = 1 },  -- or "npc" or "animal", or something custom
			cluster = cluster, -- maximum amount to spawn at once (cluster is within a single mapblock)
			chance = chance/60, -- there will be a 1 in 100 chance of trying to spawn the mob (or cluster) per second, ish
			per_player = true, -- if true, there will be a 1 in 100 chance of spawning a mob every second per connected player
		
			-- TODO: allow and/or/not/parentheses for these things
			-- WARNING: that might break something!
			on =  nodes, -- any solid full node. or, list of nodes, groups, "walkable" for any solid node (incl. mesh/nodebox)
			--within = { "not walkable" },  -- all of the mob must be within these nodes
			near = near,  -- mob must be "touching" these. intersects "on".
			min_y = min_height,
			max_y = max_height,
			min_node_light = min_light,
			max_node_light = max_light,
			min_natural_light = min_light,
			max_natural_light = max_light,
			min_time_of_day = min_time_of_day,  -- 0/1 is midnight, 0.25 is dawn-ish, 0.5 is noon, .75 is dusk-ish
			max_time_of_day = max_time_of_day,  -- set min to 0, and max to 1, to indicate any time (default)
			--spawn_in_protected = true,
			--min_player_distance = 12,
			--max_player_distance = nil,
		
			max_active = active_object_count * 30,
			max_in_area = active_object_count * 3,
			max_in_area_radius = 16,
		
			--collisionbox = nil, -- if not defined, this is inferred from the entity's definition
		
			--should_spawn = function()  end,
			--check_pos = function(pos) end,  -- return true to allow spawning at that position, false to disallow
			--after_spawn = function(pos, obj) end,  -- called after a mob has spawned
		})
	else
		--[[minetest.log("x","name: "..name)
		logTable(nodes)
		minetest.log("x","min_light: "..min_light)
		minetest.log("x","max_light: "..max_light)
		minetest.log("x","interval: "..interval)
		minetest.log("x","chance: "..chance)
		minetest.log("x","min_height: "..min_height)
		minetest.log("x","max_height: "..max_height)
		--minetest.log("x","name: "..day_toggle)
		minetest.log("x","active_object_count: "..active_object_count)]]


		mobs:spawn({
			name = name,
			nodes = nodes,
			min_light = min_light,
			max_light = max_light,
			interval = interval,
			chance = chance,
			min_height = min_height,
			max_height = max_height,
			day_toggle = day_toggle,
			active_object_count = active_object_count,
		})
	end
end

--[[mob_spawn({
	name = "animalworld:beaver",
	nodes = {"group:swamp", "group:forest","group:backroom"},
	min_light = 0,
	interval = 60,
	chance = 120,
	min_height = 0,
	max_height = 1000,
})]]



local ambient_spawn_chance = tonumber(minetest.settings:get("animalia_ambient_chance")) or 6000
--minetest.log("x", "amb_sp_ch:" .. ambient_spawn_chance)
if minetest.get_modpath("animalia") then
	creatura_register_spawn("animalia:bat", {
		chance = ambient_spawn_chance/wildlife_spawn_chance_multiplier,
		interval = 40,
		min_light = 0,
		min_height = -31000,
		max_height = 31000,
		min_group = 3,
		max_group = 5,
		min_time = 19500,
		max_time = 4000,
		spawn_cap = 6,
		nodes = {"group:cursed_ground", "group:cave_floor", "group:banana","group:redwood","group:backroom"}
	})
--[[	creatura_register_spawn("animalia:frog", {
		chance = ambient_spawn_chance /(20*wildlife_spawn_chance_multiplier),
		interval = 40,
		--min_light = 0,
		min_height = -1,
		max_height = 1111,
		min_group = 1,
		max_group = 3,
		spawn_in_nodes = true,
		nodes = {"group:swamp","group:backroom", "group:desert_surface"}
	})]]
	creatura_register_spawn("animalia:owl", {
		chance = (ambient_spawn_chance * 0.75)/wildlife_spawn_chance_multiplier,
		interval = 60,
		min_light = 0,
		min_height = -1,
		max_height = 6024,
		min_group = 1,
		max_group = 2,
		nodes = {"group:mediterranean","group:backroom"}
	})
	creatura_register_spawn("animalia:rat", {
		chance = ambient_spawn_chance/(wildlife_spawn_chance_multiplier),
		interval = 60,
		min_height = -1,
		max_height = 31000,
		min_group = 1,
		max_group = 3,
		spawn_in_nodes = true,
		nodes = {"group:cursed_ground","group:swamp","group:backroom"}
	})
	creatura_register_spawn("animalia:frog", {
		chance = ambient_spawn_chance/(wildlife_spawn_chance_multiplier),
		interval = 60,
		min_height = -1,
		max_height = 17,
		min_group = 1,
		max_group = 3,
		spawn_in_nodes = true,
		nodes = {"group:cursed_ground","group:swamp","group:backroom"}
	})
	creatura_register_spawn("animalia:reindeer", {
		chance = ambient_spawn_chance/wildlife_spawn_chance_multiplier,
		interval = 60,
		min_height = -1,
		max_height = 31000,
		min_group = 1,
		max_group = 3,
		spawn_in_nodes = true,
		nodes = {"group:frozen_surface","group:backroom"}
	})
	creatura_register_spawn("animalia:turkey", {
		chance = ambient_spawn_chance/wildlife_spawn_chance_multiplier,
		interval = 60,
		min_height = -1,
		max_height = 1024,
		min_group = 1,
		max_group = 3,
		spawn_in_nodes = true,
		nodes = {"group:leaves","group:backroom"}
	})
	creatura_register_spawn("animalia:wolf", {
		chance = ambient_spawn_chance/wildlife_spawn_chance_multiplier,
		interval = 60,
		min_height = -10,
		max_height = 31000,
		min_group = 1,
		max_group = 3, 
		spawn_in_nodes = true,
		nodes = {"group:mediterranean","group:forest","group:backroom"}
	})
end




if minetest.get_modpath("animalworld") then

	mob_spawn({
		name = "animalworld:anteater",
		nodes = {"group:banana","group:backroom","group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		day_toggle = false,
		active_object_count = 3,
	})
	mob_spawn({
		name = "animalworld:bat",
		nodes = {"group:cursed_ground","group:cave_floor", "group:banana","group:mediterranean","group:redwood","group:backroom","group:rainforest", "group:desert_cave"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
		day_toggle = false,
		active_object_count = 3,
	})
		mob_spawn({
		name = "animalworld:bat",
		nodes = {"group:hero_mine"},
		min_light = 0,
		interval = 15,
		chance = 2000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
		day_toggle = false,
		active_object_count = 30,
	})
	mob_spawn({
		name = "animalworld:bear",
		nodes = {"group:japanese_forest","group:redwood","group:forest","group:backroom","default:stone"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -100,
		max_height = 6000,
	})
	mob_spawn({
		name = "animalworld:beaver",
		nodes = {"group:swamp", "group:forest","group:backroom"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:blackgrouse",
		nodes = {"group:swamp", "group:forest","group:backroom"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:boar",
		nodes = {"group:forest","group:mediterranean","group:savanna_dirt","group:backroom"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:blackbird",
		nodes = {"group:swamp"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:clamydosaurus",
		nodes = {"group:swamp", "group:desert_surface","group:redwood", "group:desert_cave"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
	})	
	mob_spawn({
		name = "animalworld:crocodile",
		nodes = {"group:swamp", "group:australia_ocean"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -10,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:dragonfly",
		nodes = {"group:swamp", "group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		active_object_count = 4,
	})
	mob_spawn({
		name = "animalworld:elephant",
		nodes = {"group:savanna_dirt", "group:bamboo_ground", "group:banana"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:frog",
		nodes = {"group:swamp", "group:mediterranean","group:redwood","group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		active_object_count = 3,
	})
	mob_spawn({
		name = "animalworld:giraffe",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:gnu",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:hare",
		nodes = {"group:japanese_forest","group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:hyena",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:ibex",
		nodes = {"group:savanna_dirt","group:japanese_forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:iguana",
		nodes = {"group:banana","group:desert_surface","group:redwood","group:rainforest", "group:desert_cave"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:kangaroo",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:koala",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:monkey",
		nodes = {"group:banana","group:japanese_forest","group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:monitor",
		nodes = {"group:banana","group:desert_surface"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:mosquito",
		nodes = {"group:swamp","group:forest","group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		active_object_count = 2,
	})
	mob_spawn({
		name = "animalworld:orangutan",
		nodes = {"group:bamboo_ground","group:banana","group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:otter",
		nodes = {"group:swamp", "group:mediterranean"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	if minetest.get_modpath("australia") then
		mob_spawn({
		name = "animalworld:owl",
		nodes = {"group:leaves"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	end
	mob_spawn({
		name = "animalworld:panda",
		nodes = {"group:bamboo_ground"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		day_toggle = false,
	})
	mob_spawn({
		name = "animalworld:parrot",
		nodes = {"group:banana","group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	--[[mob_spawn({
		name = "animalworld:parrot_flying",
		nodes = {"group:banana"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})]]
	mob_spawn({
		name = "animalworld:rat",
		nodes = {"group:hero_mine"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
		active_object_count = 3,
	})
	mob_spawn({
		name = "animalworld:rat",
		nodes = {"group:hero_mine"},
		min_light = 0,
		interval = 15,
		chance = 2000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
		active_object_count = 30,
	})
	mob_spawn({
		name = "animalworld:reindeer",
		nodes = {"group:frozen_surface","group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:roadrunner",
		nodes = {"group:desert_surface"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:scorpion",
		nodes = {"group:desert_surface","group:mediterranean", "group:desert_cave"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
		active_object_count = 3,
	})
	mob_spawn({
		name = "animalworld:scorpion",
		nodes = {"group:hero_mine"},
		min_light = 0,
		interval = 15,
		chance = 2000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
		active_object_count = 30,
	})
	mob_spawn({
		name = "animalworld:spider",
		nodes = {"group:cursed_ground", "group:desert_surface", "group:rainforest", "group:desert_cave"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:spider",
		nodes = {"group:hero_mine"},
		min_light = 0,
		interval = 15,
		chance = 2000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
		active_object_count = 30,
	})
	mob_spawn({
		name = "animalworld:spidermale",
		nodes = {"group:cursed_ground", "group:desert_surface", "group:rainforest", "group:desert_cave"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:spidermale",
		nodes = {"group:hero_mine"},
		min_light = 0,
		interval = 15,
		chance = 2000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
		active_object_count = 30,
	})
	mob_spawn({
		name = "animalworld:stellerseagle",
		nodes = {"group:japanese_forest","group:forest","group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:tiger",
		nodes = {"group:bamboo_ground","group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
	name = "animalworld:tortoise",
	nodes = {"group:swamp", "group:desert_surface"},
	min_light = 0,
	interval = 60,
	chance = 6000/wildlife_spawn_chance_multiplier,  
	min_height = 0,
	max_height = 1000,
	active_object_count = 3,
	})
	mob_spawn({
		name = "animalworld:toucan",
		nodes = {"group:banana","group:rainforest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:viper",
		nodes = {"group:desert_surface", "group:mediterranean", "group:swamp","group:redwood","group:rainforest", "group:desert_cave"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:viper",
		nodes = {"group:hero_mine"},
		min_light = 0,
		interval = 15,
		chance = 2000/wildlife_spawn_chance_multiplier,  
		min_height = -5000,
		max_height = 1000,
		active_object_count = 30,
	})
	mob_spawn({
		name = "animalworld:vulture",
		nodes = {"group:desert_surface"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:wolf",
		nodes = {"group:mediterranean","group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:wildboar",
		nodes = {"group:forest","group:mediterranean","group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mob_spawn({
		name = "animalworld:zebra",
		nodes = {"group:savanna"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000
	})

end

if minetest.get_modpath("dmobs") then
	mob_spawn({name = "dmobs:gnorm", nodes = {"default:dirt_with_grass", "ethereal:bamboo_dirt","group:dirt","group:backroom"}, neighbor = {},
	min_light = 10, max_light = 15, interval = 300, chance = 32000/monster_spawn_chance_multiplier, active_object_count = 2, min_height = -100, max_height = 1000})
	mob_spawn({name = "dmobs:elephant", nodes = {"group:savanna_dirt", "group:bamboo_ground", "group:banana"},
	min_light = 10, max_light = 15, interval = 300, chance = 10000/wildlife_spawn_chance_multiplier, active_object_count = 2, min_height = 0, max_height = 2000})
	mob_spawn({
		name = "dmobs:panda",
		nodes = {"group:bamboo_ground"},
		min_light = 7,
		interval = 300,
		chance = 8000/wildlife_spawn_chance_multiplier,
		active_object_count = 2,
		min_height = 0,
		max_height = 2000
	})
	mob_spawn({name = "dmobs:pig_evil", nodes = {"group:leave", "ethereal:bamboo_leaves", "group:leaves"}, neighbor = {},
	min_light = 10, max_light = 15, interval = 300, chance = 54000/monster_spawn_chance_multiplier, active_object_count = 2, min_height = 0, max_height = 2000})
	mob_spawn({name = "dmobs:skeleton", nodes = {"group:stone","group:volcanic","group:cave_floor","group:cursed_ground","group:backroom"}, neighbor = {},
	min_light = 0, max_light = 10, interval = 300, chance = 16000/monster_spawn_chance_multiplier, active_object_count = 2, min_height = -31000, max_height = -1})
	mob_spawn({name = "dmobs:tortoise", nodes = {"group:swamp"}, neighbor = {},
	min_light = 0, max_light = 15, interval = 100, chance = 6000/wildlife_spawn_chance_multiplier, active_object_count = 2, min_height = 0, max_height = 100})
	mob_spawn({
		name = "dmobs:orc",
		nodes = {
			"group:cursed_ground","group:backroom"
		},
		max_light = 7,
		interval = 300,
		chance = dmobs.dragons and 8000/monster_spawn_chance_multiplier or 6000/monster_spawn_chance_multiplier,
		active_object_count = 2,
		min_height = -100,
		max_height = 2000
	})

	mob_spawn({
		name = "dmobs:ogre",
		nodes = {
			"group:cursed_ground","group:backroom"
		},
		max_light = 10,
		interval = 300,
		chance = dmobs.dragons and 32000/monster_spawn_chance_multiplier or 16000/monster_spawn_chance_multiplier,
		active_object_count = 2,
		min_height = -100,
		max_height = 2000
	})
	if dmobs.dragons then  --just divided chance by 4.
		mob_spawn({name = "dmobs:dragon1", nodes = {"group:desert_surface", "group:volcanic"}, neighbor = {},
			min_light = 5, max_light = 15, interval = 300, chance = 6000/monster_spawn_chance_multiplier, active_object_count = 2, min_height = 0, max_height = 30000})
			mob_spawn({
				name = "dmobs:dragon4",
				nodes = {
					"group:frozen_surface"
				},
				min_light = 5,
				interval = 300,
				chance = 24000,
				active_object_count = 2,
				min_height = 0
			})
		
	end
end

if minetest.get_modpath("mobs_ghost_redo") then
	mob_spawn({name = "mobs_ghost_redo:ghost",
	nodes = {"group:backroom"},
	max_light = 15,
	min_light = 0,
	interval = 30,
	chance = 1000/monster_spawn_chance_multiplier,
	active_object_count = 4,
	min_height = -30912,
	max_height = 31000
})
end


if minetest.get_modpath("mobs_monster") then
    -- The "mobs_monster" mod is enabled, execute your code here

	-- Dirt Monster
	mob_spawn({
		name = "mobs_monster:dirt_monster",
		nodes = {"group:dirt"},
		min_light = 0,
		max_light = 7,
		chance = 6000/monster_spawn_chance_multiplier,
		active_object_count = 2,
		min_height = 0,
		day_toggle = false,
	})
	-- minetest.log("ToChat:",	"Ran Mapper code." )   -- COMMENT THIS OUT **********
	-- Dungeon Master

	mob_spawn({
		name = "mobs_monster:dungeon_master",
		nodes = {"group:volcanic", "group:cave_floor","group:backroom"},
		max_light = 7,  --5
		chance = 9000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		max_height = 31000,
	})

	-- Lava Flan

	mob_spawn({
		name = "mobs_monster:lava_flan",
		nodes = {"group:volcanic","group:backroom"},
		chance = 7000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		max_height = 31000,
	})

	-- Mese Monster

	mob_spawn({
		name = "mobs_monster:mese_monster",
		nodes = {"group:coral", "group:cave_floor","group:backroom"},
		max_light = 9,  --7
		chance = 5000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		max_height = 31000,
		day_toggle = false,
	})

	-- Oerkki

	mob_spawn({
		name = "mobs_monster:oerkki",
		nodes = {"group:cursed_ground", "group:cave_floor","group:backroom"},
		max_light = 9,  --7
		chance = 7000/monster_spawn_chance_multiplier,
		max_height = 31000,
	})

	-- Sand Monster

	mob_spawn({
		name = "mobs_monster:sand_monster",
		nodes = {"group:desert_surface","group:backroom"},
		chance = 7000/monster_spawn_chance_multiplier,
		active_object_count = 2,
		min_height = 0,
	})

	-- Spider (above ground)

	mob_spawn({
		name = "mobs_monster:spider",
		nodes = {
			"default:dirt_with_rainforest_litter", "group.frozen_surface", "group:cursed_ground","group:backroom"
		},
		min_light = 0,
		max_light = 8,
		chance = 7000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		min_height = -40,
		max_height = 31000,
	})

	-- Spider (below ground)
	mob_spawn({
		name = "mobs_monster:spider",
		nodes = {"default:stone_with_mese", "default:mese", "default:stone", "group:cave_floor","group:backroom"},
		min_light = 0,
		max_light = 9, --7
		chance = 7000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		min_height = -31000,
		max_height = -40,
	})

	-- Stone Monster

	mob_spawn({
		name = "mobs_monster:stone_monster",
		nodes = {"default:stone", "default:desert_stone", "default:sandstone", "group:cave_floor","group:backroom"},
		max_light = 9, --7
		chance = 7000/monster_spawn_chance_multiplier,
		max_height = 0,
	})

	-- Tree Monster

	mob_spawn({
		name = "mobs_monster:tree_monster",
		nodes = {"default:forest", "default:jungleleaves"},
		max_light = 7,
		chance = 7000/monster_spawn_chance_multiplier,
		min_height = 0,
		day_toggle = false,
	})

	else
		-- The "mobs_monster" mod is not enabled 
		print("The 'mobs_monster' mod is not enabled.")
end
