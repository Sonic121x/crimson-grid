/// Map of names of clown mask types to clown mask icon states
GLOBAL_LIST_INIT(clown_mask_options, list(
	"True Form" = "clown",
	"The Coquette" = "sexyclown",
	"The Madman" = "joker",
	"The Rainbow Color" = "rainbow",
	"The Dealer" = "cards"
))
GLOBAL_LIST_INIT(localized_mask_style_names, list("True Form" = "真实形态", "The Coquette" = "娇媚者", "The Madman" = "疯子", "The Rainbow Color" = "彩虹色", "The Dealer" = "发牌者", "Blanc" = "空白", "Excité" = "兴奋", "Triste" = "悲伤", "Effrayé" = "惊恐", "Original Tiki" = "原始提基", "Happy Tiki" = "快乐提基", "Confused Tiki" = "困惑提基", "Angry Tiki" = "愤怒提基"))
/obj/item/clothing/mask/gas
	name = "防毒面具"
	desc = "一副可连接供气设备的覆面面具。适合隐藏身份，并设有滤芯插槽以帮助滤除毒物。" //More accurate
	icon_state = "gas_alt"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_NORMAL
	inhand_icon_state = "gas_alt"
	armor_type = /datum/armor/mask_gas
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH | PEPPERPROOF
	resistance_flags = NONE
	voice_filter = "lowpass=f=750,volume=2"
	sound_vary = TRUE
	pickup_sound = SFX_GAS_MASK_PICKUP
	drop_sound = SFX_GAS_MASK_DROP
	equip_sound = SFX_GAS_MASK_EQUIP
	///Max numbers of installable filters
	var/max_filters = 1
	///List to keep track of each filter
	var/list/gas_filters
	///Type of filter that spawns on roundstart
	var/starting_filter_type = /obj/item/gas_filter
	///Cigarette in the mask
	var/obj/item/cigarette/cig
	///How much does this mask affect fishing difficulty
	var/fishing_modifier = 2
	///Applies clothing_dirt component to the pepperproof mask if true
	var/pepper_tint = TRUE
	///icon_state used by clothing_dirt
	var/dirt_state = "gas_dirt"

/datum/armor/mask_gas
	bio = 100

/obj/item/clothing/mask/gas/Initialize(mapload)
	. = ..()

	if((flags_cover & PEPPERPROOF) && pepper_tint)
		AddComponent(/datum/component/clothing_dirt, dirt_state)

	if(fishing_modifier)
		AddElement(/datum/element/adjust_fishing_difficulty, fishing_modifier)

	if(!max_filters || !starting_filter_type)
		return

	for(var/i in 1 to max_filters)
		var/obj/item/gas_filter/inserted_filter = new starting_filter_type(src)
		LAZYADD(gas_filters, inserted_filter)
	has_filter = TRUE

/obj/item/clothing/mask/gas/separate_worn_overlays(mutable_appearance/standing, mutable_appearance/draw_target, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands && cig)
		. += cig.build_worn_icon(default_layer = FACEMASK_LAYER, default_icon_file = 'icons/mob/clothing/mask.dmi', bodyshape = bodyshape)

/obj/item/clothing/mask/gas/Destroy()
	QDEL_LAZYLIST(gas_filters)
	return..()

/obj/item/clothing/mask/gas/equipped(mob/equipee, slot)
	cig?.equipped(equipee, slot)
	return ..()

/obj/item/clothing/mask/gas/adjust_visor(mob/living/user)
	if(!isnull(cig))
		balloon_alert(user, "香烟挡住了！")
		return FALSE
	return ..()

/obj/item/clothing/mask/gas/examine(mob/user)
	. = ..()
	if(cig)
		. += span_notice("滤芯插槽里塞着[cig.name]。")
	if(max_filters > 0 && !cig)
		. += span_notice("[src]有[max_filters]个滤芯插槽。")
	if(LAZYLEN(gas_filters) > 0)
		. += span_notice("目前装有[LAZYLEN(gas_filters)]个滤芯，耐久度为[get_filter_durability()]%。")
		. += span_notice("空手右键点击[src]可取出滤芯。")

/obj/item/clothing/mask/gas/Exited(atom/movable/gone)
	. = ..()
	if(gone == cig)
		cig = null
		if(ismob(loc))
			var/mob/wearer = loc
			wearer.update_worn_mask()

