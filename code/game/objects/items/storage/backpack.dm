/* Backpacks
 * Contains:
 * Backpack
 * Backpack Types
 * Satchel Types
 */

/*
 * Backpack
 */

/obj/item/storage/backpack
	name = "背包"
	desc = "背在背上，用来装东西。"
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "backpack"
	inhand_icon_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK //ERROOOOO
	resistance_flags = NONE
	max_integrity = 300
	storage_type = /datum/storage/backpack
	pickup_sound = 'sound/items/handling/backpack/backpack_pickup1.ogg'
	drop_sound = 'sound/items/handling/backpack/backpack_drop1.ogg'
	equip_sound = 'sound/items/equip/backpack_equip.ogg'
	sound_vary = TRUE

/obj/item/storage/backpack/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/attack_equip)
	AddElement(/datum/element/strip_accessible_storage)

/*
 * Backpack Types
 */

/obj/item/bag_of_holding_inert
	name = "未激活的次元背包"
	desc = "目前还只是一块笨重的金属，上面留有用于安装蓝空间异常核心的插槽。"
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "bag_of_holding-inert"
	inhand_icon_state = "brokenpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/* // DARKPACK EDIT REMOVAL
/obj/item/bag_of_holding_inert/Initialize(mapload)
	. = ..()
	var/static/list/recipes = list(/datum/crafting_recipe/boh)
	AddElement(/datum/element/slapcrafting, recipes)
 */
/obj/item/storage/backpack/holding
	name = "次元背包"
	desc = "一个通向局部蓝空间口袋的背包。"
	icon_state = "bag_of_holding"
	inhand_icon_state = "holdingpack"
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	armor_type = /datum/armor/backpack_holding
	storage_type = /datum/storage/bag_of_holding
	pickup_sound = null
	drop_sound = null
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/storage/backpack/holding/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_BLUESPACE_INTERFERENCE, INNATE_TRAIT)

/datum/armor/backpack_holding
	fire = 60
	acid = 50

/obj/item/storage/backpack/holding/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正往[src]里跳！看起来是想自杀。"))
	user.dropItemToGround(src, TRUE)
	user.Stun(100, ignore_canstun = TRUE)
	sleep(2 SECONDS)
	playsound(src, SFX_RUSTLE, 50, TRUE, -5)
	user.suicide_log()
	qdel(user)


/obj/item/storage/backpack/santabag
	name = "圣诞老人的礼物袋"
	desc = "太空圣诞老人在圣诞节用它给太空中所有乖孩子送礼物！哇，真够大的！"
	icon_state = "giftbag0"
	inhand_icon_state = "giftbag"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/backpack/santabag

/obj/item/storage/backpack/santabag/Initialize(mapload)
	. = ..()
	regenerate_presents()

/obj/item/storage/backpack/santabag/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]把[src]套在头上并拉紧！看起来一点也没感受到圣诞气氛……"))
	return OXYLOSS

/obj/item/storage/backpack/santabag/proc/regenerate_presents()
	addtimer(CALLBACK(src, PROC_REF(regenerate_presents)), 30 SECONDS)

	var/mob/user = get(loc, /mob)
	if(!istype(user))
		return
	if(HAS_MIND_TRAIT(user, TRAIT_CANNOT_OPEN_PRESENTS))
		var/turf/floor = get_turf(src)
		var/obj/item/thing = new /obj/item/gift/anything(floor)
		if(!atom_storage.attempt_insert(thing, user, override = TRUE, force = STORAGE_SOFT_LOCKED))
			qdel(thing)


/obj/item/storage/backpack/cultpack
	name = "战利品架"
	desc = "既能携带额外装备，又能骄傲地宣告你的疯狂。"
	icon_state = "backpack-cult"
	inhand_icon_state = "backpack"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER

/obj/item/storage/backpack/clown
	name = "咯咯·冯·叭叭顿"
	desc = "HONK公司制造的背包。"
	icon_state = "backpack-clown"
	inhand_icon_state = "clownpack"

/obj/item/storage/backpack/explorer
	name = "探索者背包"
	desc = "结实的背包，用来装你的战利品。"
	icon_state = "backpack-explorer"
	inhand_icon_state = "explorerpack"

/obj/item/storage/backpack/mime
	name = "帕塞尔包索"
	desc = "为无声工作者打造的无声背包。无声公司出品。"
	icon_state = "backpack-mime"
	inhand_icon_state = "mimepack"

/obj/item/storage/backpack/medic
	name = "医疗背包"
	desc = "专为无菌环境设计的背包。"
	icon_state = "backpack-medical"
	inhand_icon_state = "medicalpack"

