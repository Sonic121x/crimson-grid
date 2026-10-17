/obj/item/clothing/neck
	name = "项链"
	icon = 'icons/obj/clothing/neck.dmi'
	abstract_type = /obj/item/clothing/neck
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	interaction_flags_click = NEED_DEXTERITY
	strip_delay = 4 SECONDS
	equip_delay_other = 4 SECONDS

/obj/item/clothing/neck/worn_overlays(mutable_appearance/standing, isinhands = FALSE)
	. = ..()
	if(isinhands || !(body_parts_covered & HEAD))
		return
	if(damaged_clothes)
		. += mutable_appearance('icons/effects/item_damage.dmi', "damagedmask")

/obj/item/clothing/neck/separate_worn_overlays(mutable_appearance/standing, mutable_appearance/draw_target, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if (isinhands || !(body_parts_covered & HEAD))
		return
	var/blood_overlay = get_blood_overlay("mask", bodyshape)
	if (blood_overlay)
		. += blood_overlay

/obj/item/clothing/neck/bowtie
	name = "领结"
	desc = "一个小巧的新丝领结。"
	inhand_icon_state = "" //no inhands
	w_class = WEIGHT_CLASS_SMALL
	custom_price = PAYCHECK_CREW
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/bowtie"
	post_init_icon_state = "bowtie_greyscale"
	greyscale_config = /datum/greyscale_config/ties
	greyscale_config_worn = /datum/greyscale_config/ties/worn
	greyscale_colors = "#151516ff"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/bowtie/rainbow
	name = "彩虹领结"
	desc = "一个特别巨大的彩虹色新丝领结。"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "bowtie_rainbow"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie
	name = "光滑领带"
	desc = "一条新丝领带。"
	inhand_icon_state = "" //no inhands
	alternate_worn_layer = LOW_NECK_LAYER // So that it renders below suit jackets, MODsuits, etc
	w_class = WEIGHT_CLASS_SMALL
	custom_price = PAYCHECK_CREW
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/tie"
	post_init_icon_state = "tie_greyscale_tied"
	greyscale_config = /datum/greyscale_config/ties
	greyscale_config_worn = /datum/greyscale_config/ties/worn
	greyscale_colors = "#4d4e4e"
	flags_1 = IS_PLAYER_COLORABLE_1
	/// All ties start untied unless otherwise specified
	var/is_tied = FALSE
	/// How long it takes to tie the tie
	var/tie_timer = 4 SECONDS
	/// Is this tie a clip-on, meaning it does not have an untied state?
	var/clip_on = FALSE

/obj/item/clothing/neck/tie/Initialize(mapload)
	. = ..()
	if(!clip_on)
		update_appearance(UPDATE_ICON)
	register_context()

/obj/item/clothing/neck/tie/examine(mob/user)
	. = ..()
	. += span_notice("领带可戴在外套外侧或内侧，按住Alt右键点击切换。")
	if(clip_on)
		. += span_notice("仔细观察就会发现，它其实是巧妙伪装的夹式领带。")
	else if(!is_tied)
		. += span_notice("按住Alt点击即可系上领带。")
	else
		. += span_notice("按住Alt点击即可解开领带。")

/obj/item/clothing/neck/tie/click_alt(mob/user)
	if(clip_on)
		return NONE
	to_chat(user, span_notice("你集中精神，开始[is_tied ? "解开" : "系上"][src]……"))
	var/tie_timer_actual = tie_timer
	// Mirrors give you a boost to your tying speed. I realize this stacks and I think that's hilarious.
	for(var/obj/structure/mirror/reflection in view(2, user))
		tie_timer_actual *= 0.8
	// Heads of staff are experts at tying their ties.
	if(HAS_TRAIT(user, TRAIT_FAST_TYING))
		tie_timer_actual *= 0.5
	// Tie/Untie our tie
	if(!do_after(user, tie_timer_actual))
		to_chat(user, span_notice("你一分神，手指便从[src]上滑脱了。"))
		return CLICK_ACTION_BLOCKING
	// Clumsy & Dumb people have trouble tying their ties.
	if((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(50))
		to_chat(user, span_notice("你怎么也抓不稳[src]！"))
		return CLICK_ACTION_BLOCKING
	// Success!
	is_tied = !is_tied
	user.visible_message(
		span_notice("[user]整理了领带[HAS_TRAIT(user, TRAIT_BALD) ? "" : "，又用手抹了抹头发"]。"),
		span_notice("你成功[is_tied ? "系好" : "解开"]了[src]！"),
	)
	update_appearance(UPDATE_ICON)
	user.update_clothing(ITEM_SLOT_NECK)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/neck/tie/click_alt_secondary(mob/user)
	alternate_worn_layer = (alternate_worn_layer == initial(alternate_worn_layer) ? NONE : initial(alternate_worn_layer))
	user.update_clothing(ITEM_SLOT_NECK)
	balloon_alert(user, "已戴在外套[alternate_worn_layer == initial(alternate_worn_layer) ? "内侧" : "外侧"]")

/obj/item/clothing/neck/tie/update_icon()
	. = ..()
	if(clip_on)
		return
	// Normal strip & equip delay, along with 2 second self equip since you need to squeeze your head through the hole.
	if(is_tied)
		icon_state = "tie_greyscale_tied"
		strip_delay = 4 SECONDS
		equip_delay_other = 4 SECONDS
		equip_delay_self = 2 SECONDS
	else // Extremely quick strip delay, it's practically a ribbon draped around your neck
		icon_state = "tie_greyscale_untied"
		strip_delay = 1 SECONDS
		equip_delay_other = 1 SECONDS
		equip_delay_self = 0 SECONDS

/obj/item/clothing/neck/tie/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_RMB] = "戴在外套[alternate_worn_layer == initial(alternate_worn_layer) ? "外侧" : "内侧"]"
	if(clip_on)
		return CONTEXTUAL_SCREENTIP_SET
	if(is_tied)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "解开"
	else
		context[SCREENTIP_CONTEXT_ALT_LMB] = "系上"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/clothing/neck/tie/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	var/mob/living/carbon/human/wearer = loc
	if(!ishuman(wearer))
		return
	var/obj/item/clothing/under/undershirt = wearer.w_uniform
	if(!istype(undershirt) || !LAZYLEN(undershirt.attached_accessories))
		return
	if(alternate_worn_layer)
		. += undershirt.get_accessory_overlays()

/obj/item/clothing/neck/tie/blue
	name = "蓝色领带"
	icon_state = "/obj/item/clothing/neck/tie/blue"
	post_init_icon_state = "tie_greyscale_untied"
	greyscale_colors = "#5275b6ff"

/obj/item/clothing/neck/tie/red
	name = "红色领带"
	icon_state = "/obj/item/clothing/neck/tie/red"
	post_init_icon_state = "tie_greyscale_untied"
	greyscale_colors = "#c23838ff"

/obj/item/clothing/neck/tie/red/tied
	is_tied = TRUE
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/neck/tie/red/hitman
	desc = "这是一条价值47,000美元的杀手典范定制领带。面料来自库克韦尔领带微型养殖场饲养的新蚕，图案则是裁缝修士自二十一世纪以来秘密传承的样式！"
	tie_timer = 1 SECONDS // You're a professional.
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/neck/tie/red/hitman/tied
	is_tied = TRUE
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/neck/tie/black
	name = "黑色领带"
	icon_state = "/obj/item/clothing/neck/tie/black"
	post_init_icon_state = "tie_greyscale_untied"
	greyscale_colors = "#151516ff"

/obj/item/clothing/neck/tie/black/tied
	is_tied = TRUE
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/neck/tie/horrible
	name = "糟糕领带"
	desc = "一条新丝领带。这条真恶心。"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "horribletie"
	post_init_icon_state = null
	clip_on = TRUE
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/robe_cape
	name = "长袍披肩"
	desc = "一件舒适的披肩，垂在背后，以胸针固定在颈边。"
	icon = 'icons/map_icons/clothing/neck.dmi' // CRIMSON EDIT CHANGE - ORIGINAL: icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/robe_cape"
	post_init_icon_state = "robe_cape"
	worn_icon = 'icons/mob/clothing/neck.dmi'
	worn_icon_state = "robe_cape"
	abstract_type = /obj/item/clothing/neck
	greyscale_config = /datum/greyscale_config/robe_cape
	greyscale_config_worn = /datum/greyscale_config/robe_cape/worn
	greyscale_colors = "#2a2844"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/robe_cape/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/surgery_aid, "cape")

