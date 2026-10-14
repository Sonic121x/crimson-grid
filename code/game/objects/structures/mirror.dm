
// Normal Mirrors

#define CHANGE_HAIR "Change Hair"
#define CHANGE_BEARD "Change Beard"

// Magic Mirrors!

#define CHANGE_RACE "Change Race"
#define CHANGE_SEX  "Change Sex"
#define CHANGE_NAME "Change Name"
#define CHANGE_EYES "Change Eyes"

#define INERT_MIRROR_OPTIONS list(CHANGE_HAIR, CHANGE_BEARD)
#define PRIDE_MIRROR_OPTIONS list(CHANGE_HAIR, CHANGE_BEARD, CHANGE_RACE, CHANGE_SEX, CHANGE_EYES)
#define MAGIC_MIRROR_OPTIONS list(CHANGE_HAIR, CHANGE_BEARD, CHANGE_RACE, CHANGE_SEX, CHANGE_EYES, CHANGE_NAME)

// Chance for the mirror to be haunted at creation
#define ROUNDSTART_CURSED_CHANCE 0.2

/obj/structure/mirror
	name = "镜子"
	desc = "魔镜魔镜告诉我，谁才是最能打的那一个？"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "mirror"
	movement_type = FLOATING
	density = FALSE
	anchored = TRUE
	integrity_failure = 0.5
	max_integrity = 200
	custom_materials = /obj/item/wallframe/mirror::custom_materials
	///Can this mirror be removed from walls with tools?
	var/deconstructable = TRUE
	var/list/mirror_options = INERT_MIRROR_OPTIONS
	// Can a revenant be imprisoned in this mirror?
	var/cursable = TRUE
	///Flags this race must have to be selectable with this type of mirror.
	var/race_flags = MIRROR_MAGIC
	///List of all Races that can be chosen, decided by its Initialize.
	var/list/selectable_races

/obj/structure/mirror/proc/update_choices()
	for(var/i in mirror_options)
		mirror_options[i] = localized_radial_choice(icon('icons/hud/radial.dmi', i), list(CHANGE_HAIR = "改变头发", CHANGE_BEARD = "改变胡须", CHANGE_RACE = "改变物种", CHANGE_SEX = "改变性别", CHANGE_NAME = "改变姓名", CHANGE_EYES = "改变眼睛")[i])

	if(CHANGE_RACE in mirror_options)
		selectable_races = list()
		for(var/datum/species/species_type as anything in get_species_pool())
			if(!race_flags || (species_type::changesource_flags & race_flags))
				selectable_races[species_type::name] = species_type
		selectable_races = sort_list(selectable_races)

	else
		selectable_races = null

/obj/structure/mirror/Initialize(mapload)
	. = ..()
	var/static/list/reflection_filter = alpha_mask_filter(icon = icon('icons/obj/watercloset.dmi', "mirror_mask"))
	var/static/matrix/reflection_matrix = matrix(0.75, 0, 0, 0, 0.75, 0)
	AddComponent(/datum/component/reflection, \
		reflection_filter = reflection_filter, \
		reflection_matrix = reflection_matrix, \
		can_reflect = CALLBACK(src, PROC_REF(can_reflect)), \
		update_signals = list(COMSIG_ATOM_BREAK), \
		check_reflect_signals = list(SIGNAL_ADDTRAIT(TRAIT_NO_MIRROR_REFLECTION), SIGNAL_REMOVETRAIT(TRAIT_NO_MIRROR_REFLECTION)), \
	)
	if(cursable)
		if(mapload && prob(ROUNDSTART_CURSED_CHANCE))
			AddComponent(/datum/component/revenant_prison, create_on_release = TRUE)
		else
			ADD_TRAIT(src, TRAIT_COZY_REVENANT_HOME, INNATE_TRAIT)
	if(mapload)
		find_and_mount_on_atom()
	update_choices()
	register_context()

/obj/structure/mirror/proc/can_reflect(atom/movable/target)
	// I'm doing it this way too, because the signal is sent before the broken variable is set to TRUE.
	if(atom_integrity <= integrity_failure * max_integrity || broken)
		return FALSE
	if(!isliving(target) || HAS_TRAIT(target, TRAIT_NO_MIRROR_REFLECTION))
		return FALSE
	return TRUE

