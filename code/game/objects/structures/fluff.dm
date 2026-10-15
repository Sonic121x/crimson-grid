/**
 * # Fluff structure
 *
 * Fluff structures serve no purpose and exist only for enriching the environment. By default, they can be deconstructed with a wrench.
 */
/obj/structure/fluff
	name = "装饰建筑"
	desc = "比绵羊还毛茸茸。这东西不该存在。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "minibar"
	anchored = TRUE
	density = FALSE
	opacity = FALSE
	///If true, the structure can be deconstructed into a metal sheet with a wrench.
	var/deconstructible = TRUE

/obj/structure/fluff/wrench_act(mob/living/user, obj/item/tool)
	if(!deconstructible)
		return ITEM_INTERACT_SKIP_TO_ATTACK
	user.visible_message(span_notice("[user]开始拆卸[src]……"), \
						span_notice("你开始拆卸[src]……"))
	tool.play_tool_sound(src)
	if(!tool.use_tool(src, user, 50))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_notice("[user]拆掉了[src]！"), span_notice("你把[src]拆成了废金属。"))
	playsound(user, 'sound/items/deconstruct.ogg', 50, TRUE)
	new/obj/item/stack/sheet/iron(drop_location())
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/**
 * Empty terrariums are created when a preserved terrarium in a lavaland seed vault is activated.
 */
/obj/structure/fluff/empty_terrarium
	name = "空植物培养箱"
	desc = "一台似乎用于储存植物材料的古老机器。舱门半开着。"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "terrarium_open"
	density = TRUE

/**
 * Empty sleepers are created by a good few ghost roles in lavaland.
 */
/obj/structure/fluff/empty_sleeper
	name = "空休眠舱"
	desc = "一台打开的休眠舱。若不是已经损坏，看起来就像在等待下一位病人。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-open"

/obj/structure/fluff/empty_sleeper/nanotrasen
	name = "损坏的深度休眠舱"
	desc = "一台纳诺传讯深度休眠舱，似乎已经损坏。\
		外露的螺栓便于用扳手拆卸。"
	icon_state = "sleeper-o"

/obj/structure/fluff/empty_sleeper/syndicate
	icon_state = "sleeper_s-open"

/**
 * Empty cryostasis sleepers are created when a malfunctioning cryostasis sleeper in a lavaland shelter is activated.
 */
/obj/structure/fluff/empty_cryostasis_sleeper
	name = "空低温休眠舱"
	desc = "虽然很舒服，但这台休眠舱以后只能当床用了。"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "cryostasis_sleeper_open"

/**
 * Ash drake status spawn on either side of the necropolis gate in lavaland.
 */
/obj/structure/fluff/drake_statue
	name = "飞龙雕像"
	desc = "一座高耸的玄武岩雕像，刻画着一条傲然威严的飞龙。六颗发光宝石构成了它的眼睛。"
	icon = 'icons/effects/64x64.dmi'
	icon_state = "drake_statue"
	pixel_x = -16
	maptext_height = 64
	maptext_width = 64
	density = TRUE
	deconstructible = FALSE
	layer = EDGED_TURF_LAYER

/**
 * shower drain placed usually under showers just so it looks like something picks the water up.
 */
/obj/structure/fluff/shower_drain
	name = "淋浴排水口"
	desc = "呕，我好像看见了一团头发。"
	icon = 'icons/obj/mining_zones/survival_pod.dmi'
	icon_state = "fan_tiny"
	plane = FLOOR_PLANE
	layer = BELOW_CATWALK_LAYER

/**
 * A variety of statue in disrepair; parts are broken off and a gemstone is missing
 */
/obj/structure/fluff/drake_statue/falling
	desc = "一座高耸的玄武岩飞龙雕像。表面布满裂缝，部分碎块已经脱落。"
	icon_state = "drake_statue_falling"


/obj/structure/fluff/bus
	name = "巴士"
	desc = "去上学。读点书。"
	icon = 'icons/obj/fluff/bus.dmi'
	icon_state = null
	density = TRUE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/bus/dense
	name = "巴士"
	icon_state = "backwall"

/obj/structure/fluff/bus/passable
	name = "巴士"
	icon_state = "frontwalltop"
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER //except for the stairs tile, which should be set to OBJ_LAYER aka 3.
	plane = ABOVE_GAME_PLANE