/obj/item/storage/backpack/chief_medic
	name = "首席医疗官背包"
	desc = "口袋刚好够装下首席医疗官装备的背包。"
	icon_state = "backpack-chiefmedical"
	inhand_icon_state = "medicalpack"

/obj/item/storage/backpack/coroner
	name = "法医背包"
	desc = "专为亡灵环境设计的背包。"
	icon_state = "backpack-coroner"
	inhand_icon_state = "coronerpack"

/obj/item/storage/backpack/security
	name = "安保背包"
	desc = "一个非常结实的背包。"
	icon_state = "backpack-security"
	inhand_icon_state = "securitypack"

/obj/item/storage/backpack/captain
	name = "船长背包"
	desc = "纳诺传讯军官专用的特殊背包。"
	icon_state = "backpack-captain"
	inhand_icon_state = "captainpack"

/obj/item/storage/backpack/industrial
	name = "工业背包"
	desc = "一个坚固的背包，应对空间站生活中的日常磨损。"
	icon_state = "backpack-engineering"
	inhand_icon_state = "engiepack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/botany
	name = "植物学背包"
	desc = "采用全天然纤维制成的背包。"
	icon_state = "backpack-hydroponics"
	inhand_icon_state = "botpack"

/obj/item/storage/backpack/chemistry
	name = "化学背包"
	desc = "专门设计来防污及防危险液体的背包。"
	icon_state = "backpack-chemistry"
	inhand_icon_state = "chempack"

/obj/item/storage/backpack/genetics
	name = "遗传学背包"
	desc = "设计得格外结实的背包，以防有人突然变身绿巨人。"
	icon_state = "backpack-genetics"
	inhand_icon_state = "genepack"

/obj/item/storage/backpack/science
	name = "科研背包"
	desc = "特制背包，耐火，并散发着淡淡的等离子气味。"
	icon_state = "backpack-science"
	inhand_icon_state = "scipack"

/obj/item/storage/backpack/virology
	name = "病毒学背包"
	desc = "低致敏纤维制成的背包，旨在协助防止疾病传播。闻起来有股猴味。"
	icon_state = "backpack-virology"
	inhand_icon_state = "viropack"

/obj/item/storage/backpack/floortile
	name = "地砖背包"
	desc = "专为在地砖里使用而设计的背包……"
	icon_state = "floortile_backpack"
	inhand_icon_state = "backpack"

/obj/item/storage/backpack/ert
	name = "紧急响应小队指挥官背包"
	desc = "宽敞而口袋众多的背包，供紧急响应小队指挥官使用。"
	icon_state = "ert_commander"
	inhand_icon_state = "securitypack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/ert/security
	name = "紧急响应小队安保背包"
	desc = "宽敞而口袋众多的背包，供紧急响应小队安保人员使用。"
	icon_state = "ert_security"

/obj/item/storage/backpack/ert/medical
	name = "紧急响应小队医疗背包"
	desc = "宽敞而口袋众多的背包，供紧急响应小队医务人员使用。"
	icon_state = "ert_medical"

/obj/item/storage/backpack/ert/engineer
	name = "紧急响应小队工程背包"
	desc = "宽敞而口袋众多的背包，供紧急响应小队工程师使用。"
	icon_state = "ert_engineering"

/obj/item/storage/backpack/ert/janitor
	name = "紧急响应小队清洁背包"
	desc = "宽敞而口袋众多的背包，供紧急响应小队清洁工使用。"
	icon_state = "ert_janitor"

/obj/item/storage/backpack/ert/clown
	name = "紧急响应小队小丑背包"
	desc = "宽敞而口袋众多的背包，供紧急响应小队小丑使用。"
	icon_state = "ert_clown"

/obj/item/storage/backpack/saddlepack
	name = "鞍包"
	desc = "既能挂在坐骑上，也能背在自己背上，随时切换的背包。相当宽敞，代价是让你觉得自己真成了驮骡。"
	icon = 'icons/obj/storage/ethereal.dmi'
	worn_icon = 'icons/mob/clothing/back/ethereal.dmi'
	icon_state = "saddlepack"
	storage_type = /datum/storage/backpack/saddle

// MEAT MEAT MEAT MEAT MEAT

/obj/item/storage/backpack/meat
	name = "\improper 肉"
	desc = "肉 肉 肉 肉 肉 肉"
	icon_state = "meatmeatmeat"
	inhand_icon_state = "meatmeatmeat"
	force = 15
	throwforce = 15
	material_flags = MATERIAL_EFFECTS | MATERIAL_AFFECT_STATISTICS
	attack_verb_continuous = list("肉击", "肉肉击")
	attack_verb_simple = list("肉击", "肉肉击")
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 15) // MEAT
	///Sounds used in the squeak component
	var/list/meat_sounds = list('sound/effects/blob/blobattack.ogg' = 1)
	///Reagents added to the edible component on top of the meat material, ingested when you EAT the MEAT
	var/list/meat_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	///Eating verbs when consuming the MEAT
	var/list/eatverbs = list("肉食", "吸收", "啃食", "吞食")

