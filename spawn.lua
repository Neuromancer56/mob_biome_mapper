
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

--******************COMMENT THIS OUT **********
--getNodesByGroup("tree")
--getNodesByGroup("flora")
--*********************************************************  

addGroupToNode("naturalbiomes", "alpine_litter", "dirt")
addGroupToNode("naturalbiomes", "alderswamp_litter", "dirt")
addGroupToNode("naturalbiomes", "heath_litter", "dirt")
addGroupToNode("naturalbiomes", "heath_litter2", "dirt")
addGroupToNode("naturalbiomes", "mediterran_litter", "dirt")
addGroupToNode("default", "dry_dirt_with_dry_grass", "dirt")
addGroupToNode("default", "dry_dirt_with_dry_grass", "savanna_dirt")
addGroupToNode("ethereal", "gray_dirt", "dirt")
addGroupToNode("ethereal", "dry_dirt", "dirt")
addGroupToNode("ethereal", "prairie_dirt", "dirt")
addGroupToNode("ethereal", "bamboo_dirt", "dirt")
addGroupToNode("ethereal", "grove_dirt", "dirt")
addGroupToNode("ethereal", "grove_dirt", "savanna_dirt")
addGroupToNode("ethereal", "mushroom_dirt", "dirt")
addGroupToNode("ebiomes", "dirt_with_humid_savanna_grass", "dirt")
addGroupToNode("ebiomes", "dirt_with_grass_arid", "dirt")
addGroupToNode("ebiomes", "dirt_with_grass_arid", "savanna_dirt")
addGroupToNode("naturalbiomes", "outback_litter", "desert_surface")
addGroupToNode("ethereal", "fiery_dirt", "desert_surface")
addGroupToNode("caverealms", "stone_with_salt", "cave_floor")
addGroupToNode("caverealms", "stone_with_moss", "cave_floor")
addGroupToNode("caverealms", "stone_with_lichen", "cave_floor")
addGroupToNode("ethereal", "crystal_dirt", "frozen_surface")
addGroupToNode("ethereal", "cold_dirt", "frozen_surface")
addGroupToNode("default", "permafrost", "frozen_surface")
addGroupToNode("default", "permafrost_with_moss", "frozen_surface")
addGroupToNode("default", "permafrost_with_stone", "frozen_surface")
addGroupToNode("default", "snowblock", "frozen_surface")
addGroupToNode("default", "snow", "frozen_surface")
addGroupToNode("everness", "dirt_with_crystal_grass", "frozen_surface")
addGroupToNode("everness", "dirt_with_cursed_grass", "cursed_ground")
addGroupToNode("everness", "forsaken_tundra_dirt_with_grass", "cursed_ground")
addGroupToNode("everness", "forsaken_tundra_dirt", "cursed_ground")
addGroupToNode("everness", "volcanic_sulfur", "cursed_ground")

-- Check if a mod named "mobs" is enabled
local spawn_chance_multiplier = 2
if minetest.get_modpath("dmobs") then
	mobs:spawn({name = "dmobs:gnorm", nodes = {"default:dirt_with_grass", "ethereal:bamboo_dirt","group:dirt"}, neighbor = {},
	min_light = 10, max_light = 15, interval = 300, chance = 32000, active_object_count = 2, min_height = -100, max_height = 0})
	mobs:spawn({name = "dmobs:elephant", nodes = {"group:savanna_dirt"}, neighbor = {},
	min_light = 10, max_light = 15, interval = 300, chance = 16000, active_object_count = 2, min_height = 0, max_height = 2000})
	mobs:spawn({name = "dmobs:pig_evil", nodes = {"group:leave", "ethereal:bamboo_leaves", "group:leaves"}, neighbor = {},
	min_light = 10, max_light = 15, interval = 300, chance = 54000/spawn_chance_multiplier, active_object_count = 2, min_height = 0, max_height = 2000})
	mobs:spawn({name = "dmobs:skeleton", nodes = {"group:stone","group:desert_surface","group:cave_floor","group:cursed_ground"}, neighbor = {},
	min_light = 0, max_light = 10, interval = 300, chance = 16000/spawn_chance_multiplier, active_object_count = 2, min_height = -31000, max_height = -1000})
	mobs:spawn({
		name = "dmobs:orc",
		nodes = {
			"group:cursed_ground"
		},
		max_light = 10,
		interval = 300,
		chance = dmobs.dragons and 8000 or 6000,
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
		chance = dmobs.dragons and 32000 or 16000,
		active_object_count = 2,
		min_height = 0,
		max_height = 2000
	})
	if dmobs.dragons then  --just divided chance by 4.
		mobs:spawn({name = "dmobs:dragon1", nodes = {"ethereal:fiery_dirt", "default:desert_sand", "group.desert_surface"}, neighbor = {},
			min_light = 5, max_light = 15, interval = 300, chance = 6000, active_object_count = 2, min_height = 0, max_height = 30000})
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
		nodes = {"default:dirt_with_grass","group:dirt"},
		min_light = 0,
		max_light = 7,
		chance = 6000,
		active_object_count = 2,
		min_height = 0,
		day_toggle = false,
	})
	-- minetest.log("ToChat:",	"Ran Mapper code." )   -- COMMENT THIS OUT **********
	-- Dungeon Master

	mobs:spawn({
		name = "mobs_monster:dungeon_master",
		nodes = {"default:stone", "group:cave_floor"},
		max_light = 7,  --5
		chance = 9000/spawn_chance_multiplier,
		active_object_count = 1,
		max_height = -70,
	})

	-- Lava Flan

	mobs:spawn({
		name = "mobs_monster:lava_flan",
		nodes = {"default:lava_source"},
		chance = 1500,
		active_object_count = 1,
		max_height = 0,
	})

	-- Mese Monster

	mobs:spawn({
		name = "mobs_monster:mese_monster",
		nodes = {"default:stone", "group:cave_floor"},
		max_light = 9,  --7
		chance = 5000/spawn_chance_multiplier,
		active_object_count = 1,
		max_height = -20,
	})

	-- Oerkki

	mobs:spawn({
		name = "mobs_monster:oerkki",
		nodes = {"default:stone", "group:cave_floor"},
		max_light = 9,  --7
		chance = 7000/spawn_chance_multiplier,
		max_height = -10,
	})

	-- Sand Monster

	mobs:spawn({
		name = "mobs_monster:sand_monster",
		nodes = {"default:desert_sand","group:desert_surface"},
		chance = 7000/spawn_chance_multiplier,
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
		chance = 7000,
		active_object_count = 1,
		min_height = 25,
		max_height = 31000,
	})

	-- Spider (below ground)
	mobs:spawn({
		name = "mobs_monster:spider",
		nodes = {"default:stone_with_mese", "default:mese", "default:stone", "group:cave_floor"},
		min_light = 0,
		max_light = 9, --7
		chance = 7000/spawn_chance_multiplier,
		active_object_count = 1,
		min_height = -31000,
		max_height = -40,
	})

	-- Stone Monster

	mobs:spawn({
		name = "mobs_monster:stone_monster",
		nodes = {"default:stone", "default:desert_stone", "default:sandstone", "group:cave_floor"},
		max_light = 9, --7
		chance = 7000/spawn_chance_multiplier,
		max_height = 0,
	})

	-- Tree Monster

	mobs:spawn({
		name = "mobs_monster:tree_monster",
		nodes = {"default:leaves", "default:jungleleaves"},
		max_light = 7,
		chance = 7000,
		min_height = 0,
		day_toggle = false,
	})

	else
		-- The "mobs_monster" mod is not enabled 
		print("The 'mobs_monster' mod is not enabled.")
end