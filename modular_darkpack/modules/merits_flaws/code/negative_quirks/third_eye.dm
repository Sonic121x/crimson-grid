/datum/quirk/darkpack/permanent_third_eye
	name = "Permanent Third Eye"
	desc = "多数第三眼可以闭合，在额头上看起来如同疤痕；你的第三眼却几乎一直睁得大大的。对萨鲁布里而言，这十分危险：睿魔尔宣称你们氏族满是信奉恶魔的血噬者，信以为真的血族会因此认出你。对睿魔尔而言，此缺陷是血噬索洛特后奇迹般遗留的征象，几乎注定让你在氏族中轻则受尽猜忌，重则立即被杀。你可以用帽子遮住这只常开的第三眼。只有睿魔尔和萨鲁布里可以选择此缺陷。"
	value = -2
	mob_trait = TRAIT_THIRD_EYE
	gain_text = span_notice("索洛特因你先祖的罪行而诅咒你。你的第三眼睁开，再也无法闭合。")
	lose_text = span_notice("你的第三眼再次闭合。")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)
	icon = FA_ICON_EYE
	failure_message = "你的血液抵抗住了睁开第三眼的冲动。"
	quirk_flags = QUIRK_CHANGES_APPEARANCE
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk/darkpack/permanent_third_eye/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	if(iscarbon(new_holder))
		var/mob/living/carbon/carbon_holder = new_holder
		var/obj/item/organ/eyes/salubri/three_eyes = new()
		three_eyes.Insert(carbon_holder, TRUE, DELETE_IF_REPLACED)

/datum/quirk/darkpack/permanent_third_eye/remove_from_current_holder(quirk_transfer)
	. = ..()
	// replace eyes
	var/eye_type = /obj/item/organ/eyes
	var/obj/item/organ/eyes/new_eyes = new eye_type()
	new_eyes.Insert(quirk_holder, TRUE, DELETE_IF_REPLACED)


