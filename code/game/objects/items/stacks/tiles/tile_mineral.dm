/obj/item/stack/tile/mineral
	/// Determines what stack is gotten out of us when welded.
	var/mineralType = null

/obj/item/stack/tile/mineral/welder_act(mob/living/user, obj/item/tool)
	if(get_amount() < 4)
		to_chat(user, span_warning("你至少需要四块地砖才能这样做！"))
		return ITEM_INTERACT_BLOCKING
	if(!mineralType)
		to_chat(user, span_warning("你无法重新塑形这块地砖！"))
		stack_trace("A mineral tile of type [type] doesn't have its mineralType set.")
		return ITEM_INTERACT_BLOCKING
	if(!tool.use_tool(src, user, 0, volume=40))
		return ITEM_INTERACT_BLOCKING
	var/sheet_type = text2path("/obj/item/stack/sheet/mineral/[mineralType]")
	var/obj/item/stack/sheet/mineral/new_item = new sheet_type(user.drop_location())
	user.visible_message(span_notice("[user]用[tool]把[src]重新塑形成了[new_item]。"), \
						span_notice("你用[tool]把[src]重新塑形成了[new_item]。"), \
						span_hear("你听到了焊接声。"))
	var/holding = user.is_holding(src)
	use(4)
	if(holding && QDELETED(src))
		user.put_in_hands(new_item)
	return ITEM_INTERACT_SUCCESS

/obj/item/stack/tile/mineral/plasma
	name = "等离子地砖"
	singular_name = "等离子地砖"
	desc = "用极易燃烧的等离子制成的地砖。这肯定不会出事。"
	icon_state = "tile_plasma"
	inhand_icon_state = "tile-plasma"
	turf_type = /turf/open/floor/mineral/plasma
	mineralType = "plasma"
	mats_per_unit = list(/datum/material/plasma=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/plasma
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/plasma,
		/obj/item/stack/tile/mineral/plasma/tiled,
	)

/obj/item/stack/tile/mineral/plasma/tiled
	icon_state = "tile_plasma_tiled"
	turf_type = /turf/open/floor/mineral/plasma/tiled
	merge_type = /obj/item/stack/tile/mineral/plasma/tiled

/obj/item/stack/tile/mineral/uranium
	name = "铀地砖"
	singular_name = "铀地砖"
	desc = "用铀制成的地砖。你感到有点晕。"
	icon_state = "tile_uranium"
	inhand_icon_state = "tile-uranium"
	turf_type = /turf/open/floor/mineral/uranium
	mineralType = "uranium"
	mats_per_unit = list(/datum/material/uranium=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/uranium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/uranium,
		/obj/item/stack/tile/mineral/uranium/tiled,
	)

/obj/item/stack/tile/mineral/uranium/tiled
	icon_state = "tile_uranium_tiled"
	turf_type = /turf/open/floor/mineral/uranium/tiled
	merge_type = /obj/item/stack/tile/mineral/uranium/tiled

/obj/item/stack/tile/mineral/gold
	name = "黄金地砖"
	singular_name = "黄金地砖"
	desc = "用黄金制成的地砖，扑面而来一股豪气。"
	icon_state = "tile_gold"
	inhand_icon_state = "tile-gold"
	turf_type = /turf/open/floor/mineral/gold
	mineralType = "gold"
	mats_per_unit = list(/datum/material/gold=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/gold
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/gold,
		/obj/item/stack/tile/mineral/gold/tiled,
		/obj/item/stack/tile/mineral/gold/sun,
	)

/obj/item/stack/tile/mineral/gold/tiled
	icon_state = "tile_gold_tiled"
	turf_type = /turf/open/floor/mineral/gold/tiled
	merge_type = /obj/item/stack/tile/mineral/gold/tiled

/obj/item/stack/tile/mineral/gold/sun
	icon_state = "tile_gold_sun"
	desc = "饰有太阳图案的黄金地砖。"
	turf_type = /turf/open/floor/mineral/gold/sun
	merge_type = /obj/item/stack/tile/mineral/gold/sun

