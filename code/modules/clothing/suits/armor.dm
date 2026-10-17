/obj/item/clothing/suit/armor
	name = "护甲"
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	abstract_type = /obj/item/clothing/suit/armor
	allowed = null
	body_parts_covered = CHEST
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	max_integrity = 250
	resistance_flags = NONE
	armor_type = /datum/armor/suit_armor

/datum/armor/suit_armor
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/armor/Initialize(mapload)
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/armor/apply_fantasy_bonuses(bonus)
	. = ..()
	slowdown = modify_fantasy_variable("slowdown", slowdown, -bonus * 0.1, 0)
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()

/obj/item/clothing/suit/armor/remove_fantasy_bonuses(bonus)
	slowdown = reset_fantasy_variable("slowdown", slowdown)
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()
	return ..()

/obj/item/clothing/suit/armor/vest
	name = "防护背心"
	desc = "轻薄的I型防护背心，能对大多数类型的伤害提供良好防护。"
	icon_state = "armoralt"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back/armorvest

/obj/item/clothing/suit/armor/vest/alt
	desc = "I型防护背心，能对大多数类型的伤害提供良好防护。"
	icon_state = "armor"
	inhand_icon_state = "armor"

/obj/item/clothing/suit/armor/vest/alt/sec
	icon_state = "armor_sec"

/obj/item/clothing/suit/armor/vest/press
	name = "记者防护背心"
	desc = "用于标识<i>非战斗人员</i>\"记者\"的蓝色防护背心，说得好像有人在乎似的。"
	icon_state = "armor_press"

/obj/item/clothing/suit/armor/vest/press/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/obj/item/clothing/suit/armor/vest/marine
	name = "战术防护背心"
	desc = "由顶级量产冲压等离子钢装甲板组成，内置环境防护单元，让你在各种环境下都能踹门。"
	icon_state = "marine_command"
	inhand_icon_state = "armor"
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/vest_marine
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF

/datum/armor/vest_marine
	melee = 50
	bullet = 50
	laser = 30
	energy = 25
	bomb = 50
	bio = 100
	fire = 40
	acid = 50
	wound = 20

/datum/armor/pmc
	melee = 40
	bullet = 50
	laser = 60
	energy = 50
	bomb = 50
	bio = 100
	acid = 50
	wound = 20

/obj/item/clothing/suit/armor/vest/marine/security
	name = "大型战术防护背心"
	icon_state = "marine_security"

/obj/item/clothing/suit/armor/vest/marine/engineer
	name = "战术多用途防护背心"
	icon_state = "marine_engineer"

/obj/item/clothing/suit/armor/vest/marine/medic
	name = "战术医护防护背心"
	icon_state = "marine_medic"
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/armor/vest/marine/pmc
	desc = "由顶级量产冲压等离子钢装甲板组成，踹门揍人样样在行。虽然不适合太空环境，但卓越的生存能力足以弥补这一点。"
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	clothing_flags = THICKMATERIAL
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/pmc

/obj/item/clothing/suit/armor/vest/old
	name = "老化防护背心"
	desc = "老一代I型防护背心。由于年久老化，穿着它行动远不如以前灵活。"
	icon_state = "armor"
	inhand_icon_state = "armor"
	slowdown = 1

/obj/item/clothing/suit/armor/vest/blueshirt
	name = "大型护甲背心"
	desc = "一件宽大而舒适的护甲，能抵御部分威胁。"
	icon_state = "blueshift"
	inhand_icon_state = null
	custom_premium_price = PAYCHECK_COMMAND

/obj/item/clothing/suit/armor/vest/cuirass
	name = "胸甲"
	desc = "较轻的板甲，能挡住恼人的箭矢，同时保持行动能力。"
	icon_state = "cuirass"
	inhand_icon_state = "armor"
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/cuirass/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_ARMOR_RUSTLE, 8)