/obj/item/clothing/mask/gas/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/valid_wearer = ismob(loc)
	var/mob/wearer = loc
	if(istype(tool, /obj/item/cigarette))
		if(max_filters <= 0 || cig)
			balloon_alert(user, "装不下！")
			return ..()

		if(has_filter)
			balloon_alert(user, "面具里已有滤芯！")
			return ..()

		cig = tool
		if(valid_wearer)
			cig.equipped(loc, wearer.get_slot_by_item(cig))

		cig.forceMove(src)
		if(valid_wearer)
			wearer.update_worn_mask()
		return ITEM_INTERACT_SUCCESS

	if(cig)
		var/cig_interaction = cig.item_interaction(user, tool)
		if(valid_wearer)
			wearer.update_worn_mask()
		return cig_interaction

	if(!istype(tool, /obj/item/gas_filter))
		return ..()

	if(LAZYLEN(gas_filters) >= max_filters)
		return ..()

	if(!user.transferItemToLoc(tool, src))
		return ..()

	LAZYADD(gas_filters, tool)
	has_filter = TRUE
	return ITEM_INTERACT_SUCCESS

/obj/item/clothing/mask/gas/attack_hand_secondary(mob/user, list/modifiers)
	if(cig)
		user.put_in_hands(cig)
		cig = null
		if(ismob(loc))
			var/mob/wearer = loc
			wearer.update_worn_mask()
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!has_filter || !max_filters)
		return SECONDARY_ATTACK_CONTINUE_CHAIN
	for(var/i in 1 to max_filters)
		var/obj/item/gas_filter/filter = locate() in src
		if(!filter)
			continue
		user.put_in_hands(filter)
		LAZYREMOVE(gas_filters, filter)
	if(LAZYLEN(gas_filters) <= 0)
		has_filter = FALSE
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

///Check _masks.dm for this one
/obj/item/clothing/mask/gas/consume_filter(datum/gas_mixture/breath)
	if(LAZYLEN(gas_filters) <= 0 || max_filters == 0)
		return breath
	var/obj/item/gas_filter/gas_filter = pick(gas_filters)
	var/datum/gas_mixture/filtered_breath = gas_filter.reduce_filter_status(breath)
	if(gas_filter.filter_status <= 0)
		LAZYREMOVE(gas_filters, gas_filter)
		qdel(gas_filter)
	if(LAZYLEN(gas_filters) <= 0)
		has_filter = FALSE
	return filtered_breath

/**
 * Getter for overall filter durability, takes into consideration all filters filter_status
 */
/obj/item/clothing/mask/gas/proc/get_filter_durability()
	var/max_filters_durability = LAZYLEN(gas_filters) * 100
	var/current_filters_durability
	for(var/obj/item/gas_filter/gas_filter as anything in gas_filters)
		current_filters_durability += gas_filter.filter_status
	var/durability = (current_filters_durability / max_filters_durability) * 100
	return durability

/obj/item/clothing/mask/gas/atmos
	name = "大气技术员防毒面具"
	desc = "大气技术员使用的改良防毒面具。它能防火！"
	icon_state = "gas_atmos"
	inhand_icon_state = "gas_atmos"
	armor_type = /datum/armor/gas_atmos
	resistance_flags = FIRE_PROOF
	max_filters = 3

/datum/armor/gas_atmos
	bio = 100
	fire = 20
	acid = 10

/obj/item/clothing/mask/gas/atmos/plasmaman
	starting_filter_type = /obj/item/gas_filter/plasmaman

/obj/item/clothing/mask/gas/atmos/captain
	name = "站长防毒面具"
	desc = "纳诺传讯为了省钱，把一副备用的大气技术员防毒面具重新刷了漆。可别告诉别人。"
	icon_state = "gas_cap"
	inhand_icon_state = "gasmask_captain"
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/mask/gas/atmos/centcom
	name = "\improper 中央指挥部防毒面具"
	desc = "哦，金绿配色，真气派！你坐办公室时应该能用得上。"
	icon = 'icons/obj/clothing/masks.dmi'
	worn_icon = 'icons/mob/clothing/mask.dmi'
	worn_icon_state = "gas_centcom"
	icon_state = "gas_centcom"
	inhand_icon_state = "gas_centcom"
	resistance_flags = FIRE_PROOF | ACID_PROOF

// **** Welding gas mask ****