/obj/item/clothing/neck/tie/detective
	name = "宽松领带"
	desc = "一条松松系着的领带，是过劳侦探的绝佳配饰。"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "detective"
	post_init_icon_state = null
	clip_on = TRUE
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/stethoscope
	name = "听诊器"
	desc = "用于聆听人体声音的老式医疗器械，还能让你看起来很懂行。"
	icon_state = "stethoscope"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/neck/stethoscope/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/obj/item/clothing/neck/stethoscope/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]把[src]贴在自己胸口！看来听不到多少声音了！"))
	return OXYLOSS

/obj/item/clothing/neck/stethoscope/attack(mob/living/target, mob/living/user)
	if(!ishuman(target) || !isliving(user))
		return ..()
	if(user.combat_mode)
		return

	var/mob/living/carbon/carbon_patient = target
	var/body_part = carbon_patient.parse_zone_with_bodypart(user.zone_selected)
	var/oxy_loss = carbon_patient.get_oxy_loss()

	var/heart_strength
	var/pulse_pressure
	var/having_heart_attack = carbon_patient.has_status_effect(/datum/status_effect/heart_attack)
	var/heart_noises = TRUE

	var/obj/item/organ/heart/heart = carbon_patient.get_organ_slot(ORGAN_SLOT_HEART)
	var/obj/item/organ/lungs/lungs = carbon_patient.get_organ_slot(ORGAN_SLOT_LUNGS)
	var/obj/item/organ/liver/liver = carbon_patient.get_organ_slot(ORGAN_SLOT_LIVER)
	var/obj/item/organ/appendix/appendix = carbon_patient.get_organ_slot(ORGAN_SLOT_APPENDIX)

	var/render_list = list()//information will be packaged in a list for clean display to the user

	//determine what specific action we're taking
	switch (body_part)
		if(BODY_ZONE_CHEST)//Listening to the chest
			user.visible_message(span_notice("[user]把[src]贴在[carbon_patient]的[parse_zone(body_part)]，仔细聆听。"), ignored_mobs = user)
			if(HAS_TRAIT(user, TRAIT_DEAF))
				to_chat(user, span_notice("你把[src]贴在[carbon_patient]的[parse_zone(body_part)]。可惜你听不见，再怎么听也没用。"))
				return
			else
				render_list += span_info("你把[src]贴在[carbon_patient]的[parse_zone(body_part)]：\n")

			//assess breathing
			var/lung_noises = TRUE
			if(isnull(lungs) \
				|| carbon_patient.stat == DEAD \
				|| (HAS_TRAIT(carbon_patient, TRAIT_FAKEDEATH)) \
				|| (HAS_TRAIT(carbon_patient, TRAIT_NOBREATH))\
				|| carbon_patient.failed_last_breath \
				|| carbon_patient.losebreath)//If pt is dead or otherwise not breathing
				render_list += "<span class='danger ml-1'>对方没有呼吸！</span>\n"
				lung_noises = FALSE

			else if(lungs.damage > 10)//if breathing, check for lung damage
				render_list += "<span class='danger ml-1'>你听到了对方肺部的积液声！</span>\n"
			else if(oxy_loss > 10)//if they have suffocation damage
				render_list += "<span class='danger ml-1'>对方呼吸沉重！</span>\n"
			else
				render_list += "<span class='notice ml-1'>对方呼吸正常。</span>\n"//they're okay :D
			if(lung_noises)
				render_list += "<span class='notice ml-1'>[lungs.hear_breath_noise(user)]</span>\n"
			//assess heart
			if(body_part == BODY_ZONE_CHEST)//if we're listening to the chest
				if(isnull(heart) || !heart.is_beating() || carbon_patient.stat == DEAD)
					render_list += "<span class='danger ml-1'>你听不到心跳！</span>\n"//they're dead or their heart isn't beating
					heart_noises = FALSE
				else if(having_heart_attack)
					render_list += "<span class='danger ml-1'>你听到了急促而不规则的心跳。</span>\n"
				else if(heart.damage > 10 || carbon_patient.get_blood_volume(apply_modifiers = TRUE) <= BLOOD_VOLUME_OKAY)
					render_list += "<span class='danger ml-1'>你听到了微弱的心跳。</span>\n"//their heart is damaged, or they have critical blood
				else
					render_list += "<span class='notice ml-1'>你听到了健康的心跳。</span>\n"//they're okay :D
				if(heart_noises)
					render_list += "<span class='notice ml-1'>[heart.hear_beat_noise(user)]</span>\n"

		if(BODY_ZONE_PRECISE_GROIN)//If we're targeting the groin
			render_list += span_info("你小心地按压[carbon_patient]的腹部：\n")
			user.visible_message(span_notice("[user]用手按压[carbon_patient]的腹部。"), ignored_mobs = user)

			//assess abdominal organs
			var/appendix_okay = TRUE
			var/liver_okay = TRUE
			if(!liver)//sanity check, ensure the patient actually has a liver
				render_list += "<span class='danger ml-1'>在对方本应有肝脏的位置，你什么也摸不到。</span>\n"
				liver_okay = FALSE
			else
				if(liver.damage > 10)
					render_list += "<span class='danger ml-1'>对方的肝脏摸起来发硬。</span>\n"//their liver is damaged
					liver_okay = FALSE
			if(!appendix)//sanity check, ensure the patient actually has an appendix
				render_list += "<span class='danger ml-1'>在对方本应有阑尾的位置，你什么也摸不到。</span>\n"
				appendix_okay = FALSE
			else
				if(appendix.damage > 10 && !IS_UNCONSCIOUS_OR_CRIT(carbon_patient))
					render_list += "<span class='danger ml-1'>你从[target]的阑尾处抬手时，对方尖叫起来！</span>\n"//scream if their appendix is damaged and they're awake
					target.emote("scream")
					appendix_okay = FALSE
			if(liver_okay && appendix_okay)//if they have all their organs and have no detectable damage
				render_list += "<span class='notice ml-1'>你没有发现异常。</span>\n"//they're okay :D

		if(BODY_ZONE_PRECISE_EYES)
			balloon_alert(user, "不能这样做！")
			return

		if(BODY_ZONE_PRECISE_MOUTH)
			balloon_alert(user, "不能这样做！")
			return

		else//targeting an extremity or the head
			if(body_part ==  BODY_ZONE_HEAD)
				render_list += span_info("你小心地把手指按在[carbon_patient]的颈部：\n")
				user.visible_message(span_notice("[user]用手指按住[carbon_patient]的颈部。"), ignored_mobs = user)
			else
				render_list += span_info("你小心地把手指按在[carbon_patient]的[parse_zone(body_part)]：\n")
				user.visible_message(span_notice("[user]用手指按住[carbon_patient]的[parse_zone(body_part)]。"), ignored_mobs = user)

			var/cached_blood_volume = carbon_patient.get_blood_volume(apply_modifiers = TRUE)

			//assess pulse (heart & blood level)
			if(isnull(heart) || !heart.is_beating() || cached_blood_volume <= BLOOD_VOLUME_OKAY || carbon_patient.stat == DEAD)
				render_list += "<span class='danger ml-1'>你摸不到脉搏！</span>\n"//they're dead, their heart isn't beating, or they have critical blood
			else
				if(having_heart_attack)
					heart_strength = span_danger("不规则")
				else if(heart.damage > 10)
					heart_strength = span_danger("微弱")//their heart is damaged
				else
					heart_strength = span_notice("规则")//they're okay :D

				if((cached_blood_volume <= BLOOD_VOLUME_SAFE && cached_blood_volume > BLOOD_VOLUME_OKAY) || having_heart_attack)
					pulse_pressure = span_danger("细弱")//low blood
				else
					pulse_pressure = span_notice("有力")//they're okay :D

				render_list += "<span class='notice ml-1'>对方的脉搏[pulse_pressure]，节律[heart_strength]。</span>\n"

	//display our packaged information in an examine block for easy reading
	to_chat(user, boxed_message(jointext(render_list, "")), type = MESSAGE_TYPE_INFO)

