/obj/item/melee/vamp
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	custom_price = 1000


/obj/item/melee/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 75, "melee", FALSE)


/obj/item/fireaxe/vamp
	name = "消防斧"
	desc = "简直是疯子的武器。谁会想到用斧头对付火灾？"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT // Should really be suit storage

	// WTA pg. 302
	force_unwielded = 2 TTRPG_DAMAGE // Made up lol.
	force_wielded = 3 LETHAL_TTRPG_DAMAGE
	attack_difficulty = 7

	pixel_w = -8
	custom_price = 1800

/obj/item/katana/vamp
	name = "武士刀"
	desc = "一把优雅的武器，纤薄的刀刃能轻易切开血肉与骨骼。"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')

	// WTA pg. 302
	force = 2 LETHAL_TTRPG_DAMAGE

	pixel_w = -8
	custom_price = 1300
	slot_flags = ITEM_SLOT_BELT

/obj/item/katana/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 100, "katana", FALSE)

/obj/item/katana/vamp/fire
	name = "燃烧的武士刀"
	icon_state = "katana_burning"
	item_flags = DROPDEL
	obj_flags = NONE
	masquerade_violating = TRUE


//Do not sell the magically summoned katanas for infinite cash
/obj/item/katana/vamp/fire/Initialize(mapload)
	. = ..()
	var/datum/component/selling/sell_component = GetComponent(/datum/component/selling)
	if(sell_component)
		qdel(sell_component)


/obj/item/katana/vamp/fire/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(isliving(target))
		var/mob/living/burnt_mob = target
		burnt_mob.apply_damage(15, BURN)

/obj/item/katana/vamp/blood
	name = "鲜血武士刀"
	color = "#bb0000"
	item_flags = DROPDEL
	obj_flags = NONE
	masquerade_violating = TRUE

/obj/item/katana/vamp/blood/Initialize(mapload)
	. = ..()
	var/datum/component/selling/sell_component = GetComponent(/datum/component/selling)
	if(sell_component)
		qdel(sell_component)

/obj/item/katana/vamp/blood/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(isliving(target))
		var/mob/living/burnt_mob = target
		burnt_mob.apply_damage(15, AGGRAVATED)

/obj/item/melee/sabre/vamp
	name = "军刀"
	desc = "一种弯刃刀剑，是骑兵用来劈砍和刺击的武器。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "sabre"

	// WTA pg. 302
	force = 2 LETHAL_TTRPG_DAMAGE

	armour_penetration = 50	 //Normally 75 pen, that pens army armor. Instead, 50. Pens bullet proof.
	var/value = 1000 // DARKPACK TODO: Move this up at some point. I hate the selling component with all my heart.

/obj/item/melee/sabre/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, value, "sabre", FALSE)

/obj/item/melee/sabre/rapier
	name = "刺剑"
	desc = "一把纤细优雅的剑，是决斗者用于刺击的武器。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "rapier"
	inhand_icon_state = "rapier"
	// WTA pg. 302
	force = 2 LETHAL_TTRPG_DAMAGE
	armour_penetration = 50

/obj/item/melee/sabre/rapier/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 700, "rapier", FALSE)

/obj/item/melee/sabre/vamp/training
	name = "泡沫军刀"
	force = 0
	value = 3

/obj/item/claymore/longsword
	name = "长剑"
	desc = "骑士的经典武器，可劈可刺，用途广泛。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "longsword"
	inhand_icon_state = "longsword"
	// WTA pg. 302
	force = 2 LETHAL_TTRPG_DAMAGE


/obj/item/claymore/longsword/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 600, "longsword", FALSE)

/obj/item/claymore/machete
	name = "砍刀"
	desc = "一把适合丛林的正经砍刀……可你在周围看不到藤蔓。配重适中，也适合投掷。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "machete"
	inhand_icon_state = "machete"
	pixel_w = -8
	masquerade_violating = FALSE
	custom_price = 500
	force = 1 LETHAL_TTRPG_DAMAGE
	attack_difficulty = 5 // Slightly worse handling then a knife.
	block_chance = 0

/obj/item/claymore/machete/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 70, "machete", FALSE)