/obj/structure/fluff/bus/passable/seat
	name = "座椅"
	desc = "系好安全带！……你说什么，没有安全带？！"
	icon_state = "backseat"
	pixel_y = 17
	layer = OBJ_LAYER
	plane = GAME_PLANE


/obj/structure/fluff/bus/passable/seat/driver
	name = "驾驶座"
	desc = "太空耶稣坐在我的副驾驶座上。"
	icon_state = "driverseat"

/obj/structure/fluff/bus/passable/seat/driver/attack_hand(mob/user, list/modifiers)
	playsound(src, 'sound/items/carhorn.ogg', 50, TRUE)
	. = ..()

/obj/structure/fluff/paper
	name = "密密麻麻的纸张"
	desc = "沿墙脚散落的一片纸张。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "paper"
	deconstructible = FALSE

/obj/structure/fluff/paper/corner
	icon_state = "papercorner"

/obj/structure/fluff/paper/stack
	name = "厚厚的纸堆"
	desc = "一摞各式各样的纸，每页都散布着稚拙的涂鸦。"
	icon_state = "paperstack"


/obj/structure/fluff/divine
	name = "神迹"
	icon = 'icons/obj/service/hand_of_god_structures.dmi'
	icon_state = "error"
	anchored = TRUE
	density = TRUE

/obj/structure/fluff/divine/nexus
	name = "神力枢纽"
	desc = "它将一位神明锚定于这个世界，散发着异样的气息。看起来对爆炸冲击有很好的防护。"
	icon_state = "nexus"

/obj/structure/fluff/divine/conduit
	name = "神力导管"
	desc = "它让神明得以延伸影响范围。在导管附近，神力与在枢纽附近一样强大。"
	icon_state = "conduit"

/obj/structure/fluff/divine/convertaltar
	name = "皈依祭坛"
	desc = "一座供奉某位神明的祭坛。"
	icon_state = "convertaltar"
	density = FALSE
	can_buckle = 1

/obj/structure/fluff/divine/powerpylon
	name = "神力塔"
	desc = "一座加快神明施加影响、干预世界的塔。"
	icon_state = "powerpylon"
	can_buckle = 1

/obj/structure/fluff/divine/defensepylon
	name = "防御塔"
	desc = "一座受到祝福的塔，能承受多次打击，并向不信者发射强力光矢。神明可以控制其开关。"
	icon_state = "defensepylon"

/obj/structure/fluff/divine/shrine
	name = "神龛"
	desc = "一座供奉某位神明的神龛。"
	icon_state = "shrine"

/obj/structure/fluff/fokoff_sign
	name = "粗制标牌"
	desc = "一块制作粗糙的标牌，上面用某种红色颜料写着“滚犊字”。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "fokof"

/obj/structure/fluff/big_chain
	name = "巨型锁链"
	desc = "一条高高延伸至天花板的巨大锁链。"
	icon = 'icons/effects/32x96.dmi'
	icon_state = "chain"
	anchored = TRUE
	density = TRUE
	deconstructible = FALSE
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE

/obj/structure/fluff/beach_towel
	name = "沙滩巾"
	desc = "一条饰有各种沙滩主题图案的毛巾。"
	icon = 'icons/obj/railings.dmi'
	icon_state = "railing"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/beach_umbrella
	name = "沙滩遮阳伞"
	desc = "一把漂亮的遮阳伞，专为沙滩游客遮挡烈日。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "brella"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/beach_umbrella/security
	icon_state = "hos_brella"

/obj/structure/fluff/beach_umbrella/science
	icon_state = "rd_brella"

/obj/structure/fluff/beach_umbrella/engine
	icon_state = "ce_brella"

/obj/structure/fluff/beach_umbrella/cap
	icon_state = "cap_brella"

/obj/structure/fluff/beach_umbrella/syndi
	icon_state = "syndi_brella"

/obj/structure/fluff/clockwork
	name = "发条装饰物"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "error"
	deconstructible = FALSE

/obj/structure/fluff/clockwork/alloy_shards
	name = "自复制合金碎片"
	desc = "某种异常柔韧金属的碎片。它们偶尔会动，似乎还会发光。"
	icon_state = "alloy_shards"

/obj/structure/fluff/clockwork/alloy_shards/small
	icon_state = "shard_small1"