/obj/item/stack/tile/mineral/silver
	name = "白银地砖"
	singular_name = "白银地砖"
	desc = "用白银制成的地砖，闪得让人睁不开眼。"
	icon_state = "tile_silver"
	inhand_icon_state = "tile-silver"
	turf_type = /turf/open/floor/mineral/silver
	mineralType = "silver"
	mats_per_unit = list(/datum/material/silver=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/silver
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/silver,
		/obj/item/stack/tile/mineral/silver/tiled,
		/obj/item/stack/tile/mineral/silver/moon,
	)

/obj/item/stack/tile/mineral/silver/tiled
	icon_state = "tile_silver_tiled"
	turf_type = /turf/open/floor/mineral/silver/tiled
	merge_type = /obj/item/stack/tile/mineral/silver/tiled

/obj/item/stack/tile/mineral/silver/moon
	icon_state = "tile_silver_moon"
	desc = "饰有月亮图案的白银地砖。"
	turf_type = /turf/open/floor/mineral/silver/moon
	merge_type = /obj/item/stack/tile/mineral/silver/moon
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/mineral/diamond
	name = "钻石地砖"
	singular_name = "钻石地砖"
	desc = "用钻石制成的地砖。哇，真是，哇。"
	icon_state = "tile_diamond"
	inhand_icon_state = "tile-diamond"
	turf_type = /turf/open/floor/mineral/diamond
	mineralType = "diamond"
	mats_per_unit = list(/datum/material/diamond=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/diamond
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/diamond,
		/obj/item/stack/tile/mineral/diamond/tiled,
	)

/obj/item/stack/tile/mineral/diamond/tiled
	icon_state = "tile_diamond_tiled"
	turf_type = /turf/open/floor/mineral/diamond/tiled
	merge_type = /obj/item/stack/tile/mineral/diamond/tiled

/obj/item/stack/tile/mineral/bananium
	name = "香蕉矿地砖"
	singular_name = "香蕉矿地砖"
	desc = "用香蕉矿制成的防滑地砖，HOOOOOOOOONK！"
	icon_state = "tile_bananium"
	inhand_icon_state = "tile-bananium"
	turf_type = /turf/open/floor/mineral/bananium
	mineralType = "bananium"
	mats_per_unit = list(/datum/material/bananium=SHEET_MATERIAL_AMOUNT*0.25)
	material_flags = NONE //The slippery comp makes it unpractical for good clown decor. The material tiles should still slip.
	merge_type = /obj/item/stack/tile/mineral/bananium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/bananium,
		/obj/item/stack/tile/mineral/bananium/tiled,
	)

/obj/item/stack/tile/mineral/bananium/tiled
	icon_state = "tile_bananium_tiled"
	turf_type = /turf/open/floor/mineral/bananium/tiled
	merge_type = /obj/item/stack/tile/mineral/bananium/tiled

/obj/item/stack/tile/mineral/bluespace
	name = "蓝空间地砖"
	singular_name = "蓝空间地砖"
	desc = "用蓝空间水晶制成的地砖。随机传送领域的最新发明。"
	icon_state = "tile_bluespacecrystal"
	inhand_icon_state = "tile-bluespacecrystal"
	turf_type = /turf/open/floor/mineral/bluespace
	mineralType = "bluespace"
	mats_per_unit = list(/datum/material/bluespace=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/bluespace
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/bluespace,
		/obj/item/stack/tile/mineral/bluespace/tiled,
	)

/obj/item/stack/tile/mineral/bluespace/tiled
	icon_state = "tile_bluespacecrystal_tiled"
	turf_type = /turf/open/floor/mineral/bluespace/tiled
	merge_type = /obj/item/stack/tile/mineral/bluespace/tiled

/obj/item/stack/tile/mineral/telecrystal
	name = "传送水晶地砖"
	singular_name = "传送水晶地砖"
	desc = "用传送水晶制成的地砖。几乎可以肯定这是违法的。"
	icon_state = "tile_telecrystal"
	inhand_icon_state = "tile-telecrystal"
	turf_type = /turf/open/floor/mineral/telecrystal
	mineralType = "telecrystal"
	mats_per_unit = list(/datum/material/telecrystal=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/telecrystal
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/telecrystal,
		/obj/item/stack/tile/mineral/telecrystal/tiled,
	)