/obj/item/clothing/suit/armor/hos
	name = "装甲军大衣"
	desc = "以特殊合金增强的军大衣，为自有威严的人提供额外防护与风度。"
	icon_state = "hos"
	inhand_icon_state = "greatcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor_type = /datum/armor/armor_hos
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	strip_delay = 8 SECONDS

/datum/armor/armor_hos
	melee = 30
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 70
	acid = 90
	wound = 10

/obj/item/clothing/suit/armor/hos/trenchcoat
	name = "装甲风衣"
	desc = "以特殊轻质凯夫拉增强的风衣，战术便装的典范。"
	icon_state = "hostrench"
	inhand_icon_state = "hostrench"
	flags_inv = 0
	strip_delay = 8 SECONDS

/obj/item/clothing/suit/armor/hos/trenchcoat/winter
	name = "安保主管冬季风衣"
	desc = "以特殊轻质凯夫拉增强的风衣，领口和内侧衬有羊毛。穿上它，你会感到一种莫名的孤独。"
	icon_state = "hoswinter"
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/armor/hos/hos_formal
	name = "\improper 安保主管阅兵夹克"
	desc = "当防护背心还不够时髦时，就穿它。"
	icon_state = "hosformal"
	inhand_icon_state = "hostrench"
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/suit/armor/hos/hos_formal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/armor/vest/warden
	name = "典狱长夹克"
	desc = "一件海军蓝装甲夹克，肩部带有蓝色标识，其中一个胸前口袋上绣着'/典狱长/'。"
	icon_state = "warden_alt"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	strip_delay = 7 SECONDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/warden/alt
	name = "典狱长装甲夹克"
	desc = "一件带有银色衔星的红夹克，外面绑着护甲。"
	icon_state = "warden_jacket"

/obj/item/clothing/suit/armor/vest/secjacket
	name = "安保夹克"
	desc = "采用安保红色配色的红夹克，遍布高可视度反光条。"
	icon_state = "secjacket"
	inhand_icon_state = "armor"
	armor_type = /datum/armor/armor_secjacket
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/secjacket/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/datum/armor/armor_secjacket //Gotta compensate those extra covered limbs
	melee = 25
	bullet = 25
	laser = 25
	energy = 35
	bomb = 20
	fire = 30
	acid = 30
	wound = 5

/obj/item/clothing/suit/armor/vest/leather
	name = "安保大衣"
	desc = "供高级安保人员日常穿着的轻装甲皮大衣，饰有纳诺传讯安保徽章。"
	icon_state = "leathercoat-sec"
	inhand_icon_state = "hostrench"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/capcarapace
	name = "船长胸甲"
	desc = "防火装甲胸甲，以陶瓷板和等离子钢肩甲强化，在提供额外防护的同时保留最大程度的机动性与灵活性。只配发给空间站最优秀的人，不过确实有些磨乳头。"
	icon_state = "capcarapace"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN
	armor_type = /datum/armor/vest_capcarapace
	dog_fashion = null
	resistance_flags = FIRE_PROOF

/datum/armor/vest_capcarapace
	melee = 50
	bullet = 40
	laser = 50
	energy = 50
	bomb = 25
	fire = 100
	acid = 90
	wound = 10

/obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	name = "辛迪加船长背心"
	desc = "套在黑红防火夹克外的不祥先进装甲背心。金色领口和肩饰表明，它属于一名辛迪加高级军官。"
	icon_state = "syndievest"

/obj/item/clothing/suit/armor/vest/capcarapace/captains_formal
	name = "船长阅兵大衣"
	desc = "当防护背心还不够时髦时，就穿它。"
	icon_state = "capformal"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/captains_formal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/armor/riot
	name = "防暴服"
	desc = "半柔性聚碳酸酯护甲，配有厚实衬垫以抵御近战攻击，并帮助穿戴者在近距离对抗中抵抗推搡。"
	icon_state = "riot"
	inhand_icon_state = "swat_suit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/armor_riot
	strip_delay = 8 SECONDS
	equip_delay_other = 6 SECONDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)
	/// Type of texture applied by this
	var/texture_type = /datum/bodypart_texture/mesh/heretic

