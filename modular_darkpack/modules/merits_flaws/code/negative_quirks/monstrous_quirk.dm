/datum/quirk/darkpack/monstrous
	name = "Monstrous"
	desc = "你的躯体扭曲，赤裸裸地显露出兽性，任何看见你的人都会明白这绝非自然所致。你看起来更像凶残的怪物，几乎认不出镜中的自己。你的外貌属性始终为 0，且外表会违反避世戒律，因此在公共场合必须一直戴着面具。诺斯费拉图及其他初始外貌为 0 的血系不能选择此缺陷。"
	value = -3
	mob_trait = TRAIT_MONSTROUS
	gain_text = span_notice("你的躯体遭到扭曲，变得面目可怖……")
	lose_text = span_notice("你的容貌变得柔和，仿佛卸下了沉重的负担。你终于可以再次露出面容。")
	allowed_splats = list(SPLAT_KINDRED, SPLAT_GAROU)
	excluded_clans = list(VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_HARBINGER)
	icon = FA_ICON_FACE_ANGRY
	failure_message = "你的容貌变得柔和，仿佛卸下了沉重的负担。你终于可以再次露出面容。"
	quirk_flags = QUIRK_CHANGES_APPEARANCE
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk/darkpack/monstrous/add(client/client_source)
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.rot_body(1)
	ADD_TRAIT(human_holder, TRAIT_MASQUERADE_VIOLATING_FACE, type)
	human_holder.st_add_stat_clamp(STAT_APPEARANCE, 0, type)

/datum/quirk/darkpack/monstrous/remove()
	. = ..()
	quirk_holder.st_remove_stat_clamp(STAT_APPEARANCE, type)