/obj/item/stack/tile/mineral/telecrystal/tiled
	icon_state = "tile_telecrystal_tiled"
	turf_type = /turf/open/floor/mineral/telecrystal/tiled
	merge_type = /obj/item/stack/tile/mineral/telecrystal/tiled

/obj/item/stack/tile/mineral/adamantine
	name = "精金地砖"
	singular_name = "精金地砖"
	desc = "用精金制成的地砖。工业风，魔像的最爱。"
	icon_state = "tile_adamantine"
	inhand_icon_state = "tile-adamantine"
	turf_type = /turf/open/floor/mineral/adamantine
	mineralType = "adamantine"
	mats_per_unit = list(/datum/material/adamantine=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/adamantine
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/adamantine,
		/obj/item/stack/tile/mineral/adamantine/tiled,
	)

/obj/item/stack/tile/mineral/adamantine/tiled
	icon_state = "tile_adamantine_tiled"
	turf_type = /turf/open/floor/mineral/adamantine/tiled
	merge_type = /obj/item/stack/tile/mineral/adamantine/tiled

/obj/item/stack/tile/mineral/metal_hydrogen
	name = "金属氢地砖"
	singular_name = "金属氢地砖"
	desc = "用金属氢制成的地砖。宛如漫步云端！"
	icon_state = "tile_metal_hydrogen"
	inhand_icon_state = "tile-metalhydrogen"
	turf_type = /turf/open/floor/mineral/metal_hydrogen
	mineralType = "metal hydrogen"
	mats_per_unit = list(/datum/material/metalhydrogen=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/metal_hydrogen
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/metal_hydrogen,
		/obj/item/stack/tile/mineral/metal_hydrogen/tiled,
	)

/obj/item/stack/tile/mineral/metal_hydrogen/tiled
	icon_state = "tile_metal_hydrogen_tiled"
	turf_type = /turf/open/floor/mineral/metal_hydrogen/tiled
	merge_type = /obj/item/stack/tile/mineral/metal_hydrogen/tiled