///////////
//SCARVES//
///////////

/obj/item/clothing/neck/scarf
	name = "围巾"
	desc = "一条时髦的围巾。无论是品味敏锐的时尚人士，还是受不了脖子吹冷风的人，都适合用它度过冬天。"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/scarf"
	post_init_icon_state = "scarf"
	w_class = WEIGHT_CLASS_TINY
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#EEEEEE#EEEEEE"
	greyscale_config = /datum/greyscale_config/scarf
	greyscale_config_worn = /datum/greyscale_config/scarf/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/scarf/black
	name = "黑色围巾"
	icon_state = "/obj/item/clothing/neck/scarf/black"
	greyscale_colors = "#4A4A4B#4A4A4B"

/obj/item/clothing/neck/scarf/pink
	name = "粉色围巾"
	icon_state = "/obj/item/clothing/neck/scarf/pink"
	greyscale_colors = "#F699CD#F699CD"

/obj/item/clothing/neck/scarf/red
	name = "红色围巾"
	icon_state = "/obj/item/clothing/neck/scarf/red"
	greyscale_colors = "#D91414#D91414"

/obj/item/clothing/neck/scarf/green
	name = "绿色围巾"
	icon_state = "/obj/item/clothing/neck/scarf/green"
	greyscale_colors = "#5C9E54#5C9E54"