// "Keepers" derived from "my brother's keeper" are an epithet for Lasombra but this seems to be a wholly unqiue item not found in any book.
/obj/item/claymore/longsword/keeper
	name = "兄弟守护者"
	desc = "一把来自往昔岁月的古老经典长剑。尽管年代久远，它却保养得出奇完好，过去沾染过的鲜血或血粹都不留痕迹，锋芒也一如初铸。剑身平面刻着一句简朴而磨损的拉丁文铭文：‘于死亡中，我将崛起。’"
	color = "#C0C0C0"
	w_class = WEIGHT_CLASS_BULKY
	force = 50
	block_chance = 45
	armour_penetration = 40
	attack_verb_continuous = list("劈砍", "切割")
	attack_verb_simple = list("劈砍", "切割")
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	wound_bonus = 5


/obj/item/claymore/longsword/keeper/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	fera_silver_damage(target, 5, 1)

/obj/item/melee/baseball_bat/vamp
	name = "棒球棍"
	desc = "整个联盟也找不出一颗扛得住这记挥击的脑袋。"
	w_class = WEIGHT_CLASS_BULKY	//TG parent bat is huge

	// WTA pg. 302
	force = 2 TTRPG_DAMAGE
	attack_difficulty = 5

	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "baseball"
	inhand_icon_state = "baseball"
	worn_icon_state = "baseball"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT // Should really be suit storage
	custom_price = 50

/obj/item/melee/baseball_bat/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 20, "baseball", FALSE)

/obj/item/melee/baseball_bat/vamp/hand
	name = "撕下的手臂"
	desc = "哇，这曾经是某人的手臂。"
	icon_state = "hand"
	force = 1 TTRPG_DAMAGE
	attack_difficulty = 5
	masquerade_violating = TRUE
	//is_wood = FALSE

/obj/item/melee/vamp/tire
	name = "轮胎撬棒"
	desc = "既能当工具，也能当武器。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	icon_state = "pipe"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	force = 2 LETHAL_TTRPG_DAMAGE
	attack_verb_continuous = list("殴打", "猛击")
	attack_verb_simple = list("殴打", "猛击")
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	obj_flags = CONDUCTS_ELECTRICITY

/obj/item/knife/vamp
	name = "小刀"
	desc = "小心别割伤自己。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	// WTA pg. 302
	force = 1 LETHAL_TTRPG_DAMAGE
	attack_difficulty = 4

	custom_price = 85

/obj/item/knife/vamp/lasombra_tentacle
	name = "暗影触须"
	force = 7
	armour_penetration = 100
	block_chance = 0
	icon_state = "lasombra"
	item_flags = DROPDEL
	masquerade_violating = TRUE
	obj_flags = NONE

/obj/item/knife/vamp/lasombra_tentacle/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)

/obj/item/knife/vamp/lasombra_tentacle/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(isliving(target))
		var/mob/living/L = target
		L.apply_damage(16, AGGRAVATED)
		L.apply_damage(7, BURN)

/obj/item/melee/vamp/handsickle
	name = "手镰"
	desc = "收割他们种下的恶果。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	icon_state = "handsickle"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	force = 2 LETHAL_TTRPG_DAMAGE
	attack_verb_continuous = list("劈砍", "切割", "收割")
	attack_verb_simple = list("劈砍", "切割", "收割")
	hitsound = 'sound/items/weapons/slash.ogg'
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	obj_flags = CONDUCTS_ELECTRICITY

/obj/item/melee/touch_attack/werewolf
	name = "倒地之触"
	desc = "有点像在长毛地毯上蹭脚攒出静电，再去电你的朋友，只不过危险得多。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	//catchphrase = null
	//on_use_sound = 'sound/magic/disintegrate.ogg'
	icon_state = "falling"
	inhand_icon_state = "disintegrate"

/obj/item/melee/touch_attack/werewolf/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(isliving(target))
		var/mob/living/L = target
		L.AdjustKnockdown(4 SECONDS)
		L.adjust_stamina_loss(50)
		L.Immobilize(3 SECONDS)
		if(L.body_position != LYING_DOWN)
			L.toggle_resting()
	return ..()

/obj/item/chainsaw/vamp
	name = "链锯"
	desc = "一种多用途动力工具。既能修剪树枝，也能锯掉人的四肢。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')

	// WTA pg. 302
	// force_on = 7 LETHAL_TTRPG_DAMAGE // Holy fuck thats what its listed as but it also hurts you on a botch..
	force_on = 6 LETHAL_TTRPG_DAMAGE
	force = 2 TTRPG_DAMAGE
	attack_difficulty = 8

	custom_price = 2000

