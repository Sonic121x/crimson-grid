// Homebrew?
/datum/quirk/darkpack/illegal_identity
	name = "Illegal Identity"
	desc = "非法移民？法律上已经死亡？生来就是一匹狼？警察可不会高兴。"
	ttrpg_sources = list(/datum/source_book/homebrew = WE_MADE_IT_UP)
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN
	icon = FA_ICON_PERSON_CIRCLE_QUESTION
	mob_trait = TRAIT_ILLEGAL_IDENTITY
	gain_text = span_warning("你觉得自己的合法身份证明还没准备好。")
	lose_text = span_notice("你觉得自己的身份终于得到了官方认可。")
	medical_record_text = "患者未持有效身份证明登记。"
	//excluded_clans = list(VAMPIRE_CLAN_RAVNOS) // They are forced to take this
	failure_message = "哦，我真正的身份证在这儿，看来之前放错地方了……"

/datum/quirk/darkpack/illegal_identity/add()
	. = ..()
	var/mob/living/carbon/human/criminal = astype(quirk_holder)
	if(!criminal)
		return

	var/obj/item/passport/passport = locate() in criminal // In pockets
	if(!passport && criminal.back)
		passport = locate() in criminal.back // In backpack
	if(passport && passport.owner == criminal.real_name)
		passport.link_human(criminal)
	//drivers license too
	var/obj/item/card/drivers_license/license = locate() in criminal // In pockets
	if(!license && criminal.back)
		license = locate() in criminal.back // In backpack
	if(license)
		license.link_human(criminal)