/obj/item/clothing/mask/gas/welding
	name = "焊接面具"
	desc = "内置焊接护目镜和面罩的防毒面具。外形像个骷髅，显然出自某个宅男之手。"
	icon_state = "weldingmask"
	flash_protect = FLASH_PROTECTION_WELDER
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.4, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	tint = 2
	toggle_message = "你放下了面罩。"
	alt_toggle_message = "你抬起了面罩。"
	armor_type = /datum/armor/gas_welding
	actions_types = list(/datum/action/item_action/toggle)
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDESNOUT
	flags_cover = MASKCOVERSEYES|MASKCOVERSMOUTH|PEPPERPROOF
	visor_flags_inv = HIDEEYES
	visor_flags_cover = MASKCOVERSEYES|MASKCOVERSMOUTH|PEPPERPROOF
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	resistance_flags = FIRE_PROOF
	clothing_flags = parent_type::clothing_flags | INTERNALS_ADJUST_EXEMPT
	fishing_modifier = 8
	dirt_state = "welding_dirt"

/datum/armor/gas_welding
	melee = 10
	bio = 100
	fire = 100
	acid = 55

/obj/item/clothing/mask/gas/welding/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/gas/welding/adjust_visor(mob/living/user)
	. = ..()
	if(.)
		playsound(src, up ? SFX_VISOR_UP : SFX_VISOR_DOWN, 50, TRUE)
	if(!fishing_modifier)
		return
	if(up)
		RemoveElement(/datum/element/adjust_fishing_difficulty)
	else
		AddElement(/datum/element/adjust_fishing_difficulty, fishing_modifier)

/obj/item/clothing/mask/gas/welding/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][up ? "up" : ""]"

/obj/item/clothing/mask/gas/welding/up/Initialize(mapload)
	. = ..()
	visor_toggling()

// ********************************************************************

//Plague Dr suit can be found in clothing/suits/bio.dm
/obj/item/clothing/mask/gas/plaguedoctor
	name = "瘟疫医生面具"
	desc = "经典设计的现代化版本，不仅能保护你免受瘟疫侵袭，还能连接供气设备。"
	icon_state = "plaguedoctor"
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	inhand_icon_state = "gas_mask"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT|MASKINTERNALS
	dirt_state = "plague_dirt"

/obj/item/clothing/mask/gas/syndicate
	name = "辛迪加面具"
	desc = "一副贴合面部的战术面具，可连接供气设备。"
	icon_state = "syndicate"
	inhand_icon_state = "syndicate_gasmask"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	strip_delay = 6 SECONDS
	w_class = WEIGHT_CLASS_SMALL
	fishing_modifier = 0
	pepper_tint = FALSE

/obj/item/clothing/mask/gas/syndicate/plasmaman
	starting_filter_type = /obj/item/gas_filter/plasmaman

/obj/item/clothing/mask/gas/syndicate/cybersun
	name = "\improper 赛博太阳面具"
	desc = "比起抵御环境危害，它更注重彰显态度。"
	icon_state = "cybersun"
	flags_cover = MASKCOVERSMOUTH
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = MASKCOVERSMOUTH
	alternate_worn_layer = BENEATH_HAIR_LAYER

/obj/item/clothing/mask/gas/clown_hat
	name = "小丑假发与面具"
	desc = "真正恶作剧大师的面部行头。没有假发和面具的小丑是不完整的。"
	clothing_flags = MASKINTERNALS
	icon_state = "clown"
	inhand_icon_state = "clown_hat"
	lefthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	dye_color = DYE_CLOWN
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	clothing_traits = list(TRAIT_PERCEIVED_AS_CLOWN)
	resistance_flags = FLAMMABLE
	actions_types = list(/datum/action/item_action/adjust_style)
	dog_fashion = /datum/dog_fashion/head/clown
	var/list/clownmask_designs = list()
	voice_filter = null // performer masks expect to be talked through
	fishing_modifier = 0

/obj/item/clothing/mask/gas/clown_hat/plasmaman
	starting_filter_type = /obj/item/gas_filter/plasmaman

/obj/item/clothing/mask/gas/clown_hat/Initialize(mapload)
	.=..()
	clownmask_designs = list(
		"True Form" = localized_radial_choice(image(icon = src.icon, icon_state = "clown"), GLOB.localized_mask_style_names["True Form"]),
		"The Coquette" = localized_radial_choice(image(icon = src.icon, icon_state = "sexyclown"), GLOB.localized_mask_style_names["The Coquette"]),
		"The Madman" = localized_radial_choice(image(icon = src.icon, icon_state = "joker"), GLOB.localized_mask_style_names["The Madman"]),
		"The Rainbow Color" = localized_radial_choice(image(icon = src.icon, icon_state = "rainbow"), GLOB.localized_mask_style_names["The Rainbow Color"]),
		"The Dealer" = localized_radial_choice(image(icon = src.icon, icon_state = "cards"), GLOB.localized_mask_style_names["The Dealer"]),
		)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0)

