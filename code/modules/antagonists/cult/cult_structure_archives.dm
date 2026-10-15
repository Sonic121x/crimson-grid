/// Some defines for items the cult archives can create.
#define CULT_BLINDFOLD "狂信徒眼罩"
#define CURSE_ORB "穿梭机诅咒"
#define VEIL_WALKER "帷幕行者"
#define CRIMSON_MEDALLION "猩红勋章"

// Cult archives. Gives out utility items.
/obj/structure/destructible/cult/item_dispenser/archives
	name = "秘典库"
	desc = "一张摆满奥秘手稿和未知语言典籍的书桌。光是看着那些文字就让你毛骨悚然。"
	cult_examine_tip = "可用于制作狂信徒眼罩、穿梭机诅咒法球和帷幕行者装备。"
	icon_state = "tomealtar"
	light_range = 1.5
	light_color = LIGHT_COLOR_FIRE
	break_message = span_warning("书桌碎裂，秘典库中的书籍和典籍也燃烧成灰！")
	mansus_conversion_path = /obj/item/codex_cicatrix
	custom_materials = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT * 3)

/obj/structure/destructible/cult/item_dispenser/archives/setup_options()
	var/static/list/archive_items = list(
		CULT_BLINDFOLD = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/clothing/glasses.dmi', icon_state = "blindfold"),
			OUTPUT_ITEMS = list(/obj/item/clothing/glasses/hud/health/night/cultblind),
			RADIAL_DESC = "制作[/obj/item/clothing/glasses/hud/health/night/cultblind::name]，这副特殊眼罩不会遮蔽教徒的视线。\
				此外，它能显示敌我双方的健康状况，提供夜视，甚至还能抵御强光。",
			),
		CURSE_ORB = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "shuttlecurse"),
			OUTPUT_ITEMS = list(/obj/item/shuttle_curse),
			RADIAL_DESC = "制作易碎的[/obj/item/shuttle_curse::name]。若穿梭机已被呼叫，砸碎它便能诅咒穿梭机，\
				延缓其抵达。最多只能使用[MAX_SHUTTLE_CURSES]个。",
			),
		VEIL_WALKER = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "shifter"),
			OUTPUT_ITEMS = list(/obj/item/cult_shift),
			RADIAL_DESC = "制作[/obj/item/cult_shift::name]。这根小魔杖能让使用者\
				连同正在拖拽的人一起向前传送一段距离。可使用[/obj/item/cult_shift::uses]次。",
			),
	)

	var/extra_item = extra_options()

	options = archive_items
	if(!isnull(extra_item))
		options += extra_item

/obj/structure/destructible/cult/item_dispenser/archives/extra_options()
	if(!cult_team?.unlocked_heretic_items[CRIMSON_MEDALLION_UNLOCKED])
		return
	return list(CRIMSON_MEDALLION = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/clothing/neck.dmi', icon_state = "crimson_medallion"),
			OUTPUT_ITEMS = list(/obj/item/clothing/neck/heretic_focus/crimson_medallion),
			RADIAL_DESC = "制作[/obj/item/clothing/neck/heretic_focus/crimson_medallion::name]，这件强大遗物能持续治疗佩戴者，并允许额外准备一个法术。\
				也可以在手中捏碎它，消耗这件遗物以获得强力治疗。",
			),
	)

/obj/structure/destructible/cult/item_dispenser/archives/succcess_message(mob/living/user, obj/item/spawned_item)
	to_chat(user, span_cult_italic("你从[src]中召出了[spawned_item]！"))

// Preset for the library that doesn't spawn runed metal on destruction, or glow.
/obj/structure/destructible/cult/item_dispenser/archives/library
	icon_state = "tomealtar_off"
	debris = list()

#undef CULT_BLINDFOLD
#undef CURSE_ORB
#undef VEIL_WALKER
#undef CRIMSON_MEDALLION