/obj/item/storage/backpack/meat/Initialize(mapload)
	. = ..()
	AddComponentFrom(
		SOURCE_EDIBLE_INNATE, \
		/datum/component/edible,\
		initial_reagents = meat_reagents,\
		tastes = list("meat" = 1),\
		eatverbs = eatverbs,\
	)

	AddComponent(/datum/component/squeak, meat_sounds)

/obj/item/storage/backpack/meat/change_material_strength(datum/material/material, mat_amount, multiplier, remove)
	// Our base 15 force includes the implied meat force
	if (!istype(material, /datum/material/meat))
		return ..()

/*
 * Satchel Types
 */

/obj/item/storage/backpack/satchel
	name = "挎包"
	desc = "一个外观时髦的挎包。"
	icon_state = "satchel-norm"
	inhand_icon_state = "satchel-norm"

/obj/item/storage/backpack/satchel/leather
	name = "皮挎包"
	desc = "以优质皮革制成的精美挎包。"
	icon_state = "satchel-leather"
	inhand_icon_state = "satchel"

/obj/item/storage/backpack/satchel/leather/withwallet/PopulateContents()
	new /obj/item/storage/wallet/random(src)

/obj/item/storage/backpack/satchel/fireproof
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/eng
	name = "工业挎包"
	desc = "带有额外口袋的坚固挎包。"
	icon_state = "satchel-engineering"
	inhand_icon_state = "satchel-eng"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/med
	name = "医疗挎包"
	desc = "医疗部门使用的无菌挎包。"
	icon_state = "satchel-medical"
	inhand_icon_state = "satchel-med"

/obj/item/storage/backpack/satchel/chief_medic
	name = "首席医疗官挎包"
	desc = "口袋勉强够装下首席医疗官装备的挎包。"
	icon_state = "satchel-chiefmedical"
	inhand_icon_state = "satchel-med"

/obj/item/storage/backpack/satchel/vir
	name = "病毒学家挎包"
	desc = "采用病毒学家配色的无菌挎包。"
	icon_state = "satchel-virology"
	inhand_icon_state = "satchel-vir"

/obj/item/storage/backpack/satchel/chem
	name = "化学家挎包"
	desc = "采用化学家配色的无菌挎包。"
	icon_state = "satchel-chemistry"
	inhand_icon_state = "satchel-chem"

/obj/item/storage/backpack/satchel/coroner
	name = "法医挎包"
	desc = "用于携带人体各种残余物的挎包。"
	icon_state = "satchel-coroner"
	inhand_icon_state = "satchel-coroner"

/obj/item/storage/backpack/satchel/gen
	name = "遗传学家挎包"
	desc = "采用遗传学家配色的无菌挎包。"
	icon_state = "satchel-genetics"
	inhand_icon_state = "satchel-gen"

/obj/item/storage/backpack/satchel/science
	name = "科学家挎包"
	desc = "适合装科研资料。"
	icon_state = "satchel-science"
	inhand_icon_state = "satchel-sci"

/obj/item/storage/backpack/satchel/hyd
	name = "植物学家挎包"
	desc = "采用全天然纤维制成的挎包。"
	icon_state = "satchel-hydroponics"
	inhand_icon_state = "satchel-hyd"

/obj/item/storage/backpack/satchel/sec
	name = "安保挎包"
	desc = "满足安保工作需求的结实挎包。"
	icon_state = "satchel-security"
	inhand_icon_state = "satchel-sec"

/obj/item/storage/backpack/satchel/explorer
	name = "探索者挎包"
	desc = "结实的挎包，用来装你的战利品。"
	icon_state = "satchel-explorer"
	inhand_icon_state = "satchel-explorer"

/obj/item/storage/backpack/satchel/cap
	name = "船长挎包"
	desc = "纳诺传讯军官专用的挎包。"
	icon_state = "satchel-captain"
	inhand_icon_state = "satchel-cap"

/obj/item/storage/backpack/satchel/flat
	name = "走私者挎包"
	desc = "一个非常扁薄的挎包，能轻松塞进狭窄空间。违禁品扫描仪无法检测其中的物品。"
	icon_state = "satchel-flat"
	inhand_icon_state = "satchel-flat"
	w_class = WEIGHT_CLASS_NORMAL //Can fit in backpacks itself.
	storage_type = /datum/storage/backpack/satchel_flat

