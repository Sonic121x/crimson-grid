/// Some defines for items the cult altar can create.
#define ELDRITCH_WHETSTONE "邪异磨刀石"
#define CONSTRUCT_SHELL "构装体躯壳"
#define UNHOLY_WATER "邪水瓶"
#define PROTEON_ORB "传送门召唤法球"

// Cult altar. Gives out consumable items.
/obj/structure/destructible/cult/item_dispenser/altar
	name = "祭坛"
	desc = "一座沾满鲜血、供奉纳尔西的祭坛。"
	cult_examine_tip = "可用于制作邪异磨刀石、构装体躯壳和邪水瓶。"
	icon_state = "talismanaltar"
	break_message = span_warning("祭坛崩碎，只留下受诅者的哀嚎！")
	mansus_conversion_path = /obj/effect/heretic_rune
	custom_materials = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT * 3)

/obj/structure/destructible/cult/item_dispenser/altar/setup_options()
	var/static/list/altar_items = list(
		ELDRITCH_WHETSTONE = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "cult_sharpener"),
			OUTPUT_ITEMS = list(/obj/item/sharpener/cult),
			RADIAL_DESC = "提供[/obj/item/sharpener/cult::name]，可提高剑和匕首的伤害。只能使用一次。",
			),
		CONSTRUCT_SHELL = list(
			PREVIEW_IMAGE = image(icon = 'icons/mob/shells.dmi', icon_state = "construct_cult"),
			OUTPUT_ITEMS = list(/obj/structure/constructshell),
			RADIAL_DESC = "制作[/obj/structure/constructshell::name]，通过灵魂石注入幽影后，就能诞生构装体。\
				构装体能为队伍提供力量、敏捷或辅助能力。",
			),
		UNHOLY_WATER = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/drinks/bottles.dmi', icon_state = "unholyflask"),
			OUTPUT_ITEMS = list(/obj/item/reagent_containers/cup/beaker/unholywater),
			RADIAL_DESC = "提供[/obj/item/reagent_containers/cup/beaker/unholywater::name]，\
				饮用后可治疗所有类型的伤害，包括失血。\
				它还具有凝血剂和轻度兴奋剂的作用，能略微抵抗眩晕和耐力伤害。",
			),
	)

	var/extra_item = extra_options()

	options = altar_items
	if(!isnull(extra_item))
		options += extra_item

/obj/structure/destructible/cult/item_dispenser/altar/extra_options()
	if(!cult_team?.unlocked_heretic_items[PROTEON_ORB_UNLOCKED])
		return
	return list(PROTEON_ORB = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "summoning_orb"),
			OUTPUT_ITEMS = list(/obj/item/proteon_orb),
			RADIAL_DESC = "提供[/obj/item/proteon_orb::name]，可开启传送门，将小型构装体释放到空间站中。"
			),
	)

/obj/structure/destructible/cult/item_dispenser/altar/succcess_message(mob/living/user, obj/item/spawned_item)
	to_chat(user, span_cult_italic("你跪在[src]前，虔诚的信仰为你赢得了[spawned_item]！"))

#undef ELDRITCH_WHETSTONE
#undef CONSTRUCT_SHELL
#undef UNHOLY_WATER
#undef PROTEON_ORB
