/datum/atom_hud/data/auspex_aura
	hud_icons = list(AUSPEX_AURA_HUD)

/obj/effect/aura_overlay
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE

/particles/smoke/aura
	count = 1024
	spawning = 6
	lifespan = 3 SECONDS
	fade = 2.5 SECONDS
	fadein = 0.5 SECONDS
	gravity = list(0, 0, 0)
	friction = 0.01
	velocity = generator(GEN_SPHERE, 0, 0.5, UNIFORM_RAND)
	drift = list(0, 0, 0)
	position = generator(GEN_BOX, list(-8, -8, 0), list(10, 10, 0), UNIFORM_RAND)
	scale = list(0.75, 0.75)
	grow = 0.015
	color = "#ffffff28"

/datum/component/aura
	// A list of currently selected emotions by the player
	var/current_aura = AURA_INNOCENT
	var/current_emotion_name = ""
	var/obj/effect/abstract/shared_particle_holder/aura_smoke
	var/examine_message = ""
	var/obj/effect/aura_overlay/aura_glow_image
	var/obj/effect/aura_overlay/aura_base_image
	var/obj/effect/aura_overlay/aura_smoke_image

	var/obj/effect/aura_overlay/aura_classic_image

/datum/component/aura/RegisterWithParent()
	. = ..()
	var/mob/parent_mob = parent
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.add_atom_to_hud(parent_mob)

	RegisterSignal(parent_mob, COMSIG_MOB_EMOTION_CHANGED, PROC_REF(update_emotions))
	RegisterSignals(parent_mob, list(COMSIG_MOB_UPDATE_AURA, COMSIG_LIVING_GAINED_SPLAT, COMSIG_LIVING_LOSE_SPLAT, SIGNAL_ADDTRAIT(TRAIT_IN_FRENZY), SIGNAL_REMOVETRAIT(TRAIT_IN_FRENZY)), PROC_REF(update_aura))
	RegisterSignal(parent_mob, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	if(isnpc(parent_mob))
		RegisterSignal(parent_mob, COMSIG_COMBAT_MODE_TOGGLED, PROC_REF(on_combat_mode_toggled))

	update_aura()

/datum/component/aura/UnregisterFromParent()
	var/mob/parent_mob = parent
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.remove_atom_from_hud(parent_mob)
	examine_message = ""
	UnregisterSignal(parent_mob, list(COMSIG_MOB_EMOTION_CHANGED, COMSIG_MOB_UPDATE_AURA, COMSIG_LIVING_GAINED_SPLAT, COMSIG_LIVING_LOSE_SPLAT, SIGNAL_ADDTRAIT(TRAIT_IN_FRENZY), SIGNAL_REMOVETRAIT(TRAIT_IN_FRENZY)), COMSIG_ATOM_EXAMINE)
	if(isnpc(parent_mob))
		UnregisterSignal(parent_mob, list(COMSIG_COMBAT_MODE_TOGGLED))
	QDEL_NULL(aura_smoke)
	QDEL_NULL(aura_glow_image)
	QDEL_NULL(aura_base_image)
	QDEL_NULL(aura_smoke_image)

	QDEL_NULL(aura_classic_image)
	return ..()

/datum/component/aura/proc/update_emotions(mob/changed_mob, new_emotion)
	SIGNAL_HANDLER

	if(HAS_TRAIT(changed_mob, TRAIT_AURA_OF_CONFIDENCE))
		new_emotion = "Confidence"
	// CRIMSON GRID ADD: DARK THAUMATURGY
	if(HAS_TRAIT(changed_mob, TRAIT_AURA_OF_INFERNO))
		new_emotion = "Corruption"
	// CRIMSON GRID ADD END: DARK THAUMATURGY

	if(current_aura == new_emotion)
		return

	current_emotion_name = new_emotion
	current_aura = GLOB.aura_list[new_emotion]
	update_aura()

/datum/component/aura/proc/on_combat_mode_toggled(datum/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/npc/parent_mob = parent
	if(parent_mob.combat_mode)
		SEND_SIGNAL(parent_mob, COMSIG_MOB_EMOTION_CHANGED, "Angry")
	if(current_aura == AURA_ANGRY && !parent_mob.combat_mode)
		SEND_SIGNAL(parent_mob, COMSIG_MOB_EMOTION_CHANGED, "Innocent")


/datum/component/aura/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/datum/atom_hud/data/auspex_aura/auspex_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	if(!(user in auspex_hud.hud_users_all_z_levels))
		return
	update_examine_message(null)
	if(!examine_message)
		return
	examine_list += examine_message

/datum/component/aura/proc/update_examine_message(mutable_appearance/aura_appearance)
	var/mob/parent_mob = parent

	if(HAS_TRAIT(parent_mob, TRAIT_AURA_OF_CONFIDENCE))
		examine_message = "其灵光被强烈的优越感淹没，无法辨识出其他任何东西。"
		return

	// CRIMSON GRID ADD END: DARK THAUMATURGY
	if(HAS_TRAIT(parent_mob, TRAIT_AURA_OF_INFERNO))
		examine_message = "其灵光带有明显的邪焰污痕。"
		return
	// CRIMSON GRID ADD END: DARK THAUMATURGY

	switch(current_aura)
		if(AURA_AFRAID)
			examine_message = "其灵光燃着明亮的橙色，紧绷的边缘闪烁不定。"
		if(AURA_AGGRESSIVE)
			examine_message = "其灵光散发出深紫色，如引擎般搏动。"
		if(AURA_ANGRY)
			examine_message = "其灵光燃着猛烈的红色，炽热而躁动。"
		if(AURA_BITTER)
			examine_message = "其灵光沉淀为泥泞般的棕色，浑浊而凝滞。"
		if(AURA_CALM)
			examine_message = "其灵光泛着柔和的蓝色，平稳而从容。"
		if(AURA_COMPASSIONATE)
			examine_message = "其灵光闪着温暖的粉色，坦诚而温柔。"
		if(AURA_CONSERVATIVE)
			examine_message = "其灵光呈现柔淡的薰衣草紫色，内敛而沉着。"
		if(AURA_DEPRESSED)
			examine_message = "其灵光褪为暗淡的灰色，稀薄而迟滞。"
		if(AURA_DESIROUS)
			examine_message = "其灵光暗燃着深红色，浓重而充满牵引力。"
		if(AURA_DISTRUSTFUL)
			examine_message = "其灵光闪着浅绿色，戒备而警觉。"
		if(AURA_ENVIOUS)
			examine_message = "其灵光盘绕着深绿色，紧绷而贪求。"
		if(AURA_EXCITED)
			examine_message = "其灵光迸出紫罗兰色的闪光，急促而不安分。"
		if(AURA_GENEROUS)
			examine_message = "其灵光绽放出柔和的玫瑰色，温暖地向外舒展。"
		if(AURA_HAPPY)
			examine_message = "其灵光闪耀着鲜艳的朱红色，明亮而开阔。"
		if(AURA_HATEFUL)
			examine_message = "其灵光沉为黑色，浓重而压抑。"
		if(AURA_IDEALISTIC)
			examine_message = "其灵光泛着明亮的黄色，清澈而灿烂。"
		if(AURA_INNOCENT)
			examine_message = "其灵光散发出纯净的白色，质朴而毫无戒备。"
		if(AURA_LOVESTRUCK)
			examine_message = "其灵光搏动着温暖的蓝色，柔和而充满渴望。"
		if(AURA_OBSESSED)
			examine_message = "其灵光燃着稳定的绿色，执着而不肯退让。"
		if(AURA_SAD)
			examine_message = "其灵光暗为浅淡的银色，安静而退缩。"
		if(AURA_SPIRITUAL)
			examine_message = "其灵光闪烁着金色，带着幽灵般的色泽。"
		if(AURA_SUSPICIOUS)
			examine_message = "其灵光变幻着深蓝色，躁动不安，仿佛在探寻什么。"
		if(AURA_ANXIOUS)
			examine_message = "其灵光杂乱不堪，如同静电干扰或白噪声。"
		if(AURA_CONFUSED)
			examine_message = "其灵光在斑驳闪烁的色彩间变幻。"
		if(AURA_DAYDREAMING)
			examine_message = "其灵光以鲜明的色彩缓缓闪烁。"
		if(AURA_PSYCHOTIC)
			examine_message = "其灵光色彩迅速旋转，令人目眩。"
		else
			examine_message = ""
	var/quality = GLOB.emotion_to_quality[current_emotion_name]
	if(examine_message && quality)
		examine_message += "你感受到了[quality]。"
	examine_message += "\n \n" // makes the below stand out more
	if(HAS_TRAIT(parent_mob, TRAIT_DIABLERIE) && !HAS_TRAIT(parent_mob, TRAIT_HIDDEN_DIABLERIE))
		examine_message += "黑色脉络在其灵光中搏动。"
	if(HAS_TRAIT(parent_mob, TRAIT_FRENETIC_AURA))
		examine_message += "其灵光显得格外充满活力。"

	if(has_pale_aura(parent_mob))
		examine_message += "其灵光色彩显得苍白。"
	else if(has_pale_blotches(parent_mob))
		examine_message += "其灵光上浮现着苍白的斑块。"

	if(isavatar(parent_mob) || isobserver(parent_mob))
		examine_message += "其灵光微弱而断续，时隐时现。"

/datum/component/aura/proc/update_aura()
	SIGNAL_HANDLER

	var/mob/parent_mob = parent
	var/image/holder = parent_mob.hud_list[AUSPEX_AURA_HUD]
	if(!holder)
		holder = new
	holder.plane = ABOVE_LIGHTING_PLANE
	if(!aura_smoke)
		aura_smoke = new /obj/effect/abstract/shared_particle_holder(null, /particles/smoke/aura)
		aura_smoke.blend_mode = 2
		aura_smoke.add_filter("particle_blur", 1, gauss_blur_filter(8))
	var/mutable_appearance/aura_appearance
	if(parent_mob.heart_is_beating())
		aura_appearance = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "aura", ABOVE_MOB_LAYER, parent_mob, ABOVE_GAME_PLANE)
	else
		aura_appearance = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "aura_dead", ABOVE_MOB_LAYER, parent_mob, ABOVE_GAME_PLANE)

	update_aura_colors(aura_appearance, holder)
	update_aura_overlays(aura_appearance, holder)
	update_aura_filters(aura_appearance, holder)
	update_examine_message(aura_appearance)