/// Returns a list species typepaths to use for the mirror. This pool is then filtered by flags.
/obj/structure/mirror/proc/get_species_pool()
	return subtypesof(/datum/species)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/mirror, 28)

/obj/structure/mirror/broken
	icon_state = "mirror_broke"
	cursable = FALSE
	broken = TRUE
	desc = "糟了，要倒霉七年！"

/obj/structure/mirror/broken/Initialize(mapload)
	. = ..()

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/mirror/broken, 28)

/obj/structure/mirror/attack_hand(mob/living/carbon/human/user)
	. = ..()
	if(. || !ishuman(user) || broken)
		return TRUE

	display_radial_menu(user)
	return TRUE

/obj/structure/mirror/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(!deconstructable)
		balloon_alert(user, "魔法阻止了拆卸！")
		return NONE
	user.visible_message(span_notice("[user]开始拆卸[src]……"), span_notice("你开始拆卸[src]……"))
	tool.play_tool_sound(src)
	if(tool.use_tool(src, user, 3 SECONDS))
		user.visible_message(span_notice("[user]拆下了[src]！"), span_notice("你把[src]从墙上拆了下来。"))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct()
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/structure/mirror/proc/display_radial_menu(mob/living/carbon/human/user)
	if(!can_use_mirror(user))
		return

	var/pick = show_radial_menu(user, src, mirror_options, user, radius = 36, require_near = TRUE, tooltips = TRUE)
	if(!pick || !can_use_mirror(user) || !pre_change(user, pick))
		return

	switch(pick)
		if(CHANGE_HAIR)
			change_hair(user)
		if(CHANGE_BEARD)
			change_beard(user)
		if(CHANGE_RACE)
			change_race(user)
		if(CHANGE_SEX) // sex: yes
			change_sex(user)
		if(CHANGE_NAME)
			change_name(user)
		if(CHANGE_EYES)
			change_eyes(user)

	display_radial_menu(user)

/// Ran before we dive into any changes, can be used to block changes by returning FALSE
/obj/structure/mirror/proc/pre_change(mob/living/carbon/human/user, picked)
	return TRUE

/// Checks if the mob can continue to use the mirror
/obj/structure/mirror/proc/can_use_mirror(mob/living/carbon/human/user)
	return !QDELETED(src) && !QDELETED(user) && !broken && user.can_perform_action(src, FORBID_TELEKINESIS_REACH)

/obj/structure/mirror/proc/change_beard(mob/living/carbon/human/beard_dresser)
	if(beard_dresser.physique == FEMALE)
		if(beard_dresser.facial_hairstyle == "Shaved")
			balloon_alert(beard_dresser, "没有可剃的胡须！")
			return
		var/shave_beard = tgui_alert(beard_dresser, "要剃掉胡须吗？", "仪容修整", list("是", "否"))
		if(shave_beard == "是" && can_use_mirror(beard_dresser))
			beard_dresser.set_facial_hairstyle("Shaved", update = TRUE)
		return

	var/new_style = localized_accessory_input(beard_dresser, "选择胡须样式", "仪容修整", SSaccessories.facial_hairstyles_list)

	if(isnull(new_style) || !can_use_mirror(beard_dresser))
		return

	if(HAS_TRAIT(beard_dresser, TRAIT_SHAVED))
		to_chat(beard_dresser, span_notice("要是你的胡须能这么轻易长回来就好了……想到这件事就让你难受。"))
		beard_dresser.add_mood_event("bald_hair_day", /datum/mood_event/bald_reminder)
		return

	beard_dresser.set_facial_hairstyle(new_style, update = TRUE)

/obj/structure/mirror/proc/change_hair(mob/living/carbon/human/hairdresser)
	var/new_style = localized_accessory_input(hairdresser, "选择发型", "仪容修整", SSaccessories.hairstyles_list)
	if(isnull(new_style) || !can_use_mirror(hairdresser))
		return
	if(HAS_TRAIT(hairdresser, TRAIT_BALD))
		to_chat(hairdresser, span_notice("要是你的头发能这么轻易长回来就好了……想到这件事就让你难受。"))
		hairdresser.add_mood_event("bald_hair_day", /datum/mood_event/bald_reminder)
		return

	hairdresser.set_hairstyle(new_style, update = TRUE)