/obj/structure/fluff/clockwork/alloy_shards/medium
	icon_state = "shard_medium1"

/obj/structure/fluff/clockwork/alloy_shards/medium_gearbit
	icon_state = "gear_bit1"

/obj/structure/fluff/clockwork/alloy_shards/large
	icon_state = "shard_large1"

/obj/structure/fluff/clockwork/blind_eye
	name = "失明之眼"
	desc = "一只沉重的黄铜眼球，红色虹膜已黯淡无光。"
	icon_state = "blind_eye"

/obj/structure/fluff/clockwork/fallen_armor
	name = "残破护甲"
	desc = "毫无生气的护甲残片。设计古怪，穿不到你身上。"
	icon_state = "fallen_armor"

/obj/structure/fluff/clockwork/clockgolem_remains
	name = "发条魔像残骸"
	desc = "一堆废金属，似乎已经损坏到无法修复。"
	icon_state = "clockgolem_dead"

/obj/structure/fluff/tram_rail
	name = "电车轨道"
	desc = "很适合电车，不太适合滑行。"
	icon = 'modular_darkpack/master_files/icons/obj/tram/tram_rails.dmi' // DARKPACK EDIT CHANGE - Doesnt have directionals by default
	icon_state = "rail"
	layer = TRAM_RAIL_LAYER
	plane = FLOOR_PLANE
	resistance_flags =  INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	deconstructible = FALSE
	can_buckle = TRUE
	buckle_requires_restraints = TRUE
	buckle_lying = 90

/obj/structure/fluff/tram_rail/post_buckle_mob(mob/living/target)
	. = ..()
	target.pixel_y += dir == SOUTH ? -3 : 14
	RegisterSignal(target, COMSIG_LIVING_HIT_BY_TRAM, PROC_REF(on_buckled_tram_smashed))

/obj/structure/fluff/tram_rail/post_unbuckle_mob(mob/living/target)
	. = ..()
	target.pixel_y -= dir == SOUTH ? -3 : 14
	UnregisterSignal(target, COMSIG_LIVING_HIT_BY_TRAM)

/// If someone gets hit by the tram while buckled to us (mission accomplished) unbuckle them so that they can fly away
/// Also we rip one of their arms off to "uncuff" them
/obj/structure/fluff/tram_rail/proc/on_buckled_tram_smashed(mob/living/smashed)
	SIGNAL_HANDLER
	unbuckle_mob(smashed, force = TRUE, can_fall = FALSE) // Make sure they don't fall down a z-level until they've been thrown

/obj/structure/fluff/tram_rail/floor
	name = "电车轨道防护盖"
	icon_state = "rail_floor"

/obj/structure/fluff/tram_rail/end
	icon_state = "railend"

/obj/structure/fluff/tram_rail/anchor
	name = "电车轨道固定座"
	icon_state = "anchor"

/obj/structure/fluff/tram_rail/electric
	desc = "很适合电车，不太适合滑行。这条是供电轨。"
	/// What power channel from the APC do we check for power?
	var/power_channel = AREA_USAGE_ENVIRON

/obj/structure/fluff/tram_rail/electric/anchor
	name = "电车轨道固定座"
	icon_state = "anchor"

/obj/structure/fluff/tram_rail/electric/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/electrified_buckle,\
		input_requirements = SHOCK_REQUIREMENT_AREA_POWER,\
		shock_immediately = TRUE,\
		print_message = FALSE,\
		damage_on_shock = 5,\
		loop_length = 8 SECONDS,\
		area_power_channel = power_channel,\
		shock_flags = SHOCK_NOSTUN\
	)

/obj/structure/fluff/tram_rail/electric/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/area/our_area = get_area(src)
	if(our_area?.powered(power_channel) && user.electrocute_act(75, src))
		do_sparks(5, TRUE, src)

/obj/structure/fluff/broken_canister_frame
	name = "破损气罐框架"
	desc = "一只破裂的气罐。看起来可以用扳手回收一些金属。"
	icon_state = "broken_canister"
	anchored = FALSE
	density = TRUE
	deconstructible = TRUE

/obj/structure/fluff/wallsign
	name = "指路牌"
	desc = "那么，该往哪儿走？"
	density = FALSE
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "wallsign"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/wallsign, 32)