/datum/component/aura/proc/is_color(input_text)
	if(findtext(input_text, GLOB.is_color))
		return TRUE
	return FALSE

/datum/component/aura/proc/update_aura_colors(mutable_appearance/aura_appearance, image/holder)
	var/output_color
	if(is_color(current_aura))
		output_color = current_aura
	else
		output_color = null

	aura_appearance.color = output_color

	if(aura_smoke)
		aura_smoke.particles.color = output_color ? (output_color + pick("20","30")) : "#ffffff09"

	holder.icon = null
	holder.icon_state = null
	holder.color = null

	var/mob/parent_mob = parent
	if(HAS_TRAIT(parent_mob, TRAIT_AURA_OF_CONFIDENCE))
		return

	if(output_color && has_pale_aura(parent_mob))
		var/list/hsv_color_value = rgb2hsv(output_color)
		hsv_color_value[2] = hsv_color_value[2] * 0.7 // Reduce saturation for kindred
		aura_appearance.color = hsv2rgb(hsv_color_value)

	if(HAS_TRAIT(parent_mob, TRAIT_FRENETIC_AURA))
		var/list/hsv_color_value = rgb2hsv(aura_appearance.color || "#ffffff")
		hsv_color_value[2] = hsv_color_value[2] * 1.5 // Way brighter for shapeshifters
		aura_appearance.color = hsv2rgb(hsv_color_value)
		aura_appearance.icon_state = "old_aura_bright"