/obj/item/clothing/suit/armor/riot/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 5)
	AddElement(/datum/element/equipment_bodypart_texture, BODY_ZONE_CHEST, texture_type)
	init_rustle_component()

/obj/item/clothing/suit/armor/riot/proc/init_rustle_component()
	AddComponent(/datum/component/item_equipped_movement_rustle)

/datum/armor/armor_riot
	melee = 75 // DARKPACK EDIT CHANGE
	bullet = 50 // DARKPACK EDIT CHANGE
	laser = 10
	energy = 10
	fire = 80
	acid = 80
	wound = 30 // DARKPACK EDIT CHANGE

/obj/item/clothing/suit/armor/balloon_vest
	name = "气球背心"
	desc = "完全由气球制成的背心，能抵御默剧演员施展的一切邪恶力量，包括电击和火焰。可要是被尖锐的东西戳一下……"
	icon_state = "balloon-vest"
	inhand_icon_state = "balloon_armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/balloon_vest
	siemens_coefficient = 0
	strip_delay = 7 SECONDS
	equip_delay_other = 5 SECONDS
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 10.8)

/datum/armor/balloon_vest
	melee = 10
	laser = 10
	energy = 10
	fire = 60
	acid = 50

/obj/item/clothing/suit/armor/balloon_vest/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(isitem(hitby))
		var/obj/item/item_hit = hitby
		if(item_hit.get_sharpness())
			pop()

	if(istype(hitby, /obj/projectile/bullet))
		pop()

	return ..()

/obj/item/clothing/suit/armor/balloon_vest/proc/pop()
	playsound(src, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 50, vary = TRUE)
	qdel(src)


/obj/item/clothing/suit/armor/bulletproof
	name = "防弹护甲"
	desc = "III型重型防弹背心，擅长抵御传统实弹武器，也能提供少量爆炸防护。"
	icon_state = "bulletproof"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_bulletproof
	strip_delay = 7 SECONDS
	equip_delay_other = 5 SECONDS

/datum/armor/armor_bulletproof
	melee = 15
	bullet = 60
	laser = 10
	energy = 10
	bomb = 40
	fire = 50
	acid = 50
	wound = 20

/obj/item/clothing/suit/armor/laserproof
	name = "反射背心"
	desc = "擅长抵御能量弹体的背心，偶尔还能将其反射。"
	icon_state = "armor_reflec"
	inhand_icon_state = "armor_reflec"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	armor_type = /datum/armor/armor_laserproof
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/hit_reflect_chance = 50

/datum/armor/armor_laserproof
	melee = 10
	bullet = 10
	laser = 60
	energy = 60
	fire = 100
	acid = 100

/obj/item/clothing/suit/armor/laserproof/IsReflect(def_zone)
	if(!(def_zone in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/suit/armor/vest/det_suit
	name = "侦探防弹背心"
	desc = "带有侦探徽章的防护背心。"
	icon_state = "detective-armor"
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/det_suit/Initialize(mapload)
	. = ..()
	allowed = GLOB.detective_vest_allowed

/obj/item/clothing/suit/armor/swat
	name = "一型特警作战服"
	desc = "已解散的IS-ERI与纳诺传讯于2321年联合研制、用于军事行动的战术服。\
		略微影响移速，但提供良好防护，并帮助穿戴者在近距离对抗中抵抗推搡。"
	icon_state = "heavy"
	inhand_icon_state = "swat_suit"
	armor_type = /datum/armor/armor_swat
	strip_delay = 12 SECONDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	heat_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	slowdown = 0.7
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)

/obj/item/clothing/suit/armor/swat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 5)
	init_rustle_component()

/obj/item/clothing/suit/armor/swat/proc/init_rustle_component()
	AddComponent(/datum/component/item_equipped_movement_rustle)