/obj/item/clothing/neck/scarf/darkblue
	name = "深蓝色围巾"
	icon_state = "/obj/item/clothing/neck/scarf/darkblue"
	greyscale_colors = "#1E85BC#1E85BC"

/obj/item/clothing/neck/scarf/purple
	name = "紫色围巾"
	icon_state = "/obj/item/clothing/neck/scarf/purple"
	greyscale_colors = "#9557C5#9557C5"

/obj/item/clothing/neck/scarf/yellow
	name = "黄色围巾"
	icon_state = "/obj/item/clothing/neck/scarf/yellow"
	greyscale_colors = "#E0C14F#E0C14F"

/obj/item/clothing/neck/scarf/orange
	name = "橙色围巾"
	icon_state = "/obj/item/clothing/neck/scarf/orange"
	greyscale_colors = "#C67A4B#C67A4B"

/obj/item/clothing/neck/scarf/cyan
	name = "青色围巾"
	icon_state = "/obj/item/clothing/neck/scarf/cyan"
	greyscale_colors = "#54A3CE#54A3CE"

/obj/item/clothing/neck/scarf/zebra
	name = "斑马纹围巾"
	icon_state = "/obj/item/clothing/neck/scarf/zebra"
	greyscale_colors = "#333333#EEEEEE"