/obj/item/storage/backpack/satchel/flat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE, INVISIBILITY_OBSERVER, use_anchor = TRUE)
	ADD_TRAIT(src, TRAIT_CONTRABAND_BLOCKER, INNATE_TRAIT)

/obj/item/storage/backpack/satchel/flat/PopulateContents()
	for(var/items in 1 to 4)
		new /obj/effect/spawner/random/contraband(src)

/obj/item/storage/backpack/satchel/flat/with_tools/PopulateContents()
	new /obj/item/stack/tile/iron/base(src)
	new /obj/item/crowbar(src)

	..()

/obj/item/storage/backpack/satchel/flat/empty/PopulateContents()
	return


/// Messenger Bag Types
/obj/item/storage/backpack/messenger
	name = "邮差包"
	desc = "一个外观时髦的邮差包，有时也叫信使包。时尚又便携。"
	icon_state = "messenger"
	inhand_icon_state = "messenger"
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'

/obj/item/storage/backpack/messenger/eng
	name = "工业邮差包"
	desc = "坚固的邮差包，采用经先进工艺处理的皮革以达到防火效果，口袋也比一般款更多。"
	icon_state = "messenger_engineering"
	inhand_icon_state = "messenger_engineering"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/messenger/med
	name = "医疗邮差包"
	desc = "无菌邮差包，凭借便携性和简洁外形深受医务人员喜爱。"
	icon_state = "messenger_medical"
	inhand_icon_state = "messenger_medical"

/obj/item/storage/backpack/messenger/chief_medic
	name = "首席医疗官邮差包"
	desc = "纤薄的邮差包，工作时不会碍手碍脚，深受首席医疗官喜爱——他们手下的化学家可没这么省心。"
	icon_state = "messenger_chiefmedical"
	inhand_icon_state = "messenger_medical"

/obj/item/storage/backpack/messenger/vir
	name = "病毒学家邮差包"
	desc = "采用病毒学家配色的无菌邮差包，让你以创纪录的速度投放生物危害物。"
	icon_state = "messenger_virology"
	inhand_icon_state = "messenger_virology"

/obj/item/storage/backpack/messenger/chem
	name = "化学家邮差包"
	desc = "采用化学家配色的无菌邮差包，方便你准时赶到小巷完成交易。"
	icon_state = "messenger_chemistry"
	inhand_icon_state = "messenger_chemistry"

/obj/item/storage/backpack/messenger/coroner
	name = "法医邮差包"
	desc = "方便你迅速溜出墓地的邮差包。"
	icon_state = "messenger_coroner"
	inhand_icon_state = "messenger_coroner"

/obj/item/storage/backpack/messenger/gen
	name = "遗传学家邮差包"
	desc = "采用遗传学家配色的无菌邮差包，搭配绿巨人时出奇可爱。"
	icon_state = "messenger_genetics"
	inhand_icon_state = "messenger_genetics"

/obj/item/storage/backpack/messenger/science
	name = "科学家邮差包"
	desc = "适合携带科研资料，也方便你加快脚步奔赴各个扫描目标。"
	icon_state = "messenger_science"
	inhand_icon_state = "messenger_science"

/obj/item/storage/backpack/messenger/hyd
	name = "植物学家邮差包"
	desc = "采用全天然纤维制成的邮差包，方便你及时赶上抽草聚会。"
	icon_state = "messenger_hydroponics"
	inhand_icon_state = "messenger_hydroponics"

/obj/item/storage/backpack/messenger/sec
	name = "安保邮差包"
	desc = "满足安保工作需求的结实邮差包。"
	icon_state = "messenger_security"
	inhand_icon_state = "messenger_security"

/obj/item/storage/backpack/messenger/explorer
	name = "探索者邮差包"
	desc = "结实的邮差包，能装下你的战利品，搭配龙骨盔甲也出奇可爱。"
	icon_state = "messenger_explorer"
	inhand_icon_state = "messenger_explorer"

/obj/item/storage/backpack/messenger/cap
	name = "船长邮差包"
	desc = "纳诺传讯军官专用的邮差包，由真正的鲸鱼皮制成。"
	icon_state = "messenger_captain"
	inhand_icon_state = "messenger_captain"

/obj/item/storage/backpack/messenger/clown
	name = "小咯咯·冯·叭叭顿"
	desc = "HONK公司的最新储物'科技'。嘿，这么小的外形到底怎么装下这么多东西？背包的主人肯定不会告诉你。"
	icon_state = "messenger_clown"
	inhand_icon_state = "messenger_clown"
