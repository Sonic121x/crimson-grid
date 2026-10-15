/obj/structure/sign/eyechart
	icon_state = "eyechart"
	name = "视力表"
	desc = "印有一系列彩色条纹和大小不一字母的海报，\
		用于检查色觉和失明——我是说，视力。"
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/eyechart, 32)

/obj/structure/sign/eyechart/examine(mob/user)
	. = ..()
	if(isobserver(user))
		return

	if(!user.can_read(src, READING_CHECK_LITERACY, silent = TRUE) || !user.has_language(/datum/language/common, UNDERSTOOD_LANGUAGE))
		if(!user.is_blind())
			. += "<hr>你盯着满墙符号，试图理解它们……"
			. += span_warning("……但你根本不知道它们是什么意思。")
		return

	if(user.is_blind())
		. += "<hr>你摸了摸海报。"
		. += span_notice("嗯，摸起来像是……\"E、P、D……\"还好这张表有盲文！")
		return

	if(!user.can_read(src, READING_CHECK_LIGHT, silent = TRUE))
		. += "<hr>你眯着眼看向视力表。"
		. += span_warning("……但这里太暗，什么也看不清。")
		return

	var/colorblind = HAS_TRAIT(user, TRAIT_COLORBLIND)
	var/obj/item/organ/eyes/eye = user.get_organ_slot(ORGAN_SLOT_EYES)
	// eye null checks here are for mobs without eyes.
	// humans missing eyes will be caught by the is_blind check above.
	var/eye_goodness = isnull(eye) ? 0 : eye.damage
	var/little_bad = isnull(eye) ? 20 : eye.low_threshold
	var/very_bad = isnull(eye) ? 30 : eye.high_threshold

	if(user.has_status_effect(/datum/status_effect/eye_blur))
		eye_goodness = max(eye_goodness, very_bad + 1)
	if(user.is_nearsighted_currently())
		eye_goodness = max(eye_goodness, little_bad + 1)
	eye_goodness += ((get_dist(user, src) - 2) * 5) // add a modifier based on distance, so closer = "better", further = "worse"

	. += "<hr>你像从前那样读起了视力表。"
	if(eye_goodness <= 0)
		. += span_notice("\"E、F、P……\"没错，你能一直读到[colorblind ? "棕色——等等，那不该是红色吗？——" : "红色"]那一行。")
	else if(eye_goodness < little_bad)
		. += span_notice("\"E、F、P……\"大部分字母都看得清，但[colorblind ? "灰色——等等，那不该是绿色吗？——" : "绿色"]那一行以下就有些吃力了。")
	else if(eye_goodness < very_bad)
		. += span_warning("\"E、F、P……？\"你能认出大字母，小字母则有些模糊。")
	else
		. += span_warning("\"E、P、D……？\"你连大字母都几乎看不清，更别提小字母了。")