/obj/item/clothing/mask/gas/clown_hat/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated)
		return

	var/choice = show_radial_menu(user,src, clownmask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated && in_range(user,src))
		var/list/options = GLOB.clown_mask_options
		icon_state = options[choice]
		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(user, span_notice("你的小丑面具已变成‘[GLOB.localized_mask_style_names[choice] || choice]’款式，赞美滑稽之母！"))
		return TRUE

/obj/item/clothing/mask/gas/clown_hat/clownops
	name = "战术小丑假发与面具"
	desc = "为游吟艺人的传统行头增添战术风格。"
	flash_protect = FLASH_PROTECTION_FLASH
	resistance_flags = FIRE_PROOF
	flags_cover = MASKCOVERSEYES | PEPPERPROOF

/obj/item/clothing/mask/gas/sexyclown
	name = "性感小丑假发与面具"
	desc = "一副女式小丑面具，供尝试异装的人或女性艺人使用。"
	clothing_flags = MASKINTERNALS
	icon_state = "sexyclown"
	inhand_icon_state = "sexyclown_hat"
	lefthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	fishing_modifier = 0

/obj/item/clothing/mask/gas/jonkler
	name = "玩家假发与面具"
	desc = "但我是个玩家，不算是人；受世人羞辱，被众人鄙弃。"
	clothing_flags = MASKINTERNALS
	icon_state = "jonkler"
	inhand_icon_state = null
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/mime
	name = "默剧面具"
	desc = "传统的默剧面具，表情诡异。"
	clothing_flags = MASKINTERNALS
	icon_state = "mime"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	actions_types = list(/datum/action/item_action/adjust_style)
	species_exception = list(/datum/species/golem)
	fishing_modifier = 0
	var/list/mimemask_designs = list()

/obj/item/clothing/mask/gas/mime/plasmaman
	starting_filter_type = /obj/item/gas_filter/plasmaman

/obj/item/clothing/mask/gas/mime/Initialize(mapload)
	.=..()
	mimemask_designs = list(
		"Blanc" = localized_radial_choice(image(icon = src.icon, icon_state = "mime"), GLOB.localized_mask_style_names["Blanc"]),
		"Excité" = localized_radial_choice(image(icon = src.icon, icon_state = "sexymime"), GLOB.localized_mask_style_names["Excité"]),
		"Triste" = localized_radial_choice(image(icon = src.icon, icon_state = "sadmime"), GLOB.localized_mask_style_names["Triste"]),
		"Effrayé" = localized_radial_choice(image(icon = src.icon, icon_state = "scaredmime"), GLOB.localized_mask_style_names["Effrayé"])
		)

/obj/item/clothing/mask/gas/mime/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated)
		return

	var/list/options = list()
	options["Blanc"] = "mime"
	options["Triste"] = "sadmime"
	options["Effrayé"] = "scaredmime"
	options["Excité"] ="sexymime"

	var/choice = show_radial_menu(user,src, mimemask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated && in_range(user,src))
		icon_state = options[choice]
		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(user, span_notice("你的默剧面具已变成‘[GLOB.localized_mask_style_names[choice] || choice]’款式！"))
		return TRUE

/obj/item/clothing/mask/gas/monkeymask
	name = "猴子面具"
	desc = "扮演猴子时使用的面具。"
	clothing_flags = MASKINTERNALS
	icon_state = "monkeymask"
	inhand_icon_state = "owl_mask"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	fishing_modifier = 0
	emote_sounds = list(
		/datum/emote/living/scream::key = SFX_SCREECH,
	)

/obj/item/clothing/mask/gas/sexymime
	name = "性感默剧面具"
	desc = "传统的女式默剧面具。"
	clothing_flags = MASKINTERNALS
	icon_state = "sexymime"
	inhand_icon_state = null
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	species_exception = list(/datum/species/golem)
	fishing_modifier = 0

/obj/item/clothing/mask/gas/cyborg
	name = "半机械人面罩"
	desc = "哔啵。"
	icon_state = "death"
	resistance_flags = FLAMMABLE
	flags_cover = MASKCOVERSEYES
	fishing_modifier = 0

