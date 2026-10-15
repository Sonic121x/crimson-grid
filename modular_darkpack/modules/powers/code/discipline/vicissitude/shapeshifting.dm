#define CHANGE_HAIR "Change Hair"
#define CHANGE_BEARD "Change Beard"
#define CHANGE_SEX  "Change Sex"
#define CHANGE_NAME "Change Name"
#define CHANGE_EYES "Change Eyes"
#define CHANGE_RACE "Change Race"
#define CHANGE_HEIGHT "Change Height"
#define CHOICE_OPTIONS list(CHANGE_HAIR, CHANGE_BEARD, CHANGE_SEX, CHANGE_EYES, CHANGE_NAME, CHANGE_RACE, CHANGE_HEIGHT)

/datum/action/cooldown/mob_cooldown/shapeshift
	owner_has_control = FALSE
	/// What choices we get to pick.
	var/list/choices = CHOICE_OPTIONS
	/// The range of this action.
	var/range = 1

/datum/action/cooldown/mob_cooldown/shapeshift/New(Target, original)
	. = ..()
	update_choices()

/datum/action/cooldown/mob_cooldown/shapeshift/proc/update_choices()
	for(var/i in choices)
		choices[i] = localized_radial_choice(icon('modular_darkpack/modules/powers/icons/shapeshifting_radial.dmi', i), list(CHANGE_HAIR = "改变头发", CHANGE_BEARD = "改变胡须", CHANGE_SEX = "改变性别", CHANGE_NAME = "改变姓名", CHANGE_EYES = "改变眼睛", CHANGE_RACE = "改变肤色", CHANGE_HEIGHT = "改变身高")[i])

/datum/action/cooldown/mob_cooldown/shapeshift/Activate(atom/target)
	. = ..()
	display_radial_menu(target)
	return TRUE

/datum/action/cooldown/mob_cooldown/shapeshift/proc/display_radial_menu(mob/target)
	var/chosen_option = show_radial_menu(owner, target, choices, target, radius = 36, tooltips = TRUE)
	if(!chosen_option)
		return TRUE

	if(((target.pulledby == owner) && (owner.grab_state >= GRAB_AGGRESSIVE)) || (target == owner))
		switch(chosen_option)
			if(CHANGE_HAIR)
				change_hair(target)
			if(CHANGE_BEARD)
				change_beard(target)
			if(CHANGE_SEX)
				change_sex(target)
			if(CHANGE_NAME)
				change_name(target)
			if(CHANGE_EYES)
				change_eyes(target)
			if(CHANGE_RACE)
				change_race(target)
			if(CHANGE_HEIGHT)
				change_height(target)
	else
		to_chat(owner, span_danger("你必须牢牢抓住[target]！"))
		return TRUE

	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	return display_radial_menu(target)

/datum/action/cooldown/mob_cooldown/shapeshift/proc/change_sex(mob/living/carbon/human/target)
	var/chosen_sex = tgui_input_list(owner, "选择性别。", "确认", list("男性", "女性", "复数称谓", "中性"))
	if(!chosen_sex)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	switch(chosen_sex)
		if("男性")
			target.gender = MALE
		if("女性")
			target.gender = FEMALE
		if("复数称谓")
			target.gender = PLURAL
		if("中性")
			target.gender = NEUTER
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]性别的改变。"))

	var/chosen_physique = tgui_input_list(owner, "也要改变体型吗？", "确认", list("男性体型", "女性体型"))
	if(!chosen_physique)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	target.physique = (chosen_physique == "男性体型") ? MALE : FEMALE
	target.dna.update_ui_block(/datum/dna_block/identity/gender)
	target.update_body(is_creating = TRUE) // or else physique won't change properly
	target.update_appearance(UPDATE_OVERLAYS) //(hulk male/female)
	target.update_clothing(ITEM_SLOT_ICLOTHING) // update gender shaped clothing
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]体型的改变。"))
	return TRUE

