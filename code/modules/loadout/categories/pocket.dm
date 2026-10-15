/// Pocket items (Moved to backpack)
/datum/loadout_category/pocket
	category_name = "其他"
	category_ui_icon = FA_ICON_QUESTION
	type_to_generate = /datum/loadout_item/pocket_items
	tab_order = /datum/loadout_category/head::tab_order + 12 // DARKPACK EDIT CHANGE
	/// How many pocket items are allowed
	VAR_PRIVATE/max_allowed = 6 // DARKPACK EDIT CHANGE - Bumped up realtivly high as it contains a few soft "required" items for gameplay

/datum/loadout_category/pocket/New()
	. = ..()
	category_info = "（最多 [max_allowed] 件）"

/datum/loadout_category/pocket/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/list/datum/loadout_item/pocket_items/other_pocket_items = list()
	for(var/datum/loadout_item/pocket_items/other_pocket_item in all_loadout_items)
		other_pocket_items += other_pocket_item

	if(length(other_pocket_items) >= max_allowed)
		// We only need to deselect something if we're above the limit
		// (And if we are we prioritize the first item found, FIFO)
		manager.deselect_item(other_pocket_items[1])
	return TRUE

/datum/loadout_item/pocket_items
	abstract_type = /datum/loadout_item/pocket_items

/datum/loadout_item/pocket_items/on_equip_item(obj/item/equipped_item, list/item_details, mob/living/carbon/human/equipper, datum/outfit/job/outfit, visuals_only = FALSE)
	// Backpack items aren't created if it's a visual equipping, so don't do any on equip stuff. It doesn't exist.
	if(visuals_only)
		return NONE

	return ..()

/datum/loadout_item/pocket_items/plush
	group = "毛绒玩偶"
	abstract_type = /datum/loadout_item/pocket_items/plush
	loadout_flags = LOADOUT_FLAG_ALLOW_NAMING

/datum/loadout_item/pocket_items/plush/bee
	name = "毛绒玩偶（蜜蜂）"
	item_path = /obj/item/toy/plush/beeplushie

/datum/loadout_item/pocket_items/plush/carp
	name = "毛绒玩偶（鲤鱼）"
	item_path = /obj/item/toy/plush/carpplushie

/datum/loadout_item/pocket_items/plush/lizard_greyscale
	name = "毛绒玩偶（蜥蜴，可染色）"
	item_path = /obj/item/toy/plush/lizard_plushie/greyscale

/datum/loadout_item/pocket_items/plush/lizard_random
	name = "毛绒玩偶（蜥蜴，随机）"
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING
	ui_icon = 'icons/obj/fluff/previews.dmi'
	ui_icon_state = "plushie_lizard_random"
	item_path = /obj/item/toy/plush/lizard_plushie

/datum/loadout_item/pocket_items/plush/moth
	name = "毛绒玩偶（飞蛾）"
	item_path = /obj/item/toy/plush/moth

/datum/loadout_item/pocket_items/plush/nukie
	name = "毛绒玩偶（核特工）"
	item_path = /obj/item/toy/plush/nukeplushie

/datum/loadout_item/pocket_items/plush/peacekeeper
	name = "毛绒玩偶（维和机器人）"
	item_path = /obj/item/toy/plush/pkplush

/datum/loadout_item/pocket_items/plush/plasmaman
	name = "毛绒玩偶（等离子人）"
	item_path = /obj/item/toy/plush/plasmamanplushie

/datum/loadout_item/pocket_items/plush/human
	name = "毛绒玩偶（人类）"
	item_path = /obj/item/toy/plush/human

/datum/loadout_item/pocket_items/plush/rouny
	name = "毛绒玩偶（奔跑异形）"
	item_path = /obj/item/toy/plush/rouny

/datum/loadout_item/pocket_items/plush/snake
	name = "毛绒玩偶（蛇）"
	item_path = /obj/item/toy/plush/snakeplushie

/datum/loadout_item/pocket_items/plush/horse
	name = "毛绒玩偶（马）"
	item_path = /obj/item/toy/plush/horse

/datum/loadout_item/pocket_items/dice
	group = "骰子"
	abstract_type = /datum/loadout_item/pocket_items/dice

/datum/loadout_item/pocket_items/dice/dice_bag
	name = "骰子袋"
	item_path = /obj/item/storage/dice

/datum/loadout_item/pocket_items/dice/d1
	name = "单面骰（D1）"
	item_path = /obj/item/dice/d1

/datum/loadout_item/pocket_items/dice/d2
	name = "两面骰（D2）"
	item_path = /obj/item/dice/d2

/datum/loadout_item/pocket_items/dice/d4
	name = "四面骰（D4）"
	item_path = /obj/item/dice/d4

/datum/loadout_item/pocket_items/dice/d6
	name = "六面骰（D6）"
	item_path = /obj/item/dice/d6

/datum/loadout_item/pocket_items/dice/d6_ebony
	name = "六面骰（D6，乌木）"
	item_path = /obj/item/dice/d6/ebony

/datum/loadout_item/pocket_items/dice/d6_space
	name = "六面骰（D6，太空）"
	item_path = /obj/item/dice/d6/space

