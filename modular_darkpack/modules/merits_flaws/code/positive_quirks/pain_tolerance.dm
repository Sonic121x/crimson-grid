/datum/quirk/darkpack/pain_tolerance
	name = "Pain Tolerance"
	desc = "也许你天生是个狠角色，也许你用塑形术切断了痛觉神经。也许你的血亲曾让你经历千般折磨，旁人的手段再难相比。也许疼痛只会让你兴奋。无论如何，伤痛都不会拖慢你的脚步。"
	ttrpg_sources = list(/datum/source_book/vtm20/lotc = 238)
	value = 2
	gain_text = span_notice("你觉得自己能承受更多疼痛。")
	lose_text = span_notice("你觉得自己的疼痛耐受力恢复了普通水平。")
	icon = FA_ICON_SKULL
	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL)
	included_clans = list(VAMPIRE_CLAN_TZIMISCE)
	failure_message = "你觉得自己的疼痛耐受力恢复了普通水平。"

/datum/quirk/darkpack/pain_tolerance/add(client/client_source)
	quirk_holder.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	quirk_holder.add_traits(list(TRAIT_ANALGESIA, TRAIT_NO_DAMAGE_OVERLAY), QUIRK_TRAIT)

/datum/quirk/darkpack/pain_tolerance/remove(client/client_source)
	quirk_holder.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	quirk_holder.remove_traits(list(TRAIT_ANALGESIA, TRAIT_NO_DAMAGE_OVERLAY), QUIRK_TRAIT)