/datum/action/cooldown/mob_cooldown/shapeshift/proc/change_eyes(mob/living/carbon/human/target)
	var/new_eye_color = input(owner, "选择眼睛颜色", "眼睛颜色", target.eye_color_left) as color|null
	if(!new_eye_color)
		return TRUE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	target.set_eye_color(sanitize_hexcolor(new_eye_color))
	target.dna.update_ui_block(/datum/dna_block/identity/eye_colors)
	target.update_body()
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]眼睛颜色的改变。"))
	return TRUE

/datum/action/cooldown/mob_cooldown/shapeshift/proc/change_beard(mob/living/carbon/human/target)
	var/new_style = localized_accessory_input(owner, "选择胡须样式", "仪容修整", SSaccessories.facial_hairstyles_list)
	if(!new_style)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	target.set_facial_hairstyle(new_style, update = TRUE)
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]胡须样式的改变。"))

	var/new_face_color = input(owner, "选择胡须颜色", "胡须颜色", target.facial_hair_color) as color|null
	if(!new_face_color)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	target.set_facial_haircolor(sanitize_hexcolor(new_face_color))
	target.dna.update_ui_block(/datum/dna_block/identity/facial_color)
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]胡须颜色的改变。"))
	return TRUE

/datum/action/cooldown/mob_cooldown/shapeshift/proc/change_hair(mob/living/carbon/human/target)
	var/new_style = localized_accessory_input(owner, "选择发型", "仪容修整", SSaccessories.hairstyles_list)
	if(!new_style)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	target.set_hairstyle(new_style, update = TRUE)
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]发型的改变。"))

	var/new_hair_color = input(owner, "选择发色", "头发颜色", target.hair_color) as color|null
	if(!new_hair_color)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	target.set_haircolor(sanitize_hexcolor(new_hair_color))
	target.dna.update_ui_block(/datum/dna_block/identity/hair_color)
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]发色的改变。"))
	return TRUE

/datum/action/cooldown/mob_cooldown/shapeshift/proc/change_name(mob/living/carbon/human/target)
	var/newname = sanitize_name(tgui_input_text(owner, "我们又叫什么来着？", "更改姓名", target.real_name, MAX_NAME_LEN))
	if(!newname || newname == target.real_name)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	target.real_name = newname
	if(target.dna)
		target.dna.real_name = newname
	if(target.mind)
		target.mind.name = newname
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]姓名的改变。"))
	return TRUE

/datum/action/cooldown/mob_cooldown/shapeshift/proc/change_race(mob/living/carbon/human/target)
	var/list/skin_tones = list()
	for(var/skin_tone in GLOB.skin_tone_names)
		var/skin_tone_name = GLOB.skin_tone_names[skin_tone]
		skin_tones[skin_tone_name] = skin_tone

	var/new_s_tone = tgui_input_list(owner, "选择肤色", "更改肤色", skin_tones)
	new_s_tone = skin_tones[new_s_tone]
	if(!new_s_tone)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	target.skin_tone = new_s_tone
	target.dna.update_ui_block(/datum/dna_block/identity/skin_tone)
	target.update_body(is_creating = TRUE)
	target.update_appearance(UPDATE_OVERLAYS)
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]肤色的改变。"))
	return TRUE

/datum/action/cooldown/mob_cooldown/shapeshift/proc/change_height(mob/living/carbon/human/target)
	var/list/heights = list(
		"很高" = HUMAN_HEIGHT_TALLER,
		"高" = HUMAN_HEIGHT_TALL,
		"中等" = HUMAN_HEIGHT_MEDIUM,
		"矮" = HUMAN_HEIGHT_SHORT,
		"很矮" = HUMAN_HEIGHT_SHORTEST,
		)

	var/new_height = tgui_input_list(owner, "选择身高", "更改身高", heights)
	new_height = heights[new_height]
	if(!new_height)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	if(!do_after(owner, delay = 1 TURNS, target = target))
		return FALSE
	target.set_mob_height(new_height)
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(owner, span_notice("你完成了对[target]身高的改变。"))
	return TRUE

#undef CHANGE_HAIR
#undef CHANGE_BEARD
#undef CHANGE_SEX
#undef CHANGE_EYES
#undef CHANGE_NAME
#undef CHANGE_RACE
#undef CHANGE_HEIGHT
#undef CHOICE_OPTIONS