/obj/item/clothing/neck/scarf/christmas
	name = "圣诞围巾"
	icon_state = "/obj/item/clothing/neck/scarf/christmas"
	greyscale_colors = "#038000#960000"

/obj/item/clothing/neck/large_scarf
	name = "大围巾"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/large_scarf"
	post_init_icon_state = "large_scarf"
	w_class = WEIGHT_CLASS_TINY
	custom_price = PAYCHECK_CREW
	greyscale_config = /datum/greyscale_config/scarf
	greyscale_config_worn = /datum/greyscale_config/scarf/worn
	greyscale_colors = "#C6C6C6#EEEEEE"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/large_scarf/red
	name = "红色大围巾"
	icon_state = "/obj/item/clothing/neck/large_scarf/red"
	greyscale_colors = "#8A2908#A06D66"

/obj/item/clothing/neck/large_scarf/green
	name = "绿色大围巾"
	icon_state = "/obj/item/clothing/neck/large_scarf/green"
	greyscale_colors = "#525629#888674"

/obj/item/clothing/neck/large_scarf/blue
	name = "蓝色大围巾"
	icon_state = "/obj/item/clothing/neck/large_scarf/blue"
	greyscale_colors = "#20396C#6F7F91"

/obj/item/clothing/neck/large_scarf/syndie
	name = "可疑的条纹围巾"
	desc = "准备行动。"
	icon_state = "/obj/item/clothing/neck/large_scarf/syndie"
	greyscale_colors = "#B40000#545350"
	armor_type = /datum/armor/large_scarf_syndie

/obj/item/clothing/neck/infinity_scarf
	name = "环形围巾"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/infinity_scarf"
	post_init_icon_state = "infinity_scarf"
	w_class = WEIGHT_CLASS_TINY
	custom_price = PAYCHECK_CREW
	greyscale_colors = COLOR_VERY_LIGHT_GRAY
	greyscale_config = /datum/greyscale_config/infinity_scarf
	greyscale_config_worn = /datum/greyscale_config/infinity_scarf/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/petcollar
	name = "宠物项圈"
	desc = "给宠物用的。"
	icon_state = "petcollar"
	var/tagname = null
	var/human_wearable = FALSE