/obj/structure/mirror/proc/change_name(mob/living/carbon/human/user)
	var/newname = sanitize_name(tgui_input_text(user, "你叫什么名字来着？", "更改姓名", user.name, MAX_NAME_LEN), allow_numbers = TRUE) //It's magic so whatever.
	if(!newname || !can_use_mirror(user))
		return
	user.real_name = newname
	user.name = newname
	if(user.dna)
		user.dna.real_name = newname
	if(user.mind)
		user.mind.name = newname

// Erm ackshually the proper term is species. Get it right??
/obj/structure/mirror/proc/change_race(mob/living/carbon/human/race_changer)
	var/racechoice = tgui_input_list(race_changer, "你属于哪个物种来着？", "更改物种", selectable_races)
	if(isnull(racechoice) || !can_use_mirror(race_changer))
		return

	var/new_race_path = selectable_races[racechoice]
	if(!ispath(new_race_path, /datum/species))
		return

	var/datum/species/newrace = GLOB.species_prototypes[new_race_path]
	var/attributes_desc = newrace.get_physical_attributes()

	var/answer = tgui_alert(race_changer, attributes_desc, "变成[newrace]？", list("是", "否"))
	if(!answer || !can_use_mirror(race_changer))
		return
	if(answer != "是")
		change_race(race_changer) // try again
		return

	on_species_change(race_changer, newrace)
	race_changer.set_species(new_race_path, icon_update = FALSE)
	if(HAS_TRAIT(race_changer, TRAIT_USES_SKINTONES))
		var/new_s_tone = tgui_input_list(race_changer, "选择肤色", "更改物种", assoc_to_values(GLOB.skin_tone_names))
		if(new_s_tone && can_use_mirror(race_changer))
			race_changer.skin_tone = GLOB.skin_tone_names[assoc_to_values(GLOB.skin_tone_names).Find(new_s_tone)]
			race_changer.dna.update_ui_block(/datum/dna_block/identity/skin_tone)
	else if(HAS_TRAIT(race_changer, TRAIT_MUTANT_COLORS) && !HAS_TRAIT(race_changer, TRAIT_FIXED_MUTANT_COLORS))
		var/new_mutantcolor = tgui_color_picker(race_changer, "选择皮肤颜色：", "更改物种", race_changer.dna.features[FEATURE_MUTANT_COLOR])
		if(new_mutantcolor && can_use_mirror(race_changer))
			var/list/mutant_hsv = rgb2hsv(new_mutantcolor)
			if(mutant_hsv[3] >= 50) // mutantcolors must be bright
				race_changer.dna.features[FEATURE_MUTANT_COLOR] = sanitize_hexcolor(new_mutantcolor)
				race_changer.dna.update_uf_block(/datum/dna_block/feature/mutant_color)
			else
				to_chat(race_changer, span_notice("颜色无效。你选择的颜色不够明亮。"))

	race_changer.update_body(is_creating = TRUE)

/// Hook for mirrors to do stuff on species change
/obj/structure/mirror/proc/on_species_change(mob/living/carbon/human/race_changer, datum/species/newrace)
	return

// possible Genders: MALE, FEMALE, PLURAL, NEUTER
// possible Physique: MALE, FEMALE
// saved you a click (many)
/obj/structure/mirror/proc/change_sex(mob/living/carbon/human/sexy)

	var/chosen_sex = tgui_input_list(sexy, "变成……", "确认", list("男巫", "女巫", "巫师（中性人称）", "巫师（无性人称）")) // YOU try coming up with the 'it' version of wizard
	if(!chosen_sex || !can_use_mirror(sexy))
		return

	switch(chosen_sex)
		if("男巫")
			sexy.gender = MALE
			to_chat(sexy, span_notice("嘿，你感觉自己是个男人了！"))
		if("女巫")
			sexy.gender = FEMALE
			to_chat(sexy, span_notice("嘿，你感觉自己是个女人了！"))
		if("巫师（中性人称）")
			sexy.gender = PLURAL
			to_chat(sexy, span_notice("哇，伙计，你感觉自己就是个自在的家伙！"))
		if("巫师（无性人称）")
			sexy.gender = NEUTER
			to_chat(sexy, span_notice("哇，伙计，你感觉自己成了某种别样的存在！"))

	var/chosen_physique = tgui_input_list(sexy, "也要改变体型吗？", "确认", list("男巫体型", "女巫体型", "巫师不需要性别"))

	if(chosen_physique && chosen_physique != "巫师不需要性别" && can_use_mirror(sexy))
		sexy.physique = (chosen_physique == "男巫体型") ? MALE : FEMALE

	sexy.dna.update_ui_block(/datum/dna_block/identity/gender)
	sexy.update_body(is_creating = TRUE) // or else physique won't change properly
	sexy.update_clothing(ITEM_SLOT_ICLOTHING) // update gender shaped clothing

