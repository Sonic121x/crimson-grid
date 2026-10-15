// VTM pg. 481
/datum/quirk/darkpack/disfigured
	name = "Disfigured"
	desc = {"严重的毁容让你的外貌令人不安，也令人难忘。
	所有与社交互动有关的掷骰难度增加 2。
	你的外貌属性不能高于 2。"}
	icon = FA_ICON_FACE_GRIMACE
	value = -2
	gain_text = span_notice("你的脸被毁容了！")
	lose_text = span_notice("你觉得自己的样貌好看多了。")
	failure_message = span_notice("你的样貌还不算太糟。")
	mob_trait = TRAIT_DISFIGURED_APPEARANCE
	excluded_clans = list(VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_HARBINGER)// Anyone who already gets masq violating faces or other issues like that.
	var/appearance_to_subtract

/datum/quirk/darkpack/disfigured/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	if(human_holder.st_get_stat(STAT_APPEARANCE) > 2)
		to_chat(human_holder, span_warning("你的外貌属性不能高于 2，因此已被降低。"))
	human_holder.st_add_stat_clamp(STAT_APPEARANCE, 2, type)

/datum/quirk/darkpack/disfigured/remove()
	. = ..()
	quirk_holder.st_remove_stat_clamp(STAT_APPEARANCE, type)