/obj/item/stack/tile/mineral/runite
	name = "符文矿地砖"
	singular_name = "符文矿地砖"
	desc = "用符文矿制成、颇具魔力的地砖。你觉得它的极性取决于魔法之风的风向。"
	icon_state = "tile_runite"
	inhand_icon_state = "tile-runite"
	turf_type = /turf/open/floor/mineral/runite
	mineralType = "runite"
	mats_per_unit = list(/datum/material/runite=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/runite
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/obj/item/stack/tile/mineral/runite/tiled
	icon_state = "tile_runite_tiled"
	turf_type = /turf/open/floor/mineral/runite/tiled
	merge_type = /obj/item/stack/tile/mineral/runite/tiled

/obj/item/stack/tile/mineral/mythril
	name = "秘银地砖"
	singular_name = "秘银地砖"
	desc = "Definetly the best use of such an legendary, unfathomable material."
	icon_state = "tile_mythril"
	inhand_icon_state = "tile-mythril"
	turf_type = /turf/open/floor/mineral/mythril
	mineralType = "mythril"
	mats_per_unit = list(/datum/material/mythril=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/mythril

/obj/item/stack/tile/mineral/mythril/tiled
	icon_state = "tile_mythril_tiled"
	turf_type = /turf/open/floor/mineral/mythril/tiled
	merge_type = /obj/item/stack/tile/mineral/mythril/tiled

/obj/item/stack/tile/mineral/sandstone
	name = "砂岩砖地砖"
	desc = "用砂岩制成的地砖。"
	icon_state = "sandstone_floor"
	inhand_icon_state = "tile-sandstone"
	mineralType = "sandstone"
	mats_per_unit = list(/datum/material/sandstone = HALF_SHEET_MATERIAL_AMOUNT / 2)
	turf_type = /turf/open/floor/sandstone
	merge_type = /obj/item/stack/tile/mineral/sandstone

/obj/item/stack/tile/mineral/stone
	name = "石砖地砖"
	desc = "用石头制成的地砖。"
	icon_state = "stone_floor"
	inhand_icon_state = "tile-stone"
	mineralType = "stone"
	mats_per_unit = list(/datum/material/rock = HALF_SHEET_MATERIAL_AMOUNT / 2)
	turf_type = /turf/open/floor/stone
	merge_type = /obj/item/stack/tile/mineral/stone

/obj/item/stack/tile/mineral/abductor
	name = "外星地砖"
	singular_name = "外星地砖"
	desc = "用外星合金制成的地砖。"
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "tile_abductor"
	inhand_icon_state = "tile-abductor"
	mats_per_unit = list(/datum/material/alloy/alien=SHEET_MATERIAL_AMOUNT*0.25)
	turf_type = /turf/open/floor/mineral/abductor
	mineralType = "abductor"
	merge_type = /obj/item/stack/tile/mineral/abductor

/obj/item/stack/tile/mineral/titanium
	name = "钛地砖"
	singular_name = "钛地砖"
	desc = "用于穿梭机的光滑钛地砖。"
	icon_state = "tile_titanium"
	inhand_icon_state = "tile-shuttle"
	turf_type = /turf/open/floor/mineral/titanium
	mineralType = "titanium"
	mats_per_unit = list(/datum/material/titanium=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/titanium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/titanium,
		/obj/item/stack/tile/mineral/titanium/yellow,
		/obj/item/stack/tile/mineral/titanium/blue,
		/obj/item/stack/tile/mineral/titanium/white,
		/obj/item/stack/tile/mineral/titanium/purple,
		/obj/item/stack/tile/mineral/titanium/tiled,
		/obj/item/stack/tile/mineral/titanium/tiled/yellow,
		/obj/item/stack/tile/mineral/titanium/tiled/blue,
		/obj/item/stack/tile/mineral/titanium/tiled/white,
		/obj/item/stack/tile/mineral/titanium/tiled/purple,
		)

/obj/item/stack/tile/mineral/titanium/yellow
	name = "黄色钛地砖"
	singular_name = "黄色钛地砖"
	desc = "用于穿梭机的光滑黄色钛地砖。"
	turf_type = /turf/open/floor/mineral/titanium/yellow
	icon_state = "tile_titanium_yellow"
	merge_type = /obj/item/stack/tile/mineral/titanium/yellow

/obj/item/stack/tile/mineral/titanium/blue
	name = "蓝色钛地砖"
	singular_name = "蓝色钛地砖"
	desc = "用于穿梭机的光滑蓝色钛地砖。"
	turf_type = /turf/open/floor/mineral/titanium/blue
	icon_state = "tile_titanium_blue"
	merge_type = /obj/item/stack/tile/mineral/titanium/blue

/obj/item/stack/tile/mineral/titanium/white
	name = "白色钛地砖"
	singular_name = "白色钛地砖"
	desc = "用于穿梭机的光滑白色钛地砖。"
	turf_type = /turf/open/floor/mineral/titanium/white
	icon_state = "tile_titanium_white"
	merge_type = /obj/item/stack/tile/mineral/titanium/white

/obj/item/stack/tile/mineral/titanium/purple
	name = "紫色钛地砖"
	singular_name = "紫色钛地砖"
	desc = "用于穿梭机的光滑紫色钛地砖。"
	turf_type = /turf/open/floor/mineral/titanium/purple
	icon_state = "tile_titanium_purple"
	merge_type = /obj/item/stack/tile/mineral/titanium/purple

/obj/item/stack/tile/mineral/titanium/tiled
	name = "方格钛地砖"
	singular_name = "方格钛地砖"
	desc = "用于穿梭机的钛地砖。"
	turf_type = /turf/open/floor/mineral/titanium/tiled
	icon_state = "tile_titanium_tiled"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled

/obj/item/stack/tile/mineral/titanium/tiled/yellow
	name = "黄色钛地砖"
	singular_name = "黄色钛地砖"
	desc = "用于穿梭机的黄色钛地砖。"
	turf_type = /turf/open/floor/mineral/titanium/tiled/yellow
	icon_state = "tile_titanium_tiled_yellow"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/yellow

/obj/item/stack/tile/mineral/titanium/tiled/blue
	name = "蓝色钛地砖"
	singular_name = "蓝色钛地砖"
	desc = "用于穿梭机的蓝色钛地砖。"
	turf_type = /turf/open/floor/mineral/titanium/tiled/blue
	icon_state = "tile_titanium_tiled_blue"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/blue

/obj/item/stack/tile/mineral/titanium/tiled/white
	name = "白色钛地砖"
	singular_name = "白色钛地砖"
	desc = "用于穿梭机的白色钛地砖。"
	turf_type = /turf/open/floor/mineral/titanium/tiled/white
	icon_state = "tile_titanium_tiled_white"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/white

/obj/item/stack/tile/mineral/titanium/tiled/purple
	name = "紫色钛地砖"
	singular_name = "紫色钛地砖"
	desc = "用于穿梭机的紫色钛地砖。"
	turf_type = /turf/open/floor/mineral/titanium/tiled/purple
	icon_state = "tile_titanium_tiled_purple"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/purple

/obj/item/stack/tile/mineral/plastitanium
	name = "等离子钛地砖"
	singular_name = "等离子钛地砖"
	desc = "用等离子钛制成的地砖，供十分邪恶的穿梭机使用。"
	icon_state = "tile_plastitanium"
	inhand_icon_state = "tile-darkshuttle"
	turf_type = /turf/open/floor/mineral/plastitanium
	mineralType = "plastitanium"
	mats_per_unit = list(/datum/material/alloy/plastitanium=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/plastitanium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/plastitanium,
		/obj/item/stack/tile/mineral/plastitanium/red,
		/obj/item/stack/tile/mineral/plastitanium/pod,
		/obj/item/stack/tile/mineral/plastitanium/pod/light,
		/obj/item/stack/tile/mineral/plastitanium/pod/dark,
		/obj/item/stack/tile/mineral/plastitanium/pod/red,
		/obj/item/stack/tile/mineral/plastitanium/pod/redlight,
		)

/obj/item/stack/tile/mineral/plastitanium/red
	name = "红色等离子钛地砖"
	singular_name = "红色等离子钛地砖"
	desc = "用等离子钛制成的地砖，供红得耀眼的穿梭机使用。"
	turf_type = /turf/open/floor/mineral/plastitanium/red
	icon_state = "tile_plastitanium_red"
	merge_type = /obj/item/stack/tile/mineral/plastitanium/red

/obj/item/stack/tile/mineral/plastitanium/pod
	name = "舱室地砖"
	singular_name = "舱室地砖"
	desc = "带凹槽的地砖。"
	icon_state = "tile_pod"
	inhand_icon_state = "tile-pod"
	turf_type = /turf/open/floor/mineral/plastitanium/pod
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod

/obj/item/stack/tile/mineral/plastitanium/pod/light
	name = "浅色舱室地砖"
	singular_name = "浅色舱室地砖"
	desc = "带凹槽的浅色地砖。"
	icon_state = "tile_podlight"
	turf_type = /turf/open/floor/mineral/plastitanium/pod/light
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod/light

/obj/item/stack/tile/mineral/plastitanium/pod/dark
	name = "深色舱室地砖"
	singular_name = "深色舱室地砖"
	desc = "带凹槽的深色地砖。"
	icon_state = "tile_poddark"
	turf_type = /turf/open/floor/mineral/plastitanium/pod/dark
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod/dark

/obj/item/stack/tile/mineral/plastitanium/pod/red
	name = "红色舱室地砖"
	singular_name = "红色舱室地砖"
	desc = "带凹槽的红色地砖。"
	icon_state = "tile_pod_red"
	turf_type = /turf/open/floor/mineral/plastitanium/pod/red
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod/red

/obj/item/stack/tile/mineral/plastitanium/pod/redlight
	name = "浅红色舱室地砖"
	singular_name = "浅红色舱室地砖"
	desc = "带凹槽的浅红色地砖。"
	icon_state = "tile_podlight_red"
	turf_type = /turf/open/floor/mineral/plastitanium/pod/redlight
	merge_type = /obj/item/stack/tile/mineral/plastitanium/pod/redlight

/obj/item/stack/tile/mineral/snow
	name = "雪地砖"
	singular_name = "雪地砖"
	desc = "一层积雪。"
	icon_state = "tile_snow"
	inhand_icon_state = "tile-silver"
	turf_type = /turf/open/floor/fake_snow
	mineralType = "snow"
	merge_type = /obj/item/stack/tile/mineral/snow
	mats_per_unit = list(/datum/material/snow = HALF_SHEET_MATERIAL_AMOUNT / 2)