/obj/structure/mirror/proc/change_eyes(mob/living/carbon/human/user)
	var/new_eye_color = tgui_color_picker(user, "选择眼睛颜色", "眼睛颜色", user.eye_color_left)
	if(isnull(new_eye_color) || !can_use_mirror(user))
		return
	user.set_eye_color(sanitize_hexcolor(new_eye_color))
	user.dna.update_ui_block(/datum/dna_block/identity/eye_colors)
	user.update_eyes()
	to_chat(user, span_notice("你用焕然一新的眼睛欣赏着自己焕然一新的眼睛。完美！"))

/obj/structure/mirror/examine(mob/user)
	. = ..()
	if(deconstructable)
		. += span_notice("它用几颗<b>螺栓</b>固定在墙上。")

/obj/structure/mirror/examine_status(mob/living/carbon/human/user)
	if(broken)
		return list()// no message spam
	return ..()

/obj/structure/mirror/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "打开外貌调整轮盘"
		return CONTEXTUAL_SCREENTIP_SET
	if(held_item.tool_behaviour == TOOL_WRENCH && deconstructable)
		context[SCREENTIP_CONTEXT_RMB] = "拆卸"
		return CONTEXTUAL_SCREENTIP_SET
	return .

/obj/structure/mirror/attacked_by(obj/item/I, mob/living/user, list/modifiers, list/attack_modifiers)
	if(broken)
		return ..()
	. = ..()
	if(!broken || . <= 0) // breaking a mirror truly gets you bad luck!
		return
	to_chat(user, span_warning("[src]碎裂时，你感到脊背一阵发凉……"))
	user.AddComponent(/datum/component/omen, incidents_left = 7)

/obj/structure/mirror/bullet_act(obj/projectile/proj)
	if(broken || !isliving(proj.firer) || !proj.damage)
		return ..()

	. = ..()
	if(broken) // breaking a mirror truly gets you bad luck!
		var/mob/living/unlucky_dude = proj.firer
		to_chat(unlucky_dude, span_warning("[src]碎裂时，你感到脊背一阵发凉……"))
		unlucky_dude.AddComponent(/datum/component/omen, incidents_left = 7)

/obj/structure/mirror/atom_break(damage_flag)
	. = ..()
	if(broken)
		return
	icon_state = "mirror_broke"
	playsound(src, SFX_SHATTER, 70, TRUE)
	if(desc == initial(desc))
		desc = "糟了，要倒霉七年！"
	broken = TRUE

/obj/structure/mirror/atom_deconstruct(disassembled = TRUE)
	if(!disassembled)
		new /obj/item/shard(loc)
	else if(broken)
		new /obj/item/wallframe/mirror/broken(loc)
	else
		new /obj/item/wallframe/mirror(loc)

/obj/structure/mirror/welder_act(mob/living/user, obj/item/I)
	..()
	if(user.combat_mode)
		return FALSE

	if(!broken)
		return TRUE

	if(!I.tool_start_check(user, amount=1))
		return TRUE

	balloon_alert(user, "正在修理……")
	if(I.use_tool(src, user, 10, volume = 50))
		balloon_alert(user, "修理完毕")
		broken = FALSE
		icon_state = initial(icon_state)
		desc = initial(desc)

	return TRUE

/obj/structure/mirror/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(src, 'sound/effects/hit_on_shattered_glass.ogg', 70, TRUE)
		if(BURN)
			playsound(src, 'sound/effects/hit_on_shattered_glass.ogg', 70, TRUE)

/obj/item/wallframe/mirror
	name = "镜子"
	desc = "一面尚未安装的镜子，固定到墙上后即可使用。"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "mirror"
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	result_path = /obj/structure/mirror
	pixel_shift = 28