//All of the armor below is mostly unused

/datum/armor/armor_swat
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 50
	bio = 90
	fire = 100
	acid = 100
	wound = 15

/obj/item/clothing/suit/armor/heavy
	name = "重型护甲"
	desc = "一套厚重的装甲，能够抵御中等程度的伤害。"
	icon_state = "heavy"
	inhand_icon_state = "swat_suit"
	w_class = WEIGHT_CLASS_BULKY
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 3
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor_type = /datum/armor/armor_heavy
	/// Type of texture applied by this
	var/texture_type = /datum/bodypart_texture/mesh/black

/obj/item/clothing/suit/armor/heavy/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/equipment_bodypart_texture, BODY_ZONE_CHEST, texture_type)

/datum/armor/armor_heavy
	melee = 80
	bullet = 80
	laser = 50
	energy = 50
	bomb = 100
	bio = 100
	fire = 90
	acid = 90

/obj/item/clothing/suit/armor/tdome
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/armor_tdome

/datum/armor/armor_tdome
	melee = 80
	bullet = 80
	laser = 50
	energy = 50
	bomb = 100
	bio = 100
	fire = 90
	acid = 90

/obj/item/clothing/suit/armor/tdome/red
	name = "雷霆竞技场护甲"
	desc = "泛红的护甲。"
	icon_state = "tdred"
	inhand_icon_state = "tdred"

/obj/item/clothing/suit/armor/tdome/green
	name = "雷霆竞技场护甲"
	desc = "呕吐物颜色的护甲。" //classy.
	icon_state = "tdgreen"
	inhand_icon_state = "tdgreen"

/obj/item/clothing/suit/armor/tdome/holosuit
	name = "雷霆竞技场护甲"
	armor_type = /datum/armor/tdome_holosuit
	cold_protection = null
	heat_protection = null

/datum/armor/tdome_holosuit
	melee = 10
	bullet = 10

/obj/item/clothing/suit/armor/tdome/holosuit/red
	desc = "泛红的护甲。"
	icon_state = "tdred"
	inhand_icon_state = "tdred"

/obj/item/clothing/suit/armor/tdome/holosuit/green
	desc = "呕吐物颜色的护甲。"
	icon_state = "tdgreen"
	inhand_icon_state = "tdgreen"

/obj/item/clothing/suit/armor/riot/knight
	name = "板甲"
	desc = "一套经典板甲，抵御近战攻击的效果极佳。"
	icon_state = "knight_green"
	inhand_icon_state = null
	texture_type = /datum/bodypart_texture/mesh/biosuit_dark
	allowed = list(
		/obj/item/banner,
		/obj/item/claymore,
		/obj/item/nullrod,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
	)

/obj/item/clothing/suit/armor/riot/knight/init_rustle_component()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_ARMOR_RUSTLE, 8)

/obj/item/clothing/suit/armor/riot/knight/yellow
	icon_state = "knight_yellow"
	inhand_icon_state = null

/obj/item/clothing/suit/armor/riot/knight/blue
	icon_state = "knight_blue"
	inhand_icon_state = null

/obj/item/clothing/suit/armor/riot/knight/red
	icon_state = "knight_red"
	inhand_icon_state = null

/obj/item/clothing/suit/armor/riot/knight/greyscale
	name = "骑士护甲"
	desc = "一套经典护甲，可由多种不同材料制成。"
	icon_state = "knight_greyscale"
	inhand_icon_state = null
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS // Can change color and add prefix
	armor_type = /datum/armor/knight_greyscale

/datum/armor/knight_greyscale
	melee = 35
	bullet = 10
	laser = 10
	energy = 10
	bomb = 10
	bio = 10
	fire = 40
	acid = 40

