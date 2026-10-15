/// Some defines for items the daemon forge can create.
#define NARSIE_ARMOR "纳尔西硬化护甲"
#define ELDRITCH_SWORD "邪异长剑"
#define CURSED_BLADE "诅咒仪式匕首"

// Cult forge. Gives out combat weapons.
/obj/structure/destructible/cult/item_dispenser/forge
	name = "恶魔熔炉"
	desc = "用于锻造纳尔西大军所用邪恶兵器的熔炉。"
	cult_examine_tip = "可用于制作纳尔西硬化护甲和邪异长剑。"
	icon_state = "forge"
	light_range = 2
	light_color = LIGHT_COLOR_LAVA
	break_message = span_warning("熔炉伴随着一声凄厉尖叫崩成碎片！")
	mansus_conversion_path = /obj/structure/destructible/eldritch_crucible
	custom_materials = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT * 3)

/obj/structure/destructible/cult/item_dispenser/forge/setup_options()
	var/static/list/forge_items = list(
		NARSIE_ARMOR = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/clothing/suits/armor.dmi', icon_state = "cult_armor"),
			OUTPUT_ITEMS = list(/obj/item/clothing/suit/hooded/cultrobes/hardened),
			RADIAL_DESC = "锻造一套[/obj/item/clothing/suit/hooded/cultrobes/hardened::name]，这套坚固护甲能抵御太空环境。",
			),
		ELDRITCH_SWORD = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/weapons/sword.dmi', icon_state = "cultblade"),
			OUTPUT_ITEMS = list(/obj/item/melee/cultblade),
			RADIAL_DESC = "锻造[/obj/item/melee/cultblade::name]，这把强大兵刃能劈开最坚固的护甲。",
			),
	)

	var/extra_item = extra_options()

	options = forge_items
	if(!isnull(extra_item))
		options += extra_item

/obj/structure/destructible/cult/item_dispenser/forge/extra_options()
	if(!cult_team?.unlocked_heretic_items[CURSED_BLADE_UNLOCKED])
		return
	return list(CURSED_BLADE = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/weapons/khopesh.dmi', icon_state = "cursed_blade"),
			OUTPUT_ITEMS = list(/obj/item/melee/sickly_blade/cursed),
			RADIAL_DESC = "锻造[/obj/item/melee/sickly_blade/cursed::name]，这把强化匕首可折断以进行紧急传送。",
			),
	)


/obj/structure/destructible/cult/item_dispenser/forge/succcess_message(mob/living/user, obj/item/spawned_item)
	to_chat(user, span_cult_italic("黑暗知识引导着你的双手，你操纵[src]，造出了[spawned_item]！"))

/obj/structure/destructible/cult/item_dispenser/forge/engine
	name = "岩浆引擎"
	desc = "用于为穿梭机提供动力的奥秘引擎。"
	debris = list()

#undef NARSIE_ARMOR
#undef ELDRITCH_SWORD
#undef CURSED_BLADE