/obj/item/shovel/vamp
	name = "铲子"
	desc = "对付凡人或不朽者都很趁手的武器。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "shovel"
	custom_price = 150
	force = 1 TTRPG_DAMAGE
	attack_difficulty = 5

/obj/item/shovel/vamp/attack(mob/living/target, mob/living/user)
	. = ..()
	if(prob(10))
		to_chat(user, span_warning("你用铲子猛砸[target]的头！"))
		target.visible_message(
			span_userdanger("[user]猛砸了你的头！"),
			span_warning("你眼冒金星！"),
			span_hear("你听到一声沉闷的砰响！"))
		var/head_protection = target.run_armor_check(BODY_ZONE_HEAD, MELEE)
		target.apply_effect(5 SECONDS, EFFECT_KNOCKDOWN, head_protection)
		target.drop_all_held_items()

/obj/item/scythe/vamp
	name = "长柄镰刀"
	desc = "与其说是武器，不如说是工具。一件割脑袋的工具……"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "kosa"
	inhand_icon_state = "kosa"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	// Made up
	force = 2 LETHAL_TTRPG_DAMAGE


/obj/item/instrument/eguitar/vamp
	name = "电吉他"
	desc = "作为一个白人小伙，你还挺潮……"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	icon_state = "rock0"
	inhand_icon_state = "rock0"
	// Made up
	force = 2 TTRPG_DAMAGE
	attack_difficulty = 7

/obj/item/melee/baton/vamp
	name = "警棍"
	desc = "伸张正义的钝器。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	icon_state = "baton"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)
	custom_price = 20

/obj/item/switchblade/vamp
	name = "弹簧刀"
	desc = "一把弹簧驱动的小刀。捅鲨鱼帮和喷气机帮正合适。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')

	// WTA pg. 302
	force = 1 LETHAL_TTRPG_DAMAGE
	attack_difficulty = 4

/obj/item/melee/vamp/brick
	name = "砖块"
	desc = "既能弑神杀人，也能筑起大千世界。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	icon_state = "red_brick"
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	w_class = WEIGHT_CLASS_NORMAL

	// Made up
	force = 2 TTRPG_DAMAGE
	throwforce = 2 TTRPG_DAMAGE
	throw_range = 4

	attack_verb_continuous = list("重击", "猛砸", "殴打")
	attack_verb_simple = list("重击", "猛砸", "殴打", "猛击")
	hitsound = 'sound/items/weapons/genhit3.ogg'
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	//grid_width = 2 GRID_BOXES
	//grid_height = 1 GRID_BOXES
	var/broken = FALSE

/obj/item/melee/vamp/brick/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/falling_hazard, damage = 50, wound_bonus = 20, hardhat_safety = TRUE, crushes = FALSE, impact_sound = 'sound/items/weapons/genhit3.ogg')

/obj/item/melee/vamp/brick/after_throw(datum/callback/callback)
	if(prob(75))
		broken = FALSE
	if(broken)
		w_class = WEIGHT_CLASS_SMALL
		force = 1 TTRPG_DAMAGE
		throwforce = 1 TTRPG_DAMAGE
		icon_state = "red_brick2"
		hitsound = 'sound/items/weapons/genhit1.ogg'
		//grid_width = 1 GRID_BOXES
		//grid_height = 1 GRID_BOXES

//this should be a subtype of spear in the future but we lack the sprites
/obj/item/darkpack/spear
	name = "长矛"
	desc = "几个世纪以来一直是战争中的常备兵器，用来戳东西再合适不过。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	icon_state = "spear"
	lefthand_file = 'modular_darkpack/modules/weapons/icons/melee_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/weapons/icons/melee_righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')

	// WTA pg. 302
	force = 3 LETHAL_TTRPG_DAMAGE
	attack_difficulty = 7
	/// Grrr this should be twohanded.

	sharpness = SHARP_POINTY
	attack_verb_continuous = list("刺击", "戳刺")
	attack_verb_simple = list("刺击", "戳刺")
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	custom_price = 1200

/obj/item/darkpack/spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 400, "spear", FALSE)