/datum/loadout_item/pocket_items/dice/d8
	name = "八面骰（D8）"
	item_path = /obj/item/dice/d8

/datum/loadout_item/pocket_items/dice/d10
	name = "十面骰（D10）"
	item_path = /obj/item/dice/d10

/datum/loadout_item/pocket_items/dice/d12
	name = "十二面骰（D12）"
	item_path = /obj/item/dice/d12

/datum/loadout_item/pocket_items/dice/d20
	name = "二十面骰（D20）"
	item_path = /obj/item/dice/d20

/datum/loadout_item/pocket_items/dice/d100
	name = "百面骰（D100）"
	item_path = /obj/item/dice/d100

/datum/loadout_item/pocket_items/dice/d00
	name = "百分骰（D00）"
	item_path = /obj/item/dice/d00

/datum/loadout_item/pocket_items/card_binder
	name = "卡牌收集册"
	item_path = /obj/item/storage/card_binder

/datum/loadout_item/pocket_items/card_deck
	name = "扑克牌"
	item_path = /obj/item/toy/cards/deck

/datum/loadout_item/pocket_items/kotahi_deck
	name = "科塔希牌"
	item_path = /obj/item/toy/cards/deck/kotahi

/datum/loadout_item/pocket_items/wizoff_deck
	name = "巫师对决牌"
	item_path = /obj/item/toy/cards/deck/wizoff

/datum/loadout_item/pocket_items/lipstick
	name = "口红"
	item_path = /obj/item/lipstick

/datum/loadout_item/pocket_items/lipstick/get_item_information()
	. = ..()
	.[FA_ICON_PALETTE] = "可染色"

/datum/loadout_item/pocket_items/lipstick/on_equip_item(obj/item/equipped_item, list/item_details, mob/living/carbon/human/equipper, datum/outfit/job/outfit, visuals_only = FALSE)
	. = ..()
	if(isnull(equipped_item))
		return
	var/picked_style = style_to_style(item_details[INFO_LAYER])
	var/picked_color = item_details[INFO_GREYSCALE] || /obj/item/lipstick::lipstick_color
	var/obj/item/lipstick/lipstick_item = equipped_item
	lipstick_item.style = picked_style
	lipstick_item.lipstick_color = picked_color
	equipper.update_lips(picked_style, picked_color)

/// Converts style (readable) to style (internal)
/datum/loadout_item/pocket_items/lipstick/proc/style_to_style(style)
	switch(style)
		if(UPPER_LIP)
			return "lipstick_upper"
		if(LOWER_LIP)
			return "lipstick_lower"
	return "lipstick"

/datum/loadout_item/pocket_items/lipstick/get_ui_buttons()
	. = ..()
	UNTYPED_LIST_ADD(., list(
		"label" = "样式",
		"act_key" = "select_lipstick_style",
		"button_icon" = FA_ICON_ARROWS_ROTATE,
		"active_key" = INFO_LAYER,
	))
	UNTYPED_LIST_ADD(., list(
		"label" = "颜色",
		"act_key" = "select_lipstick_color",
		"button_icon" = FA_ICON_PALETTE,
		"active_key" = INFO_GREYSCALE,
	))

	return .

/datum/loadout_item/pocket_items/lipstick/handle_loadout_action(datum/preference_middleware/loadout/manager, mob/user, action, params)
	switch(action)
		if("select_lipstick_style")
			var/list/their_loadout = manager.preferences.read_preference(/datum/preference/loadout)
			var/list/lip_styles = list("上唇" = UPPER_LIP, "唇中部" = MIDDLE_LIP, "下唇" = LOWER_LIP)
			var/chosen = lip_styles[tgui_input_list(user, "选择口红样式（决定口红在角色外观上的位置）。", "选择样式", lip_styles, lip_styles[assoc_to_values(lip_styles).Find(their_loadout?[item_path]?[INFO_LAYER] || MIDDLE_LIP)])]
			their_loadout = manager.preferences.read_preference(/datum/preference/loadout) // after sleep: sanity check
			if(their_loadout?[item_path]) // Validate they still have it equipped
				their_loadout[item_path][INFO_LAYER] = chosen
				manager.preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout], their_loadout)
			return TRUE // Update UI

		if("select_lipstick_color")
			var/list/their_loadout = manager.preferences.read_preference(/datum/preference/loadout)
			var/old_color = their_loadout?[item_path]?[INFO_GREYSCALE] || /obj/item/lipstick::lipstick_color
			var/chosen = tgui_color_picker(user, "选择口红颜色。", "选择颜色", old_color)
			their_loadout = manager.preferences.read_preference(/datum/preference/loadout) // after sleep: sanity check
			if(their_loadout?[item_path]) // Validate they still have it equipped
				their_loadout[item_path][INFO_GREYSCALE] = chosen
				manager.preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout], their_loadout)
			return TRUE // Update UI

	return ..()

/datum/loadout_item/pocket_items/lighter
	name = "芝宝打火机"
	item_path = /obj/item/lighter

/datum/loadout_item/pocket_items/flask
	name = "便携酒壶"
	item_path = /obj/item/reagent_containers/cup/glass/flask

