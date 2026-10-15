/mob/living/carbon/human/proc/get_gender()
	var/visible_gender = get_visible_gender()
	switch(visible_gender)
		if(MALE)
			visible_gender = "男人"
		if(FEMALE)
			visible_gender = "女人"
		else
			visible_gender = "人"
	var/override = dna?.species.visible_gender_override(src)
	if(override)
		visible_gender = override == "beast" ? "野兽" : override

	return visible_gender

/mob/living/carbon/human/proc/get_age()
	switch(age)
		if(70 to INFINITY)
			return "高龄"
		if(60 to 70)
			return "年迈"
		if(50 to 60)
			return "年长"
		if(40 to 50)
			return "中年"
		if(24 to 40)
			return "" //not necessary because this is basically the most common age range
		if(18 to 24)
			return "年轻"
		else
			return "年龄难辨的"

/mob/living/proc/get_generic_name(prefixed = FALSE, lowercase = FALSE)
	var/final_string = name
	if(prefixed)
		final_string = "某个[final_string]"
	return lowercase ? LOWER_TEXT(final_string) : final_string

/mob/living/carbon/human/get_generic_name(prefixed = FALSE, lowercase = FALSE)
//	var/visible_skin = GLOB.skin_tone_names[skin_tone] ? "[GLOB.skin_tone_names[skin_tone]] " : null // Removed until we think of a way to do this without calling people "ugly brown woman"
	var/visible_gender = get_gender(); var/adjective_name = GLOB.darkpack_adjective_names[visible_adjective] ? GLOB.darkpack_adjective_names[visible_adjective] : visible_adjective
	var/visible_age = get_age()
	var/final_string = "[adjective_name ? "[adjective_name]的" : null][visible_age ? "[visible_age]" : null][visible_gender]" // removed [visible_skin]
	if(prefixed)
		final_string = "某个[final_string]"
	return lowercase ? LOWER_TEXT(final_string) : final_string