/obj/item/wallframe/mirror/heretic
	name = /obj/structure/mirror/magic/lesser/heretic::name
	desc = /obj/structure/mirror/magic/lesser/heretic::desc
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "magic_mirror"
	result_path = /obj/structure/mirror/magic/lesser/heretic

/obj/item/wallframe/mirror/broken
	name = "破镜子"
	desc = "一面尚未安装的破镜子，可以固定在墙上作装饰。"
	icon_state = "mirror_broke"
	result_path = /obj/structure/mirror/broken

/obj/structure/mirror/magic
	name = "魔镜"
	desc = "转过身，面对那张陌生的……脸。"
	icon_state = "magic_mirror"
	mirror_options = MAGIC_MIRROR_OPTIONS
	deconstructable = FALSE
	cursable = FALSE

/obj/structure/mirror/magic/change_beard(mob/living/carbon/human/beard_dresser) // magical mirrors do nothing but give you the damn beard
	var/new_style = localized_accessory_input(beard_dresser, "选择胡须样式", "仪容修整", SSaccessories.facial_hairstyles_list)
	if(isnull(new_style) || !can_use_mirror(beard_dresser))
		return

	beard_dresser.set_facial_hairstyle(new_style, update = TRUE)

//Magic mirrors can change hair color as well
/obj/structure/mirror/magic/change_hair(mob/living/carbon/human/user)
	var/hairchoice = tgui_alert(user, "改变发型还是发色？", "改变头发", list("发型", "发色"))
	if(!can_use_mirror(user))
		return
	if(hairchoice == "发型") //So you just want to use a mirror then?
		return ..()

	var/new_hair_color = tgui_color_picker(user, "选择头发颜色", "头发颜色", user.hair_color)
	if(!new_hair_color || !can_use_mirror(user))
		return
	if(new_hair_color)
		user.set_haircolor(sanitize_hexcolor(new_hair_color))
		user.dna.update_ui_block(/datum/dna_block/identity/hair_color)
	if(user.physique == MALE)
		var/new_face_color = tgui_color_picker(user, "选择胡须颜色", "胡须颜色", user.facial_hair_color)
		if(new_face_color && can_use_mirror(user))
			user.set_facial_haircolor(sanitize_hexcolor(new_face_color))
			user.dna.update_ui_block(/datum/dna_block/identity/facial_color)

/// Hook for mirrors to do stuff on species change
/obj/structure/mirror/magic/on_species_change(mob/living/carbon/human/race_changer, datum/species/newrace)
	if(HAS_TRAIT(race_changer, TRAIT_ADVANCEDTOOLUSER) && HAS_TRAIT(race_changer, TRAIT_LITERATE))
		return

	to_chat(race_changer, span_alert("你觉得自己相当聪明。"))
	// Prevents wizards from being soft locked out of everything
	// If this stays after the species was changed once more, well, the magic mirror did it. It's magic i aint gotta explain shit
	race_changer.add_traits(list(TRAIT_LITERATE, TRAIT_ADVANCEDTOOLUSER), SPECIES_TRAIT)

/obj/structure/mirror/magic/lesser
	race_flags = NONE

/obj/structure/mirror/magic/lesser/get_species_pool()
	var/list/race_list = list()
	for(var/species_id in get_selectable_species())
		race_list += GLOB.species_list[species_id]
	return race_list

/obj/structure/mirror/magic/lesser/heretic
	name = "奇迹之镜"
	desc = "凝视着镜中的自己，你觉得自己还可以更好。"
	mirror_options = PRIDE_MIRROR_OPTIONS

/obj/structure/mirror/magic/lesser/heretic/on_species_change(mob/living/carbon/human/race_changer, datum/species/newrace)
	. = ..()
	if(race_changer.dna?.species?.type == newrace.type)
		return
	atom_break(null)

/obj/structure/mirror/magic/lesser/heretic/atom_deconstruct(disassembled)
	new /obj/item/shard(loc) // never gives the frame back

/obj/structure/mirror/magic/lesser/heretic/welder_act(mob/living/user, obj/item/I)
	to_chat(user, span_alert("你几乎完全找不到修理[src]的下手之处。"))
	return ITEM_INTERACT_BLOCKING

/obj/structure/mirror/magic/lesser/heretic/pre_change(mob/living/carbon/human/user, picked)
	if(IS_HERETIC(user))
		return TRUE

	to_chat(user, span_hypnophrase("你发现自己凝视着[src]，无法移开目光……"))
	user.Immobilize(5 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(change_something), user, picked), 5 SECONDS)
	return FALSE