/datum/loadout_item/pocket_items/clipboard
	name = "写字板"
	item_path = /obj/item/clipboard

/datum/loadout_item/pocket_items/dye
	name = "染发剂"
	item_path = /obj/item/dyespray

/datum/loadout_item/pocket_items/poster
	name = "海报（违禁）"
	item_path = /obj/item/poster/random_contraband

/datum/loadout_item/pocket_items/poster_pinup
	name = "海报（性感人物）"
	item_path = /obj/item/poster/random_contraband/pinup

/* // DARKPACK EDIT REMOVAL
/datum/loadout_item/pocket_items/holodisk
	name = "Holodisk"
	item_path = /obj/item/disk/holodisk

/datum/loadout_item/pocket_items/mug_nt
	name = "Nanotrasen Mug"
	item_path = /obj/item/reagent_containers/cup/glass/mug/nanotrasen
*/

/datum/loadout_item/pocket_items/britcup
	name = "英国国旗杯"
	item_path = /obj/item/reagent_containers/cup/glass/mug/britcup

// The wallet loadout item is special, and puts the player's ID and other small items into it on initialize (fancy!)
/datum/loadout_item/pocket_items/wallet
	name = "钱包"
	item_path = /obj/item/storage/wallet/darkpack // DARKPACK EDIT CHANGE - ORIGINAL: item_path = /obj/item/storage/wallet

/datum/loadout_item/pocket_items/wallet/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	return

/datum/loadout_item/pocket_items/wallet/on_equip_item(obj/item/equipped_item, list/item_details, mob/living/carbon/human/equipper, datum/outfit/job/outfit, visuals_only = FALSE)
	// Do this at the very end of the setup process so we can insert quirk items and such
	if(!visuals_only && !isdummy(equipper))
		RegisterSignal(equipper, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED, PROC_REF(apply_after_setup), override = TRUE)
	return NONE

/datum/loadout_item/pocket_items/wallet/proc/apply_after_setup(mob/living/carbon/human/source, ...)
	SIGNAL_HANDLER
	equip_wallet(source)
	UnregisterSignal(source, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED)

/datum/loadout_item/pocket_items/wallet/proc/equip_wallet(mob/living/carbon/human/equipper)
	var/obj/item/card/id_card = equipper.get_item_by_slot(ITEM_SLOT_ID) // DARKPACK EDIT CHANGE - ORIGINAL: var/obj/item/card/id/advanced/id_card = equipper.get_item_by_slot(ITEM_SLOT_ID)
	if(istype(id_card, /obj/item/storage/wallet/darkpack)) // Wallets station trait guard // DARKPACK EDIT CHANGE - ORIGINAL: if(istype(id_card, /obj/item/storage/wallet)) // Wallets station trait guard
		return

	var/obj/item/storage/wallet/darkpack/wallet = new(equipper) // DARKPACK EDIT CHANGE - ORIGINAL: var/obj/item/storage/wallet/wallet = new(equipper)
	if(!istype(id_card))
		// They must have a PDA or some other thing in their ID slot, abort
		if(!equipper.equip_to_storage(wallet, ITEM_SLOT_BACK, indirect_action = TRUE))
			wallet.forceMove(equipper.drop_location())
		return

	equipper.temporarilyRemoveItemFromInventory(id_card, force = TRUE)
	equipper.equip_to_slot_if_possible(wallet, ITEM_SLOT_ID, initial = TRUE)
	id_card.forceMove(wallet)

	for(var/obj/item/thing in equipper?.back)
		// leaves a slot free for whatever they may want
		if(length(wallet.contents) >= wallet.atom_storage.max_slots - 1)
			break
		if(thing.w_class > wallet.atom_storage.max_specific_storage)
			continue
		wallet.atom_storage.attempt_insert(thing, override = TRUE, force = STORAGE_FULLY_LOCKED, messages = FALSE)

/* // DARKPACK EDIT REMOVAL
/datum/loadout_item/pocket_items/borg_me_dogtag
	item_path = /obj/item/clothing/accessory/dogtag/borg_ready

/datum/loadout_item/pocket_items/borg_me_dogtag/on_equip_item(obj/item/equipped_item, list/item_details, mob/living/carbon/human/equipper, datum/outfit/job/outfit, visuals_only)
	// We're hooking this datum to add an extra bit of flavor to the dogtag - a pregenerated medical record
	if(!visuals_only && !isdummy(equipper))
		RegisterSignal(equipper, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED, PROC_REF(apply_after_setup), override = TRUE)
	return NONE

/datum/loadout_item/pocket_items/borg_me_dogtag/proc/apply_after_setup(mob/living/carbon/human/source, ...)
	SIGNAL_HANDLER

	UnregisterSignal(source, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED)
	var/datum/record/crew/record = find_record(source.real_name)
	record?.medical_notes += new /datum/medical_note("Central Command", "Patient is a registered brain donor for Robotics research.", null)
*/

/datum/loadout_item/pocket_items/candles
	name = "蜡烛盒"
	item_path = /obj/item/storage/fancy/candle_box
