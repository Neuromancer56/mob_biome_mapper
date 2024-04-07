
local function addGroupToNode(modname, nodename, groupname)

    if minetest.get_modpath(modname) then
        local node_def = minetest.registered_nodes[modname .. ":" .. nodename]

        if node_def then
            node_def.groups[groupname] = 1
            minetest.override_item(modname .. ":" .. nodename, { groups = node_def.groups })
			--*********Log info about groups node belongs to. COMMENT THIS OUT **********
			 --minetest.log("nodeinfo:", "nodeinfo:" .. nodename)
			 for group, value in pairs(node_def.groups) do
			 -- Log each item using minetest.log()
			 --minetest.log("groups:", "group: " .. group .. ", value: " .. value)
			 end
			--*********************************************************  
        end

	end
end

function getNodesByGroup(group)
    --local nodes = {}
    for name, def in pairs(minetest.registered_nodes) do
        if def.groups and def.groups[group] then
           -- table.insert(nodes, name)
		  -- minetest.log("ToChat:", "group:" ..group .. " nodename:".. name)
        end
    end
    return nodes
end

local function groupsToNodes()
	if minetest.get_modpath("australia") then
		addGroupToNode("australia", "red_sand", "desert_surface")
		addGroupToNode("australia", "red_gravel", "desert_surface")
		addGroupToNode("australia", "dirt_with_dry_grass", "desert_surface")
		addGroupToNode("australia", "stone_kelp_brown", "australia_ocean")
		addGroupToNode("default", "sand", "australia_ocean")
	end
	if minetest.get_modpath("boulder_dig") then
		addGroupToNode("default", "dirt", "boulder_dig")
		addGroupToNode("default", "dry_dirt", "boulder_dig")
	end
	if minetest.get_modpath("br_core") then
		br_core.node_colors = {
			black =     { main="#334",    alt="#556",    outline="#556",    highlight="#444455", lowlight="#112"   , raw="#445"},
			dark_grey = { main="#556",    alt="#a97",    outline="#778",    highlight="#666677", lowlight="#445"   , raw="#77777e"},
			grey =      { main="#889",    alt="#fff",    outline="#99a",    highlight="#9999aa", lowlight="#668"   , raw="#838397"},
			light_grey ={ main="#aab",    alt="#fff",    outline="#ccd",    highlight="#bbbbcc", lowlight="#88a"   , raw="#9b9ba4"},
			white =     { main="#eee",    alt="#99a",    outline="#fff",    highlight="#ffffff", lowlight="#dde"   , raw="#f6eeee"},
			red =       { main="#e15d55", alt="#fff",    outline="#cc8c7e", highlight="#e97b74", lowlight="#c35350", raw="#b5b5c0"},
			dark_red =  { main="#641d2b", alt="#fff",    outline="#daa",    highlight="#742d3b", lowlight="#54171b", raw="#6d6d73"},
			orange =    { main="#b85",    alt="#778",    outline="#a75",    highlight="#cc9966", lowlight="#a75"   , raw="#888899"},
			rust =      { main="#756052", alt="#fff",    outline="#877263", highlight="#877767", lowlight="#655052", raw="#6d6d73"},
			green =     { main="#4d7953", alt="#fff",    outline="#8c8b7d", highlight="#838962", lowlight="#4a7553", raw="#77777e"},
			blue =      { main="#478",    alt="#fff",    outline="#799598", highlight="#558899", lowlight="#367"   , raw="#b5b5c0"},
			yellow =    { main="#c5b794", alt="#d9d8c4", outline="#ddc",    highlight="#d5c7a4", lowlight="#b5a784", raw="#b5b5c0"},
		}
		addGroupToNode("br_core", "carpet_0", "backroom")
		addGroupToNode("br_core", "grass", "backroom")
		addGroupToNode("br_core", "catwalk_WE", "backroom")
		addGroupToNode("br_core", "catwalk_stair", "backroom")
		addGroupToNode("br_core", "catwalk", "backroom")
		for variant, color in pairs(br_core.node_colors) do
			addGroupToNode("br_core", "concrete_"..variant, "backroom")
			addGroupToNode("br_core", "carpet_"..variant, "backroom")
			addGroupToNode("br_core", "concrete_"..variant.."_ls", "backroom")
			addGroupToNode("br_core", "concrete_dirty_"..variant, "backroom")
			addGroupToNode("br_core", "concrete_ruined_"..variant, "backroom")
		end
		for i=0, 2 do
			addGroupToNode("br_core", "pool_tiles_"..i, "backroom")
		end
	end
	if minetest.get_modpath("caverealms") then
		addGroupToNode("caverealms", "stone_with_salt", "cave_floor")
		addGroupToNode("caverealms", "stone_with_moss", "cave_floor")
		addGroupToNode("caverealms", "stone_with_lichen", "cave_floor")
	end
	addGroupToNode("default", "desert_stone", "desert_cave")
	addGroupToNode("default", "sandstone", "desert_cave")
	addGroupToNode("default", "desert_sand", "desert_surface")
	addGroupToNode("default", "dry_dirt_with_dry_grass", "dirt")
	addGroupToNode("default", "dry_dirt_with_dry_grass", "savanna_dirt")
	addGroupToNode("default", "permafrost", "frozen_surface")
	addGroupToNode("default", "permafrost_with_moss", "frozen_surface")
	addGroupToNode("default", "permafrost_with_stone", "frozen_surface")
	addGroupToNode("default", "dirt_with_rainforest_litter", "rainforest")
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
	if minetest.get_modpath("hero_mines") then
		addGroupToNode("default", "stone", "hero_mine")
		addGroupToNode("default", "desert_stone", "hero_mine")
		addGroupToNode("default", "sandstone", "hero_mine")
	end
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
	if minetest.get_modpath("swamp") then
		addGroupToNode("swamp", "dirt_with_swamp_grass", "swamp")
		addGroupToNode("swamp", "mud", "swamp")
		addGroupToNode("swamp", "muddy_mud", "swamp")
		addGroupToNode("swamp", "root_with_mud", "swamp")
	end
	if minetest.get_modpath("swaz") then
		addGroupToNode("swaz", "silt_with_grass", "swamp")
		addGroupToNode("swaz", "mud_with_moss", "swamp")
		addGroupToNode("swaz", "mud", "swamp")
	end

	--begin variety modpack--
	if minetest.get_modpath("variety") then
		addGroupToNode("variety", "autumn_forest_grass", "forest")
		addGroupToNode("variety", "japanese_dirt_with_grass", "japanese_forest")
		addGroupToNode("variety", "cherry_dirt_with_grass", "japanese_forest")
		addGroupToNode("variety", "dirt_with_bamboo", "bamboo_ground")
		addGroupToNode("variety", "darkforest_dirt_with_grass", "forest")
		--Need to add the following biomes
		--cypress uses japanese_dirt_with_grass
		--grasslands  could be more than one biome
		--mountain
		addGroupToNode("variety", "tropical_rainforest_dirt_with_grass", "rainforest")
		addGroupToNode("variety", "frost_land_grass", "frozen_surface")
		--addGroupToNode("variety", "frost_land_grass", "frozen_surface")
		--addGroupToNode("terracotta", "terracotta_1", "desert_surface")
		addGroupToNode("variety", "redwood_dirt_with_grass", "redwood")
		addGroupToNode("variety", "meadow_dirt_with_grass", "forest")
		addGroupToNode("variety", "dorwinion_grass", "forest")

		--addGroupToNode("nightshade", "nightshade_dirt_with_grass", "forest")
		--addGroupToNode("alurios_forest", "alurios_forest_dirt_with_alurios_forest_grass", "forest")
	end
	--end variety modpack--

	-- getNodesByGroup("bamboo_ground")
	-- getNodesByGroup("swamp")
	-- getNodesByGroup("backroom")
	-- minetest.log("ToChat:", "ranGroupToNodes:")
end

groupsToNodes()