/obj/structure/mirror/magic/lesser/heretic/proc/change_something(mob/living/carbon/human/user, picked)
	if(QDELETED(src) || QDELETED(user))
		return

	if(!user.Adjacent(src))
		to_chat(user, span_warning("离开[src]后，你从恍惚中清醒过来。"))
		return
	if(broken)
		to_chat(user, span_warning("随着[src]碎裂，你从恍惚中清醒过来。"))
		return

	// randomizes your stuff, doesn't affect DNA though so you could easily get genetics to fix you
	switch(picked)
		if(CHANGE_HAIR, CHANGE_BEARD)
			to_chat(user, span_hypnophrase("头发——对，头发不对劲——[pick("它还可以更好", "它需要改变", "它必须变个样")]……"))
			user.set_hairstyle(random_hairstyle(user.gender))
			user.set_facial_hairstyle(random_facial_hairstyle(user.gender))
		if(CHANGE_RACE)
			to_chat(user, span_hypnophrase("身体——不，这身体完全不对——[pick("我必须脱胎换骨", "我需要变得不一样", "我想变成别的存在")]……"))
			var/list/options = assoc_to_values(selectable_races) - user.dna.species.type
			var/datum/species/newrace = GLOB.species_prototypes[pick(options)]
			on_species_change(user, newrace)
			user.set_species(newrace.type, icon_update = FALSE)
		if(CHANGE_SEX)
			to_chat(user, span_hypnophrase("我的形体——对，这形体完全不对——我需要改变它……")) // the wording used here needs to be very deliberate...
			var/list/options = list(MALE, FEMALE, PLURAL, NEUTER) - user.gender
			user.gender = pick(options)
			user.physique = user.gender
		if(CHANGE_EYES)
			to_chat(user, span_hypnophrase("我的眼睛——我看不清——[pick("它们就是不对劲", "必须换掉它们", "两只都不对")]……"))
			user.set_eye_color(random_eye_color())
		if(CHANGE_NAME) // not enabled by default but for badmin support
			to_chat(user, span_hypnophrase("我的名字——它不适合我——[pick("换一个会更好", "必须改掉它", "该取个更合适的名字")]……"))
			user.real_name = user.generate_random_mob_name()
			user.update_visible_name()

/obj/structure/mirror/magic/badmin
	race_flags = MIRROR_BADMIN

/obj/structure/mirror/magic/pride
	name = "傲慢之镜"
	desc = "骄傲在败坏以先，狂心在……"
	race_flags = MIRROR_PRIDE
	mirror_options = PRIDE_MIRROR_OPTIONS
	/// If the last user has altered anything about themselves
	var/changed = FALSE

/obj/structure/mirror/magic/pride/pre_change(mob/living/carbon/human/user, picked)
	. = ..()
	changed = TRUE

/obj/structure/mirror/magic/pride/attack_hand(mob/living/carbon/human/user)
	changed = FALSE
	. = ..()
	if (!changed || QDELETED(user) || !IN_GIVEN_RANGE(user, src, 3)) // 3 range gives a tiny bit of leeway if you try to run away after using it
		return
	user.visible_message(
		span_bolddanger("[user]的手刚离开镜面，脚下的地面就裂开了！"),
		span_notice("完美。好多了！现在<i>谁</i>都无法抗拒你的魅——"),
	)

	var/turf/user_turf = get_turf(user)
	var/turf/open/chasm/pride/new_chasm = user_turf.ChangeTurf(/turf/open/chasm/pride, flags = CHANGETURF_INHERIT_AIR)
	// `ChangeTurf()` can itself lead to `drop()` if there's lattice present, so
	// we only force the user down if they're still on the same turf.
	if(get_turf(user) == user_turf)
		new_chasm.drop(user)

#undef CHANGE_HAIR
#undef CHANGE_BEARD

#undef CHANGE_RACE
#undef CHANGE_SEX
#undef CHANGE_NAME
#undef CHANGE_EYES

#undef INERT_MIRROR_OPTIONS
#undef PRIDE_MIRROR_OPTIONS
#undef MAGIC_MIRROR_OPTIONS

#undef ROUNDSTART_CURSED_CHANCE