/datum/armor/large_scarf_syndie
	fire = 50
	acid = 40

/obj/item/clothing/neck/petcollar/mob_can_equip(mob/mob, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	if(!HAS_TRAIT(mob, TRAIT_LESSER_HUMANOID) && !human_wearable)
		return FALSE
	return ..()

/obj/item/clothing/neck/petcollar/wearable
	human_wearable = TRUE

/obj/item/clothing/neck/petcollar/attack_self(mob/user)
	tagname = sanitize_name(tgui_input_text(user, "要更改吊牌上的名字吗？", "宠物取名", "小斑", MAX_NAME_LEN))
	if (!tagname || !length(tagname))
		name = initial(name)
		tagname = null
		return
	name = "[initial(name)] - [tagname]"

/obj/item/clothing/neck/petcollar/wearable/cyber
	desc = "戴领带，或者戴这个。自己选吧。"
	icon_state = "petcollar_cyber"

//////////////
//DOPE BLING//
//////////////

/obj/item/clothing/neck/necklace/dope
	name = "金项链"
	desc = "妈的，当黑帮真爽。"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "bling"

/obj/item/clothing/neck/necklace/dope/merchant
	desc = "别问它怎么运作，全息信用筹码就是证明！"
	/// scales the amount received in case an admin wants to emulate taxes/fees.
	var/profit_scaling = 1
	/// toggles between sell (TRUE) and get price post-fees (FALSE)
	var/selling = FALSE

/obj/item/clothing/neck/necklace/dope/merchant/attack_self(mob/user)
	. = ..()
	selling = !selling
	to_chat(user, span_notice("[src]已设为[selling ? "'出售'" : "'估价'"]模式。"))

/obj/item/clothing/neck/necklace/dope/merchant/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/datum/export_report/ex = export_item_and_contents(interacting_with, delete_unsold = selling, dry_run = !selling)
	var/price = 0
	for(var/x in ex.total_amount)
		price += ex.total_value[x]

	if(price)
		var/true_price = round(price*profit_scaling)
		var/fee_display = round(price-true_price)
		to_chat(user, span_notice("[selling ? "已出售" : "正在估价"][interacting_with]，价值：<b>[true_price]</b> [MONEY_NAME][interacting_with.contents.len ? "（包含可出口的内装物品）" : ""]。[profit_scaling < 1 && selling ? "已扣除<b>[fee_display]</b> [MONEY_NAME_AUTOPURAL(fee_display)]作为手续费。" : ""]"))
		if(selling)
			new /obj/item/holochip(get_turf(user), true_price)
	else
		to_chat(user, span_warning("[interacting_with]及其内装物品均无出口价值。"))

	return ITEM_INTERACT_BLOCKING

/obj/item/clothing/neck/beads
	name = "塑料珠项链"
	desc = "一条廉价的塑料珠项链。展现团队精神！收集它们！扔掉它们！可能性无穷无尽！"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "beads"
	color = "#ffffff"
	custom_price = PAYCHECK_CREW * 0.2
	custom_materials = (list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT*5))

/obj/item/clothing/neck/beads/Initialize(mapload)
	. = ..()
	color = color = pick("#ff0077","#d400ff","#2600ff","#00ccff","#00ff2a","#e5ff00","#ffae00","#ff0000", "#ffffff")

/obj/item/clothing/neck/wreath
	name = "\improper 凝视者冠环"
	desc = "以凝视者扭曲的血肉和肌腱制成的精致冠环。戴上后，你感觉后脑勺也长了眼睛。"
	icon_state = "watcher_wreath"
	worn_y_offset = 10
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/clothing/neck/wreath/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "wreath_emissive", src, alpha = src.alpha)

/obj/item/clothing/neck/wreath/icewing
	name = "\improper 冰翼冠环"
	desc = "以冰翼凝视者扭曲的血肉和肌腱制成的精致冠环。仅仅靠近它，就让你脊背发凉。"
	icon_state = "icewing_wreath"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/clothing/neck/wreath/magmawing
	name = "\improper 熔翼冠环"
	desc = "以熔翼凝视者扭曲的血肉和肌腱制成的精致冠环。戴上后，你的心脏和皮肤仿佛都燃烧起来。"
	icon_state = "magmawing_wreath"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2)