/datum/component/aura/proc/update_aura_overlays(mutable_appearance/aura_appearance, image/holder)
	holder.vis_contents = aura_smoke ? list(aura_smoke) : list()
	var/mob/parent_mob = parent
	if(!aura_glow_image)
		aura_glow_image = new(null)
		aura_glow_image.icon = 'modular_darkpack/modules/powers/icons/auras.dmi'
		aura_glow_image.icon_state = "aura"
		aura_glow_image.layer = ABOVE_MOB_LAYER - 0.01
		aura_glow_image.plane = ABOVE_LIGHTING_PLANE
		aura_glow_image.add_filter("ambient_blur", 1, gauss_blur_filter(12))
	aura_glow_image.color = aura_appearance.color
	aura_glow_image.icon_state = aura_appearance.icon_state || "aura"
	aura_glow_image.alpha = 20
	holder.vis_contents += aura_glow_image

	if(!aura_base_image)
		aura_base_image = new(null)
		aura_base_image.icon = 'modular_darkpack/modules/powers/icons/auras.dmi'
		aura_base_image.icon_state = "aura"
		aura_base_image.layer = ABOVE_MOB_LAYER
		aura_base_image.plane = ABOVE_LIGHTING_PLANE
	aura_base_image.color = aura_appearance.color
	aura_base_image.icon_state = aura_appearance.icon_state || "aura"
	aura_base_image.transform = matrix(0.8, MATRIX_SCALE)
	aura_base_image.alpha = 175
	holder.vis_contents += aura_base_image


	if(!aura_classic_image)
		aura_classic_image = new(null)
		aura_classic_image.icon = 'modular_darkpack/modules/powers/icons/auras.dmi'
		aura_classic_image.icon_state = "old_aura"
		aura_classic_image.layer = ABOVE_MOB_LAYER + 4.03
		aura_classic_image.plane = ABOVE_LIGHTING_PLANE
	aura_classic_image.color = aura_appearance.color
	aura_classic_image.icon_state = "old_aura"
	aura_classic_image.alpha = 255

	if(!aura_smoke_image)
		aura_smoke_image = new(null)
		aura_smoke_image.icon = 'modular_darkpack/modules/powers/icons/auras.dmi'
		aura_smoke_image.icon_state = "smoke"
		aura_smoke_image.layer = ABOVE_MOB_LAYER + 4.01
		aura_smoke_image.plane = ABOVE_LIGHTING_PLANE
	aura_smoke_image.color = aura_appearance.color
	aura_smoke_image.alpha = 50

	var/matrix/smoke_transform = matrix()
	smoke_transform.Scale(1, pick(1.25, 1.5))
	aura_smoke_image.transform = smoke_transform

	var/matrix/classic_aura_transform = matrix()
	classic_aura_transform.Scale(pick(0.65, 0.75), 1)
	aura_classic_image.transform = classic_aura_transform

	holder.vis_contents += aura_classic_image
	holder.vis_contents += aura_smoke_image

	if(HAS_TRAIT(parent_mob, TRAIT_AURA_OF_CONFIDENCE))
		return

	if(HAS_TRAIT(parent_mob, TRAIT_DIABLERIE) && !HAS_TRAIT(parent_mob, TRAIT_HIDDEN_DIABLERIE))
		var/mutable_appearance/diablerie_image = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "diab", ABOVE_MOB_LAYER + 1, parent_mob, ABOVE_GAME_PLANE)
		holder.add_overlay(diablerie_image)
		aura_classic_image.color = "#1717178b"

	if(current_aura == AURA_ANXIOUS)
		var/icon/temporary_icon_holder = icon('modular_darkpack/modules/powers/icons/auras.dmi', "old_aura")
		var/icon/static_icon = getStaticIcon(temporary_icon_holder)
		var/obj/effect/aura_overlay/static_image = new(null)
		static_image.icon = static_icon
		static_image.icon_state = "old_aura"
		static_image.layer = ABOVE_MOB_LAYER + 2
		static_image.plane = ABOVE_LIGHTING_PLANE
		static_image.appearance_flags |= RESET_COLOR
		static_image.alpha = 150
		holder.vis_contents += static_image

	if(has_pale_blotches(parent_mob))
		var/list/hsv_color_value = rgb2hsv(aura_appearance.color)
		hsv_color_value[2] = hsv_color_value[2] * 0.7 // Reduce saturation for ghouls
		aura_smoke_image.color = hsv2rgb(hsv_color_value)
		aura_classic_image.icon_state = "old_aura_ghoul"
		aura_smoke_image.alpha = 50

	if(isavatar(parent_mob) || isobserver(parent_mob))
		holder.opacity = holder.opacity * 0.5


