
--[[ Spawn Template, defaults to values shown if line not provided

mobs:spawn({

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

local function addGroupToNode(modname, nodename, groupname)

    if minetest.get_modpath(modname) then
        local node_def = minetest.registered_nodes[modname .. ":" .. nodename]

        if node_def then
            node_def.groups[groupname] = 1
            minetest.override_item(modname .. ":" .. nodename, { groups = node_def.groups })
			--*********Log info about groups node belongs to. COMMENT THIS OUT **********
			-- minetest.log("nodeinfo:", "nodeinfo:" .. nodename)
			-- for group, value in pairs(node_def.groups) do
			-- -- Log each item using minetest.log()
			-- minetest.log("groups:", "group: " .. group .. ", value: " .. value)
			-- end
			--*********************************************************  
        end

	end
end

function getNodesByGroup(group)
    --local nodes = {}
    for name, def in pairs(minetest.registered_nodes) do
        if def.groups and def.groups[group] then
           -- table.insert(nodes, name)
		   minetest.log("ToChat:", "group:" ..group .. " nodename:".. name)
        end
    end
    return nodes
end

local function groupsToNodes()
	--******************COMMENT THIS OUT **********
	--getNodesByGroup("tree")
	--getNodesByGroup("flora")
	getNodesByGroup("bamboo_ground")
	minetest.log("ToChat:", "ranGroupToNodes:")
	--*********************************************************  
	if minetest.get_modpath("caverealms") then
		addGroupToNode("caverealms", "stone_with_salt", "cave_floor")
		addGroupToNode("caverealms", "stone_with_moss", "cave_floor")
		addGroupToNode("caverealms", "stone_with_lichen", "cave_floor")
	end
	addGroupToNode("default", "desert_sand", "desert_surface")
	addGroupToNode("default", "dry_dirt_with_dry_grass", "dirt")
	addGroupToNode("default", "dry_dirt_with_dry_grass", "savanna_dirt")
	addGroupToNode("default", "permafrost", "frozen_surface")
	addGroupToNode("default", "permafrost_with_moss", "frozen_surface")
	addGroupToNode("default", "permafrost_with_stone", "frozen_surface")
	addGroupToNode("default", "snowblock", "frozen_surface")
	addGroupToNode("default", "snow", "frozen_surface")
	if minetest.get_modpath("ebiomes") then
		addGroupToNode("ebiomes", "dirt_with_humid_savanna_grass", "dirt")
		addGroupToNode("ebiomes", "dirt_with_grass_arid", "dirt")
		addGroupToNode("ebiomes", "dirt_with_grass_arid", "savanna_dirt")
	end
	if minetest.get_modpath("ethereal") then
		addGroupToNode("ethereal", "gray_dirt", "dirt")
		addGroupToNode("ethereal", "dry_dirt", "dirt")
		addGroupToNode("ethereal", "prairie_dirt", "dirt")
		addGroupToNode("ethereal", "bamboo_dirt", "dirt")
		addGroupToNode("ethereal", "bamboo_dirt", "bamboo_ground")
		addGroupToNode("ethereal", "grove_dirt", "dirt")
		addGroupToNode("ethereal", "grove_dirt", "banana")
		addGroupToNode("ethereal", "mushroom_dirt", "dirt")
		addGroupToNode("ethereal", "fiery_dirt", "desert_surface")
		addGroupToNode("ethereal", "grove_dirt", "savanna_dirt")
		addGroupToNode("ethereal", "crystal_dirt", "frozen_surface")
		addGroupToNode("ethereal", "cold_dirt", "frozen_surface")
	end
	if minetest.get_modpath("everness") then
		addGroupToNode("everness", "dirt_with_crystal_grass", "frozen_surface")
		addGroupToNode("everness", "dirt_with_cursed_grass", "cursed_ground")
		addGroupToNode("everness", "dry_dirt_with_dry_grass", "savanna_dirt")
		addGroupToNode("everness", "forsaken_tundra_dirt_with_grass", "volcanic")
		addGroupToNode("everness", "forsaken_tundra_dirt", "volcanic")
		addGroupToNode("everness", "volcanic_sulfur", "volcanic")
		addGroupToNode("everness", "dirt_with_coral_grass", "coral")
		-- addGroupToNode("everness", "bamboo", "bamboo")
		-- addGroupToNode("everness", "bamboo_1", "bamboo")
		-- addGroupToNode("everness", "bamboo_2", "bamboo")
		-- addGroupToNode("everness", "bamboo_3", "bamboo")
		addGroupToNode("everness", "dirt_with_grass_1", "bamboo_ground")
		addGroupToNode("everness", "dirt_with_grass_extras_1", "bamboo_ground")
		addGroupToNode("everness", "dirt_with_grass_extras_2", "bamboo_ground")
	end
	--begin variety modpack--
	if minetest.get_modpath("japanese_forest") then
		addGroupToNode("japanese_forest", "japanese_dirt_with_grass", "japanese_forest")
	end
	if minetest.get_modpath("cherry") then
		addGroupToNode("cherry", "cherry_dirt_with_grass", "japanese_forest")
	end
	if minetest.get_modpath("bambooforest") then
		addGroupToNode("bambooforest", "dirt_with_bamboo", "bamboo_ground")
	end
	if minetest.get_modpath("frost_land") then
		addGroupToNode("frost_land", "frost_land_grass", "frozen_surface")
		addGroupToNode("frost_land", "frost_land_grass", "frozen_surface")
	end
	if minetest.get_modpath("terracotta") then
		addGroupToNode("terracotta", "terracotta_1", "desert_surface")
	end
	if minetest.get_modpath("redwood") then
		addGroupToNode("redwood", "redwood_dirt_with_grass", "redwood")
	end
	if minetest.get_modpath("meadow") then
		addGroupToNode("meadow", "meadow_dirt_with_grass", "forest")
	end
	if minetest.get_modpath("dorwinion") then
		addGroupToNode("dorwinion", "dorwinion_grass", "forest")
	end
	if minetest.get_modpath("nightshade") then
		addGroupToNode("nightshade", "nightshade_dirt_with_grass", "forest")
	end
	if minetest.get_modpath("alurios_forest") then
		addGroupToNode("alurios_forest", "alurios_forest_dirt_with_alurios_forest_grass", "forest")
	end
	--end variety modpack--
	if minetest.get_modpath("naturalbiomes") then
		addGroupToNode("naturalbiomes", "alpine_litter", "dirt")
		addGroupToNode("naturalbiomes", "alderswamp_litter", "dirt")
		addGroupToNode("naturalbiomes", "alderswamp_litter", "swamp")	
		addGroupToNode("naturalbiomes", "heath_litter", "dirt")
		addGroupToNode("naturalbiomes", "heath_litter2", "dirt")
		addGroupToNode("naturalbiomes", "mediterran_litter", "dirt")
		addGroupToNode("naturalbiomes", "mediterran_litter", "mediterranean")
		addGroupToNode("naturalbiomes", "outback_litter", "desert_surface")
	end
	if minetest.get_modpath("sumpf") then
		addGroupToNode("sumpf", "sumpf", "swamp")
	end
	if minetest.get_modpath("swaz") then
		addGroupToNode("swaz", "silt_with_grass", "swamp")
		addGroupToNode("swaz", "mud_with_moss", "swamp")
		addGroupToNode("swaz", "mud", "swamp")
	end
	-- getNodesByGroup("bamboo_ground")
	-- getNodesByGroup("swamp")
	-- minetest.log("ToChat:", "ranGroupToNodes:")
end

groupsToNodes()
-- Check if a mod named "mobs" is enabled
local monster_spawn_chance_multiplier = 1
local wildlife_spawn_chance_multiplier = 1

local ambient_spawn_chance = tonumber(minetest.settings:get("animalia_ambient_chance")) or 6000
if minetest.get_modpath("animalia") then
	creatura.register_abm_spawn("animalia:bat", {
		chance = ambient_spawn_chance,
		interval = 30,
		min_light = 0,
		min_height = -31000,
		max_height = 1000,
		min_group = 3,
		max_group = 5,
		min_time = 19500,
		max_time = 4000,
		spawn_cap = 6,
		nodes = {"group:cursed_ground", "group:cave_floor", "group:banana","group:redwood"}
	})
	creatura.register_abm_spawn("animalia:frog", {
		chance = ambient_spawn_chance * 0.75,
		interval = 60,
		min_light = 0,
		min_height = -1,
		max_height = 8,
		min_group = 1,
		max_group = 2,
		nodes = {"group:swamp"}
	})
	creatura.register_abm_spawn("animalia:owl", {
		chance = (ambient_spawn_chance * 0.75),
		interval = 60,
		min_light = 0,
		min_height = -1,
		max_height = 1024,
		min_group = 1,
		max_group = 2,
		nodes = {"group:mediterranean"}
	})
	creatura.register_abm_spawn("animalia:rat", {
		chance = ambient_spawn_chance,
		interval = 60,
		min_height = -1,
		max_height = 1024,
		min_group = 1,
		max_group = 3,
		spawn_in_nodes = true,
		nodes = {"group:cursed_ground","group:swamp"}
	})
	creatura.register_abm_spawn("animalia:reindeer", {
		chance = ambient_spawn_chance,
		interval = 60,
		min_height = -1,
		max_height = 1024,
		min_group = 1,
		max_group = 3,
		spawn_in_nodes = true,
		nodes = {"group:frozen_surface"}
	})
	creatura.register_abm_spawn("animalia:turkey", {
		chance = ambient_spawn_chance,
		interval = 60,
		min_height = -1,
		max_height = 1024,
		min_group = 1,
		max_group = 3,
		spawn_in_nodes = true,
		nodes = {"group:leaves"}
	})
	creatura.register_abm_spawn("animalia:wolf", {
		chance = ambient_spawn_chance,
		interval = 60,
		min_height = -1,
		max_height = 1024,
		min_group = 1,
		max_group = 3,
		spawn_in_nodes = true,
		nodes = {"group:leaves","group:mediterranean","group:forest"}
	})
end

if minetest.get_modpath("animalworld") then

	mobs:spawn({
		name = "animalworld:anteater",
		nodes = {"group:banana"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		day_toggle = false,
		active_object_count = 3,
	})
	mobs:spawn({
		name = "animalworld:bat",
		nodes = {"group:cursed_ground","group:cave_floor", "group:banana","group:mediterranean","group:redwood"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		day_toggle = false,
		active_object_count = 3,
	})
	mobs:spawn({
		name = "animalworld:bear",
		nodes = {"group:japanese_forest","group:redwood","group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:beaver",
		nodes = {"group:swamp", "group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:blackgrouse",
		nodes = {"group:swamp", "group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:boar",
		nodes = {"group:forest","group:mediterranean","group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:blackbird",
		nodes = {"group:swamp"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:clamydosaurus",
		nodes = {"group:swamp", "group:desert_surface","group:redwood"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})	
	mobs:spawn({
		name = "animalworld:crocodile",
		nodes = {"group:swamp"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:dragonfly",
		nodes = {"group:swamp"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		active_object_count = 4,
	})
	mobs:spawn({
		name = "animalworld:elephant",
		nodes = {"group:savanna_dirt", "group:bamboo_ground", "group:banana"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:frog",
		nodes = {"group:swamp", "group:mediterranean","group:redwood"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		active_object_count = 3,
	})
	mobs:spawn({
		name = "animalworld:giraffe",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:gnu",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:hare",
		nodes = {"group:japanese_forest","group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:hyena",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:ibex",
		nodes = {"group:savanna_dirt","group:japanese_forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:iguana",
		nodes = {"group:banana","group:desert_surface","group:redwood"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:kangaroo",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:koala",
		nodes = {"group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:monkey",
		nodes = {"group:banana","group:japanese_forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:monitor",
		nodes = {"group:banana","group:desert_surface"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:mosquito",
		nodes = {"group:swamp","group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		active_object_count = 2,
	})
	mobs:spawn({
		name = "animalworld:orangutan",
		nodes = {"group:bamboo_ground","group:banana"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:otter",
		nodes = {"group:swamp"; "group:mediterranean"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:panda",
		nodes = {"group:bamboo_ground"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:parrot",
		nodes = {"group:banana"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:parrot_flying",
		nodes = {"group:banana"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:reindeer",
		nodes = {"group:frozen_surface","group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:roadrunner",
		nodes = {"group:desert_surface"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:scorpion",
		nodes = {"group:desert_surface","group:mediterranean"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
		active_object_count = 3,
	})
	mobs:spawn({
		name = "animalworld:spider",
		nodes = {"group:cursed_ground", "group:desert_surface"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:spidermale",
		nodes = {"group:cursed_ground", "group:desert_surface"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:stellerseagle",
		nodes = {"group:japanese_forest","group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:tiger",
		nodes = {"group:bamboo_ground"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
	name = "animalworld:tortoise",
	nodes = {"group:swamp", "group:desert_surface"},
	min_light = 0,
	interval = 60,
	chance = 6000/wildlife_spawn_chance_multiplier,  
	min_height = 0,
	max_height = 1000,
	active_object_count = 3,
	})
	mobs:spawn({
		name = "animalworld:toucan",
		nodes = {"group:banana"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:viper",
		nodes = {"group:desert_surface", "group:mediterranean", "group:swamp","group:redwood"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:vulture",
		nodes = {"group:desert_surface"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:wolf",
		nodes = {"group:leaves","group:mediterranean","group:forest"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
		name = "animalworld:wildboar",
		nodes = {"group:leaves","group:mediterranean","group:savanna_dirt"},
		min_light = 0,
		interval = 60,
		chance = 6000/wildlife_spawn_chance_multiplier,  
		min_height = 0,
		max_height = 1000,
	})
	mobs:spawn({
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
	mobs:spawn({name = "dmobs:gnorm", nodes = {"default:dirt_with_grass", "ethereal:bamboo_dirt","group:dirt"}, neighbor = {},
	min_light = 10, max_light = 15, interval = 300, chance = 32000/monster_spawn_chance_multiplier, active_object_count = 2, min_height = -100, max_height = 0})
	mobs:spawn({name = "dmobs:elephant", nodes = {"group:savanna_dirt", "group:bamboo_ground", "group:banana"},
	min_light = 10, max_light = 15, interval = 300, chance = 10000/wildlife_spawn_chance_multiplier, active_object_count = 2, min_height = 0, max_height = 2000})
	mobs:spawn({
		name = "dmobs:panda",
		nodes = {"group:bamboo_ground"},
		min_light = 7,
		interval = 300,
		chance = 8000/wildlife_spawn_chance_multiplier,
		active_object_count = 2,
		min_height = 0,
		max_height = 2000
	})
	mobs:spawn({name = "dmobs:pig_evil", nodes = {"group:leave", "ethereal:bamboo_leaves", "group:leaves"}, neighbor = {},
	min_light = 10, max_light = 15, interval = 300, chance = 54000/monster_spawn_chance_multiplier, active_object_count = 2, min_height = 0, max_height = 2000})
	mobs:spawn({name = "dmobs:skeleton", nodes = {"group:stone","group:volcanic","group:cave_floor","group:cursed_ground"}, neighbor = {},
	min_light = 0, max_light = 10, interval = 300, chance = 16000/monster_spawn_chance_multiplier, active_object_count = 2, min_height = -31000, max_height = -1000})
	mobs:spawn({name = "dmobs:tortoise", nodes = {"group:swamp"}, neighbor = {},
	min_light = 0, max_light = 15, interval = 100, chance = 6000/wildlife_spawn_chance_multiplier, active_object_count = 2, min_height = 0, max_height = 100})
	mobs:spawn({
		name = "dmobs:orc",
		nodes = {
			"group:cursed_ground"
		},
		max_light = 7,
		interval = 300,
		chance = dmobs.dragons and 8000/monster_spawn_chance_multiplier or 6000/monster_spawn_chance_multiplier,
		active_object_count = 2,
		min_height = 0,
		max_height = 2000
	})

	mobs:spawn({
		name = "dmobs:ogre",
		nodes = {
			"group:cursed_ground"
		},
		max_light = 10,
		interval = 300,
		chance = dmobs.dragons and 32000/monster_spawn_chance_multiplier or 16000/monster_spawn_chance_multiplier,
		active_object_count = 2,
		min_height = 0,
		max_height = 2000
	})
	if dmobs.dragons then  --just divided chance by 4.
		mobs:spawn({name = "dmobs:dragon1", nodes = {"group.desert_surface", "group:volcanic"}, neighbor = {},
			min_light = 5, max_light = 15, interval = 300, chance = 6000/monster_spawn_chance_multiplier, active_object_count = 2, min_height = 0, max_height = 30000})
			mobs:spawn({
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

if minetest.get_modpath("mobs_monster") then
    -- The "mobs_monster" mod is enabled, execute your code here

	-- Dirt Monster
	mobs:spawn({
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

	mobs:spawn({
		name = "mobs_monster:dungeon_master",
		nodes = {"group:volcanic", "group:cave_floor"},
		max_light = 7,  --5
		chance = 9000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		max_height = 2000,
	})

	-- Lava Flan

	mobs:spawn({
		name = "mobs_monster:lava_flan",
		nodes = {"group:volcanic"},
		chance = 7000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		max_height = 2000,
	})

	-- Mese Monster

	mobs:spawn({
		name = "mobs_monster:mese_monster",
		nodes = {"group:coral", "group:cave_floor"},
		max_light = 9,  --7
		chance = 5000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		max_height = 2000,
		day_toggle = false,
	})

	-- Oerkki

	mobs:spawn({
		name = "mobs_monster:oerkki",
		nodes = {"group:cursed_ground", "group:cave_floor"},
		max_light = 9,  --7
		chance = 7000/monster_spawn_chance_multiplier,
		max_height = 2000,
	})

	-- Sand Monster

	mobs:spawn({
		name = "mobs_monster:sand_monster",
		nodes = {"group:desert_surface"},
		chance = 7000/monster_spawn_chance_multiplier,
		active_object_count = 2,
		min_height = 0,
	})

	-- Spider (above ground)

	mobs:spawn({
		name = "mobs_monster:spider",
		nodes = {
			"default:dirt_with_rainforest_litter", "group.frozen_surface", "group:cursed_ground"
		},
		min_light = 0,
		max_light = 8,
		chance = 7000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		min_height = 2000,
		max_height = 31000,
	})

	-- Spider (below ground)
	mobs:spawn({
		name = "mobs_monster:spider",
		nodes = {"default:stone_with_mese", "default:mese", "default:stone", "group:cave_floor"},
		min_light = 0,
		max_light = 9, --7
		chance = 7000/monster_spawn_chance_multiplier,
		active_object_count = 1,
		min_height = -31000,
		max_height = -40,
	})

	-- Stone Monster

	mobs:spawn({
		name = "mobs_monster:stone_monster",
		nodes = {"default:stone", "default:desert_stone", "default:sandstone", "group:cave_floor"},
		max_light = 9, --7
		chance = 7000/monster_spawn_chance_multiplier,
		max_height = 0,
	})

	-- Tree Monster

	mobs:spawn({
		name = "mobs_monster:tree_monster",
		nodes = {"default:leaves", "default:jungleleaves"},
		max_light = 7,
		chance = 7000/monster_spawn_chance_multiplier,
		min_height = 0,
		day_toggle = false,
	})

	else
		-- The "mobs_monster" mod is not enabled 
		print("The 'mobs_monster' mod is not enabled.")
end