/obj/item/clothing/suit/armor/vest/durathread
	name = "耐久纤维背心"
	desc = "由耐久纤维制成的背心，以皮革条充当缓冲插板。"
	icon_state = "durathread"
	inhand_icon_state = null
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	max_integrity = 200
	resistance_flags = FLAMMABLE
	armor_type = /datum/armor/vest_durathread
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/durathread/Initialize(mapload)
	. = ..()
	allowed |= /obj/item/clothing/suit/apron::allowed

/datum/armor/vest_durathread
	melee = 20
	bullet = 10
	laser = 30
	energy = 40
	bomb = 15
	fire = 40
	acid = 50

/obj/item/clothing/suit/armor/vest/russian
	name = "俄式防弹背心"
	desc = "采用林地迷彩的防弹背心。幸好这附近到处都是能藏身的森林，对吧？"
	icon_state = "rus_armor"
	inhand_icon_state = null
	armor_type = /datum/armor/vest_russian
	dog_fashion = null

/datum/armor/vest_russian
	melee = 25
	bullet = 30
	energy = 10
	bomb = 10
	fire = 20
	acid = 50
	wound = 10

/obj/item/clothing/suit/armor/vest/russian_coat
	name = "俄式战斗大衣"
	desc = "用于极寒前线，以真正的熊皮制成。"
	icon_state = "rus_coat"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/vest_russian_coat
	dog_fashion = null

/datum/armor/vest_russian_coat
	melee = 25
	bullet = 20
	laser = 20
	energy = 30
	bomb = 20
	bio = 50
	fire = -10
	acid = 50
	wound = 10

/obj/item/clothing/suit/armor/elder_atmosian
	name = "\improper 上古大气之国战甲"
	desc = "以人类所能获得的最坚韧、最稀有材料制成的卓越护甲。"
	icon_state = "h2armor"
	inhand_icon_state = null
	material_flags = MATERIAL_EFFECTS
	armor_type = /datum/armor/armor_elder_atmosian
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/elder_atmosian/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/gun/ballistic/rifle/rebarxbow,
	)

/datum/armor/armor_elder_atmosian
	melee = 25
	bullet = 20
	laser = 30
	energy = 30
	bomb = 85
	bio = 10
	fire = 65
	acid = 40
	wound = 15

/obj/item/clothing/suit/armor/centcom_formal
	name = "\improper 中央指挥部礼服外套"
	desc = "发给中央指挥部指挥官的时髦外套。派应急响应队去送死时也能风度翩翩！"
	icon_state = "centcom_formal"
	inhand_icon_state = "centcom"
	body_parts_covered = CHEST|GROIN|ARMS
	armor_type = /datum/armor/armor_centcom_formal

/datum/armor/armor_centcom_formal
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/obj/item/clothing/suit/armor/centcom_formal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/armor/vest/hop
	name = "人事主管大衣"
	desc = "配发给人事主管的时髦大衣。"
	icon_state = "hop_coat"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dog_fashion = null

/obj/item/clothing/suit/armor/militia
	name = "空间站守卫大衣"
	desc = "边疆各地民兵使用的旧制服，厚实衬垫有助于缓冲打击。"
	icon_state = "militia"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/coat_militia

/datum/armor/coat_militia
	melee = 40
	bullet = 40
	laser = 30
	energy = 25
	bomb = 50
	fire = 40
	acid = 50
	wound = 30

/obj/item/clothing/suit/armor/vest/military
	name = "粗制胸甲"
	desc = "看着粗糙、生锈又破旧，穿着也一样糟糕：毕竟它是垃圾拼出来的。"
	icon_state = "military"
	inhand_icon_state = "armor"
	dog_fashion = null
	armor_type = /datum/armor/military
	allowed = list(
		/obj/item/banner,
		/obj/item/claymore/shortsword,
		/obj/item/nullrod,
		/obj/item/spear,
		/obj/item/gun/ballistic/bow
	)

/obj/item/clothing/suit/armor/vest/military/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 5)

/datum/armor/military
	melee = 45
	bullet = 25
	laser = 25
	energy = 25
	bomb = 25
	fire = 10
	acid = 50
	wound = 20