/datum/component/aura/proc/update_aura_filters(mutable_appearance/aura_appearance, image/holder)
	remove_wibbly_filters(holder)
	apply_wibbly_filters(holder)
	holder.add_filter("aura_glow", 1, gauss_blur_filter(2))

/datum/component/aura/proc/has_pale_aura(mob/parent_mob)
	if(HAS_TRAIT(parent, TRAIT_PALE_AURA) && !HAS_TRAIT(parent, TRAIT_DECEPTIVE_AURA))
		if(get_kindred_splat(parent_mob))
			var/mob/living/carbon/human/lick = parent_mob
			var/datum/st_stat/morality_path/morality/stat_morality = lick.storyteller_stats[STAT_MORALITY]
			var/alignment = stat_morality?.morality_path?.alignment
			if(alignment != MORALITY_HUMANITY) // non-humanity licks have standard kindred auras that give them away // Also catches a null value.
				return TRUE

		return TRUE

/datum/component/aura/proc/has_pale_blotches(mob/parent_mob)
	if(!HAS_TRAIT(parent_mob, TRAIT_PALE_AURA) && get_ghoul_splat(parent_mob))
		return TRUE


/mob/proc/heart_is_beating()
	return FALSE

/mob/living/heart_is_beating()
	if(stat == DEAD)
		return FALSE

	return TRUE

/mob/living/carbon/human/heart_is_beating()
	var/obj/item/organ/heart/beating_heart = get_organ_slot(ORGAN_SLOT_HEART)
	if(!istype(beating_heart) || !(beating_heart.is_beating()))
		return FALSE

	// high humanity kindred OR kindred with blush of health avoid getting the still heart. in auspex, their hearts will instead show like humans; beating!
	if(get_kindred_splat(src))
		var/datum/st_stat/morality_path/morality/stat_morality = storyteller_stats[STAT_MORALITY]
		if((stat_morality?.morality_path?.alignment != MORALITY_HUMANITY || stat_morality?.get_score() < 5) && !HAS_TRAIT(src, TRAIT_BLUSH_OF_HEALTH))
			return FALSE

	return TRUE