/obj/item/clothing/mask/gas/owl_mask
	name = "猫头鹰面具"
	desc = "咕呜——！"
	icon_state = "owl"
	inhand_icon_state = "owl_mask"
	clothing_flags = MASKINTERNALS
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	fishing_modifier = -2

/obj/item/clothing/mask/gas/carp
	name = "鲤鱼面具"
	desc = "咔嚓咔嚓。"
	icon_state = "carp_mask"
	inhand_icon_state = null
	flags_cover = MASKCOVERSEYES
	clothing_flags = MASKINTERNALS | CARP_STYLE_FACTOR
	fishing_modifier = -4

/obj/item/clothing/mask/gas/tiki_mask
	name = "提基面具"
	desc = "一个阴森的木制面具。虽然只是块粗糙的木雕，表情却出奇地生动。"
	icon_state = "tiki_eyebrow"
	inhand_icon_state = null
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)
	resistance_flags = FLAMMABLE
	flags_cover = MASKCOVERSEYES
	max_integrity = 100
	actions_types = list(/datum/action/item_action/adjust_style)
	dog_fashion = null
	fishing_modifier = -4
	var/list/tikimask_designs = list()

/obj/item/clothing/mask/gas/tiki_mask/Initialize(mapload)
	.=..()
	tikimask_designs = list(
		"Original Tiki" = localized_radial_choice(image(icon = src.icon, icon_state = "tiki_eyebrow"), GLOB.localized_mask_style_names["Original Tiki"]),
		"Happy Tiki" = localized_radial_choice(image(icon = src.icon, icon_state = "tiki_happy"), GLOB.localized_mask_style_names["Happy Tiki"]),
		"Confused Tiki" = localized_radial_choice(image(icon = src.icon, icon_state = "tiki_confused"), GLOB.localized_mask_style_names["Confused Tiki"]),
		"Angry Tiki" = localized_radial_choice(image(icon = src.icon, icon_state = "tiki_angry"), GLOB.localized_mask_style_names["Angry Tiki"])
		)

/obj/item/clothing/mask/gas/tiki_mask/ui_action_click(mob/user)
	var/mob/M = usr
	var/list/options = list()
	options["Original Tiki"] = "tiki_eyebrow"
	options["Happy Tiki"] = "tiki_happy"
	options["Confused Tiki"] = "tiki_confused"
	options["Angry Tiki"] ="tiki_angry"

	var/choice = show_radial_menu(user,src, tikimask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !IS_UNCONSCIOUS_OR_CRIT(M) && in_range(M,src))
		icon_state = options[choice]
		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(M, span_notice("提基面具已变成‘[GLOB.localized_mask_style_names[choice] || choice]’款式！"))
		return 1

/obj/item/clothing/mask/gas/tiki_mask/yalp_elor
	icon_state = "tiki_yalp"
	actions_types = list()

/obj/item/clothing/mask/gas/hunter
	name = "赏金猎人面具"
	desc = "一副贴有装饰贴花的定制战术面具。"
	icon_state = "hunter"
	inhand_icon_state = "gas_atmos"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEYES|HIDEEARS|HIDEHAIR|HIDESNOUT
	fishing_modifier = -4
	dirt_state = null

/obj/item/clothing/mask/gas/prop
	name = "道具防毒面具"
	desc = "一副只作装饰用的道具防毒面具。它无法像普通防毒面具那样过滤气体或抵御辣椒喷雾。"
	icon_state = "gas_prop"
	inhand_icon_state = "gas_prop"
	clothing_flags = NONE
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = FLAMMABLE
	fishing_modifier = 0

/obj/item/clothing/mask/gas/atmosprop
	name = "道具大气技术员防毒面具"
	desc = "一副只作装饰用的大气技术员防毒面具。它无法像普通版本那样过滤气体或抵御辣椒喷雾。"
	worn_icon_state = "gas_prop_atmos"
	icon_state = "gas_atmos"
	inhand_icon_state = "gas_atmos"
	clothing_flags = NONE
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = FLAMMABLE
	fishing_modifier = 0

/obj/item/clothing/mask/gas/driscoll
	name = "德里斯科尔面具"
	desc = "劫持火车的好帮手。功能与普通全面罩式防毒面具相同，但无法隐藏你的身份。"
	icon_state = "driscoll_mask"
	flags_inv = HIDEFACIALHAIR
	flags_cover = MASKCOVERSMOUTH
	w_class = WEIGHT_CLASS_NORMAL
	inhand_icon_state = null
	fishing_modifier = 0