/obj/item/clothing/suit/armor/riot/knight/warlord
	name = "金色板甲"
	desc = "这套笨重护甲镀着一层闪亮的黄金，似乎几乎能反射所有光源。"
	icon_state = "warlord"
	inhand_icon_state = null
	armor_type = /datum/armor/armor_warlord
	w_class = WEIGHT_CLASS_BULKY
	clothing_flags = THICKMATERIAL
	slowdown = 0.8

/datum/armor/armor_warlord
	melee = 70
	bullet = 60
	laser = 70
	energy = 70
	bomb = 40
	fire = 50
	acid = 50
	wound = 30

/obj/item/clothing/suit/armor/durability
	abstract_type = /obj/item/clothing/suit/armor/durability

/obj/item/clothing/suit/armor/durability/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	take_damage(1, BRUTE, 0, 0)

/obj/item/clothing/suit/armor/durability/watermelon
	name = "西瓜护甲"
	desc = "用西瓜做成的护甲，大概挨不了几下，至少看起来还挺正经……在把西瓜穿上身这件事所能达到的范围内。"
	icon_state = "watermelon"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/watermelon
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)
	max_integrity = 15

/obj/item/clothing/suit/armor/durability/watermelon/fire_resist
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/watermelon_fr

/datum/armor/watermelon
	melee = 15
	bullet = 10
	energy = 10
	bomb = 10
	fire = 0
	acid = 25
	wound = 5

/datum/armor/watermelon_fr
	melee = 15
	bullet = 10
	energy = 10
	bomb = 10
	fire = 15
	acid = 30
	wound = 5

/obj/item/clothing/suit/armor/durability/holymelon
	name = "圣瓜护甲"
	desc = "用圣瓜做成的护甲，让你想去发起某种圣战……也许是向孩子们推广菠菜？"
	icon_state = "holymelon"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/watermelon
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)
	max_integrity = 15

/obj/item/clothing/suit/armor/durability/holymelon/fire_resist
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/watermelon_fr

/obj/item/clothing/suit/armor/durability/holymelon/Initialize(mapload)
	. = ..()

	AddComponent(
		/datum/component/anti_magic, \
		antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY, \
		inventory_flags = ITEM_SLOT_OCLOTHING, \
		charges = 1, \
		block_magic = CALLBACK(src, PROC_REF(drain_antimagic)), \
		expiration = CALLBACK(src, PROC_REF(decay)) \
	)

/obj/item/clothing/suit/armor/durability/holymelon/proc/drain_antimagic(mob/user)
	to_chat(user, span_warning("[src]的光彩和亮泽黯淡了一些……"))

/obj/item/clothing/suit/armor/durability/holymelon/proc/decay()
	take_damage(8, BRUTE, 0, 0)


/obj/item/clothing/suit/armor/durability/barrelmelon
	name = "桶瓜护甲"
	desc = "用桶瓜做成的护甲，散发着浓烈艾尔酒味，激励人做出英勇之举。或者只是在酒吧里打一架。"
	icon_state = "barrelmelon"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/barrelmelon
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)
	max_integrity = 10

/obj/item/clothing/suit/armor/durability/barrelmelon/fire_resist
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/barrelmelon_fr

/datum/armor/barrelmelon
	melee = 25
	bullet = 20
	energy = 15
	bomb = 10
	fire = 0
	acid = 35
	wound = 10

/datum/armor/barrelmelon_fr
	melee = 25
	bullet = 20
	energy = 15
	bomb = 10
	fire = 20
	acid = 40
	wound = 10

/obj/item/clothing/suit/armor/dragoon
	name = "龙鳞链甲"
	desc = "骨架上缀有龙鳞的链甲服，外覆沾满灰烬的秘银板加固层。"
	icon_state = "dragoon"
	inhand_icon_state = "dragoon"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	allowed = list(/obj/item/spear/skybulge)
