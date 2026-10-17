#define BOTTLE_KNOCKDOWN_DEFAULT_DURATION (1.3 SECONDS)

///////////////////////////////////////////////Alchohol bottles! -Agouri //////////////////////////
//Functionally identical to regular drinks. The only difference is that the default bottle size is 100. - Darem
//Bottles now knockdown and break when smashed on people's heads. - Giacom

/obj/item/reagent_containers/cup/glass/bottle
	name = "玻璃瓶"
	desc = "没有标签的瓶子，完全看不出里面装了什么。"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "glassbottle"
	worn_icon_state = "bottle"
	icon_angle = 90
	fill_icon_thresholds = list(0, 10, 20, 30, 40, 50, 60, 70, 80, 90)
	custom_price = PAYCHECK_CREW * 1.1
	amount_per_transfer_from_this = 10
	volume = 100
	force = 15 //Smashing bottles over someone's head hurts.
	throwforce = 15
	demolition_mod = 0.25
	inhand_icon_state = "beer" //Generic held-item sprite until unique ones are made.
	var/broken_inhand_icon_state = "broken_beer"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	age_restricted = TRUE // wrryy can't set an init value to see if drink_type contains ALCOHOL so here we go
	///Directly relates to the 'knockdown' duration. Lowered by armor (i.e. helmets)
	var/bottle_knockdown_duration = BOTTLE_KNOCKDOWN_DEFAULT_DURATION
	tool_behaviour = TOOL_ROLLINGPIN // Glass bottles can be used as rolling pins when empty
	toolspeed = 1.3 //it's a little awkward to use, but it's a cylinder alright.
	/// A contained piece of paper, a photo, or space cash, that we can use as a message or gift to future spessmen.
	var/obj/item/message_in_a_bottle

/obj/item/reagent_containers/cup/glass/bottle/Initialize(mapload, vol)
	. = ..()
	var/static/list/recipes =  list(/datum/crafting_recipe/molotov)
	AddElement(/datum/element/slapcrafting, recipes)
	register_item_context()

/obj/item/reagent_containers/cup/glass/bottle/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(message_in_a_bottle)
		return NONE
	if(istype(held_item, /obj/item/paper) || istype(held_item, /obj/item/stack/spacecash) || istype(held_item, /obj/item/photo))
		context[SCREENTIP_CONTEXT_LMB] = "放入留言"
		return CONTEXTUAL_SCREENTIP_SET
	return NONE

/obj/item/reagent_containers/cup/glass/bottle/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	if(message_in_a_bottle && HAS_TRAIT(target, TRAIT_MESSAGE_IN_A_BOTTLE_LOCATION))
		context[SCREENTIP_CONTEXT_RMB] = "投出漂流瓶"
		return CONTEXTUAL_SCREENTIP_SET
	return NONE

/obj/item/reagent_containers/cup/glass/bottle/on_reagent_change(datum/reagents/holder, ...)
	. = ..()
	if(!reagents?.total_volume)
		tool_behaviour = TOOL_ROLLINGPIN // Glass bottles can be used as rolling pins when empty
	else
		tool_behaviour = null

/obj/item/reagent_containers/cup/glass/bottle/Exited(atom/movable/gone, atom/newloc)
	if(gone == message_in_a_bottle)
		message_in_a_bottle = null
		if(!QDELETED(src))
			update_icon(UPDATE_OVERLAYS)
	return ..()

/obj/item/reagent_containers/cup/glass/bottle/used_in_craft(atom/result, datum/crafting_recipe/current_recipe)
	. = ..()
	message_in_a_bottle?.forceMove(drop_location())

/obj/item/reagent_containers/cup/glass/bottle/examine(mob/user)
	. = ..()
	if(message_in_a_bottle)
		. += span_info("里面有[message_in_a_bottle]。打碎瓶子可取出，或找片海滩、海洋，用[EXAMINE_HINT("右键点击")]投出漂流瓶。")
	else if(isGlass)
		. += span_tinynoticeital("你可以往里面放纸张、照片或太空现金……")

/obj/item/reagent_containers/cup/glass/bottle/update_overlays()
	. = ..()
	if(message_in_a_bottle)
		var/overlay = add_message_overlay()
		if(overlay)
			. += overlay

/obj/item/reagent_containers/cup/glass/bottle/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	if(user.combat_mode || !HAS_TRAIT(target, TRAIT_MESSAGE_IN_A_BOTTLE_LOCATION))
		return ..()
	if(!user.temporarilyRemoveItemFromInventory(src))
		balloon_alert(user, "它粘在你手上了！")
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_notice("[user]将[src]投进[target]"), span_notice("你将[src]投进[target]"), span_notice("你听见水花声。"))
	SSpersistence.save_message_bottle(message_in_a_bottle, type)
	playsound(target, 'sound/effects/bigsplash.ogg', 70)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/glass/bottle/item_interaction(mob/living/user, obj/item/item, list/modifiers)
	if(!isGlass)
		return NONE
	if(!istype(item, /obj/item/paper) && !istype(item, /obj/item/stack/spacecash) && !istype(item, /obj/item/photo))
		return NONE
	if(message_in_a_bottle)
		balloon_alert(user, "已经有留言了！")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(item, src))
		balloon_alert(user, "它粘在你手上了！")
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "已放入留言")
	message_in_a_bottle = item
	update_icon(UPDATE_OVERLAYS)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/glass/bottle/proc/add_message_overlay()
	if(istype(message_in_a_bottle, /obj/item/paper))
		return "paper_in_bottle"
	if(istype(message_in_a_bottle, /obj/item/photo))
		return "photo_in_bottle"
	if(istype(message_in_a_bottle, /obj/item/stack/spacecash))
		return "cash_in_bottle"

/obj/item/reagent_containers/cup/glass/bottle/small
	name = "小玻璃瓶"
	desc = "没有标签的瓶子，完全看不出里面装了什么。"
	icon_state = "glassbottlesmall"
	volume = 50
	custom_price = PAYCHECK_CREW * 0.9

/obj/item/reagent_containers/cup/glass/bottle/post_smash(atom/target, atom/thrower, datum/thrownthing/throwingdatum, obj/item/broken_bottle/broken)
	if(!throwingdatum && ismob(thrower))
		astype(thrower, /mob).put_in_hands(broken)
	broken.inhand_icon_state = broken_inhand_icon_state
	message_in_a_bottle?.forceMove(drop_location())

/obj/item/reagent_containers/cup/glass/bottle/try_splash(mob/user, atom/target)
	if(!isGlass)
		return ..()
	return FALSE // instead of splashing, hit them with the bottle!

/obj/item/reagent_containers/cup/glass/bottle/afterattack(atom/target, mob/user, list/modifiers)
	if(!isGlass)
		return

	var/head_hitter = user.zone_selected == BODY_ZONE_HEAD && isliving(target)
	if(!QDELETED(target))
		// An attack that targets the head of a living mob will attempt to knock them down
		if(head_hitter)
			var/mob/living/living_target = target
			var/knockdown_effectiveness = 0
			if(!HAS_TRAIT(target, TRAIT_HEAD_INJURY_BLOCKED))
				knockdown_effectiveness = bottle_knockdown_duration + ((force / 10) * 1 SECONDS) - living_target.getarmor(BODY_ZONE_HEAD, MELEE)
			if(prob(knockdown_effectiveness))
				living_target.Knockdown(min(knockdown_effectiveness, 20 SECONDS))

	// Displays a custom message which follows the attack
	if(target == user)
		user.visible_message(
			span_warning("[user]将[src]砸向自己的[head_hitter ? "头部" : "身体"]！"),
			span_warning("你将[src]砸向自己的[head_hitter ? "头部" : "身体"]！"),
		)

	else
		user.visible_message(
			span_warning("[user]将[src]砸向[target][head_hitter ? "的头部" : ""]！"),
			span_warning("你将[src]砸向[target][head_hitter ? "的头部" : ""]！"),
		)

	// Finally, smash the bottle. This kills (del) the bottle and also does all the logging for us
	smash(target, user)

/*
 * Proc to make the bottle spill some of its contents out in a froth geyser of varying intensity/height
 * Arguments:
 * * offset_x = pixel offset by x from where the froth animation will start
 * * offset_y = pixel offset by y from where the froth animation will start
 * * intensity = how strong the effect is, both visually and in the amount of reagents lost. comes in three flavours
*/
/obj/item/reagent_containers/cup/glass/bottle/proc/make_froth(offset_x, offset_y, intensity)
	if(!intensity)
		return

	if(!reagents.total_volume)
		return

	var/amount_lost = intensity * 5
	reagents.remove_all(amount_lost)

	visible_message(span_warning("[name]里的东西喷出来了一些！"))
	var/intensity_state = null
	switch(intensity)
		if(1)
			intensity_state = "low"
		if(2)
			intensity_state = "medium"
		if(3)
			intensity_state = "high"
	///The froth fountain that we are sticking onto the bottle
	var/mutable_appearance/froth = mutable_appearance('icons/obj/drinks/drink_effects.dmi', "froth_bottle_[intensity_state]")
	froth.pixel_w = offset_x
	froth.pixel_z = offset_y
	add_overlay(froth)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, cut_overlay), froth), 2 SECONDS)

//Keeping this here for now, I'll ask if I should keep it here.
/obj/item/broken_bottle
	name = "碎酒瓶"
	desc = "底部破碎、边缘锋利的瓶子。"
	icon = 'icons/obj/drinks/drink_effects.dmi'
	icon_state = "broken_bottle"
	force = 9
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	demolition_mod = 0.25
	w_class = WEIGHT_CLASS_TINY
	inhand_icon_state = "broken_beer"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("刺击", "劈砍", "攻击")
	attack_verb_simple = list("刺击", "劈砍", "攻击")
	sharpness = SHARP_EDGED
	custom_materials = list(/datum/material/glass=SMALL_MATERIAL_AMOUNT)
	///The mask image for mimicking a broken-off bottom of the bottle
	var/static/icon/broken_outline = icon('icons/obj/drinks/drink_effects.dmi', "broken")
	///The mask image for mimicking a broken-off neck of the bottle
	var/static/icon/flipped_broken_outline = icon('icons/obj/drinks/drink_effects.dmi', "broken-flipped")

/obj/item/broken_bottle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = force)
	AddComponent(/datum/component/butchering, \
		speed = 20 SECONDS, \
		effectiveness = 55, \
	)

/// Mimics the appearance and properties of the passed in bottle.
/// Takes the broken bottle to mimic, and the thing the bottle was broken agaisnt as args
/obj/item/broken_bottle/proc/mimic_broken(obj/item/reagent_containers/cup/glass/to_mimic, atom/target, break_top)
	icon_state = to_mimic.icon_state
	var/icon/drink_icon = new(to_mimic.icon, icon_state)
	if(break_top) //if the bottle breaks its top off instead of the bottom
		desc = "瓶颈被砸断的瓶子。"
		drink_icon.Blend(flipped_broken_outline, ICON_OVERLAY, rand(5), 0)
	else
		drink_icon.Blend(broken_outline, ICON_OVERLAY, rand(5), 1)
	drink_icon.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
	icon = drink_icon

	if(istype(to_mimic, /obj/item/reagent_containers/cup/glass/bottle/juice))
		force = 0
		throwforce = 0
		desc = "下半部分裂开的纸盒，可能会割伤手。"
	else
		if(prob(33))
			new /obj/item/shard(to_mimic.drop_location())
		playsound(src, SFX_SHATTER, 70, TRUE)
	name = "破损的[to_mimic.name]"
	to_mimic.transfer_fingerprints_to(src)

/obj/item/reagent_containers/cup/glass/bottle/beer
	name = "啤酒" // DARKPACK EDIT CHANGE
	desc = "啤酒。" // DARKPACK EDIT CHANGE
	icon_state = "beer"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 30)
	drink_type = GRAIN | ALCOHOL
	custom_price = 5 // DARKPACK EDIT CHANGE - ECONOMY

/obj/item/reagent_containers/cup/glass/bottle/beer/almost_empty
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 1)

/obj/item/reagent_containers/cup/glass/bottle/beer/light
	name = "鲤清淡啤"
	desc = "以“纯净冰小行星泉水”酿造。"
	icon_state = "litebeer"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/light = 30)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/rootbeer
	name = "再来一回沙士"
	desc = "广受欢迎的老牌沙士，以超高糖配方闻名，喝完可能会想打个盹。"
	icon_state = "twotime"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/rootbeer = 30)
	drink_type = SUGAR | JUNKFOOD
	custom_price = PAYCHECK_CREW * 1.5
	custom_premium_price = PAYCHECK_CREW * 2

/obj/item/reagent_containers/cup/glass/bottle/ale
	name = "熔岩艾尔"
	desc = "真正矮人的首选饮品。"
	icon_state = "alebottle"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/ale = 30)
	drink_type = GRAIN | ALCOHOL
	custom_price = PAYCHECK_CREW

/obj/item/reagent_containers/cup/glass/bottle/gin
	name = "捣蛋终结者金酒"
	desc = "一瓶伦敦出产的优质金酒。" // DARKPACK EDIT CHANGE
	icon_state = "ginbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/gin = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/whiskey
	name = "怪叔叔珍藏威士忌"
	desc = "在核避难所隧道内缓慢熟成的优质单一麦芽威士忌。隧道威士忌天下第一。"
	icon_state = "whiskeybottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/kong
	name = "金刚酒"
	desc = "让你猿形毕露！&#174;"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey/kong = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/candycornliquor
	name = "玉米糖酒"
	desc = "就像二维地下酒馆里喝的那种酒。"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey/candycorn = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/vodka
	name = "通古斯三重蒸馏伏特加"
	desc = "啊，伏特加。全世界俄罗斯人的首选饮料兼燃料。"
	icon_state = "vodkabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/vodka/badminka
	name = "巴德明卡伏特加"
	desc = "标签用西里尔字母写成，你只能认出名字和一个看着像“伏特加”的词。"
	icon_state = "badminka"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/tequila
	name = "卡卡沃品质保证龙舌兰酒"
	desc = "采用优质石油馏分、纯沙利度胺及其他上等原料制成！"
	icon_state = "tequilabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/tequila = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/bottleofnothing
	name = "瓶装虚无"
	desc = "装满虚无的瓶子。"
	icon_state = "bottleofnothing"
	list_reagents = list(/datum/reagent/consumable/nothing = 100)
	age_restricted = FALSE

/obj/item/reagent_containers/cup/glass/bottle/patron
	name = "说唱艺人培恩龙舌兰酒"
	desc = "掺有银的龙舌兰酒，世界各地夜店均有供应。" // DARKPACK EDIT CHANGE
	icon_state = "patronbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/patron = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/rum
	name = "皮特船长古巴香料朗姆酒"
	desc = "这可不只是朗姆酒，简直是装在瓶子里的捣蛋精。"
	icon_state = "rumbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/rum = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/rum/aged
	name = "皮特船长陈年香料朗姆酒"
	desc = "吓死本船长了，皮特船长朗姆酒的陈年版，简直是瓶装五十多年的捣蛋精。"
	icon_state = "rumbottle_gold"
	list_reagents = list(/datum/reagent/consumable/ethanol/rum/aged = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/maltliquor
	name = "\improper 狂熊麦芽烈酒"
	desc = "一大瓶麦芽烈酒，劲头比狂熊还猛。"
	icon_state = "maltliquorbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/maltliquor = 100)
	custom_price = PAYCHECK_CREW
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/holywater
	name = "圣水瓶"
	desc = "一瓶牧师的圣水。"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "holyflask"
	worn_icon_state = "holyflask"
	inhand_icon_state = "holyflask"
	broken_inhand_icon_state = "broken_holyflask"
	list_reagents = list(/datum/reagent/water/holywater = 100)

/obj/item/reagent_containers/cup/glass/bottle/holywater/add_message_overlay()
	return //looks too weird...

/obj/item/reagent_containers/cup/glass/bottle/holywater/hell
	desc = "一瓶圣水……不过已经在亡者之城里放了一阵子。"
	icon_state = "unholyflask"
	list_reagents = list(/datum/reagent/hellwater = 100)

/obj/item/reagent_containers/cup/glass/bottle/vermouth
	name = "黄金眼味美思"
	desc = "甜美的干冽滋味～"
	icon_state = "vermouthbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/vermouth = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/kahlua
	name = "罗伯特·强悍咖啡利口酒"
	desc = "广为人知的墨西哥咖啡味利口酒，自1936年起生产，HONK。"
	icon_state = "kahluabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 100)
	drink_type = VEGETABLES

/obj/item/reagent_containers/cup/glass/bottle/goldschlager
	name = "大学女生金箔肉桂酒"
	desc = "因为只有她们会喝酒精度50%的肉桂甜酒。"
	icon_state = "goldschlagerbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/goldschlager = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/cognac
	name = "警棍庄园高级干邑"
	desc = "历经多次蒸馏和多年陈酿的香甜烈酒，这次还是别喊“垃圾安保”了。"
	icon_state = "cognacbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/cognac = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/wine
	name = "双胡子大胡子特酿葡萄酒"
	desc = "瓶子周围弥漫着淡淡的不安与蛋疼气息。"
	icon_state = "winebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 100)
	drink_type = FRUIT | ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/wine/add_initial_reagents()
	. = ..()
	var/wine_info = generate_vintage()
	var/datum/reagent/consumable/ethanol/wine/located_wine = locate() in reagents.reagent_list
	if(located_wine)
		LAZYSET(located_wine.data, "vintage", wine_info)

/obj/item/reagent_containers/cup/glass/bottle/wine/proc/generate_vintage()
	return "[CURRENT_STATION_YEAR]年经典淡红葡萄酒" // DARKPACK EDIT CHANGE

/obj/item/reagent_containers/cup/glass/bottle/wine/unlabeled
	name = "无标签葡萄酒瓶"
	desc = "这个葡萄酒瓶上没有标签。"

/obj/item/reagent_containers/cup/glass/bottle/wine/unlabeled/generate_vintage()
	var/year = rand(CURRENT_STATION_YEAR - 50, CURRENT_STATION_YEAR)
	var/type = pick(
		"浓郁红葡萄酒",
		"甜点酒",
		"干白葡萄酒",
		"淡红葡萄酒",
		"中等酒体红葡萄酒",
		"醇厚白葡萄酒",
		"桃红葡萄酒",
		"起泡酒",
		"甜白葡萄酒",
	)
	var/origin = pick(
		"本地",
		"酒港", // DARKPACK EDIT CHANGE
		"美景庄园", // DARKPACK EDIT CHANGE
	)
	return "[year] [origin] [type]"

// DARKPACK EDIT ADD START
/obj/item/reagent_containers/cup/glass/bottle/wine/blood
	// DARKPACK TODO - I would like this to be a roll without it being dumb.
	desc = "瓶盖上有一抹淡淡的红色痕迹……"
	list_reagents = list(/datum/reagent/blood = 100)
// DARKPACK EDIT ADD END

/obj/item/reagent_containers/cup/glass/bottle/absinthe
	name = "超烈苦艾酒"
	desc = "一款烈酒，酿造与经销商为"
	icon_state = "absinthebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/absinthe = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/absinthe/Initialize(mapload)
	. = ..()
	redact()

/obj/item/reagent_containers/cup/glass/bottle/absinthe/proc/redact()
	// There was a large fight in the coderbus about a player reference
	// in absinthe. Ergo, this is why the name generation is now so
	// complicated. Judge us kindly.
	var/shortname = pick_weight(
		list("T&T" = 1, "A&A" = 1, "Generic" = 1))
	var/fullname
	switch(shortname)
		if("T&T")
			fullname = "青绿 更青绿"
		if("A&A")
			fullname = "灰烬 更多灰烬"
		if("Generic")
			fullname = "利奥波德 廉价 仿品" // DARKPACK EDIT CHANGE
	var/removals = list(
		"\[已编辑\]",
		"\[脏话已删除\]",
		"\[已抹除\]",
		"\[信息超出你的安全权限\]",
		"\[公民请继续前进\]",
		"\[此处无可奉告\]",
	)
	var/chance = 50

	if(prob(chance))
		shortname = pick_n_take(removals)

	var/list/final_fullname = list()
	for(var/word in splittext(fullname, " "))
		if(prob(chance))
			word = pick_n_take(removals)
		final_fullname += word

	fullname = jointext(final_fullname, " ")

	// Actually finally setting the new name and desc
	name = "[shortname == "Generic" ? "通用牌" : shortname] [name]"
	desc = "[desc][fullname]公司。"


/obj/item/reagent_containers/cup/glass/bottle/absinthe/premium
	name = "葛温高级苦艾酒"
	desc = "强劲的酒精饮料，几乎能让你忘记肺里的灰烬。"
	icon_state = "absinthepremium"
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/absinthe/premium/redact()
	return

/obj/item/reagent_containers/cup/glass/bottle/lizardwine
	name = "瓶装蜥蜴酒"
	desc = "来自中国的酒精饮料，将蜥蜴尾巴浸入乙醇制成。不知为何不受统治精英欢迎。" // DARKPACK EDIT CHANGE
	icon_state = "lizardwine"
	list_reagents = list(/datum/reagent/consumable/ethanol/lizardwine = 100)
	drink_type = FRUIT | ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/hcider
	name = "健牌苹果酒"
	desc = "成年人喝的苹果汁。"
	icon_state = "hcider"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/ethanol/hcider = 50)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/amaretto
	name = "卢伊尼杏仁利口酒"
	desc = "温和浓稠的酒饮，带有杏仁和杏子的味道。"
	icon_state = "disaronno"
	list_reagents = list(/datum/reagent/consumable/ethanol/amaretto = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/grappa
	name = "菲利普陈年格拉帕"
	desc = "一瓶格拉帕白兰地。"
	icon_state = "grappabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/grappa = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/sake
	name = "凉牌传统清酒"
	desc = "香甜无比，咽下时却如烈火灼烧。"
	icon_state = "sakebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/sake = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/sake/Initialize(mapload)
	if(prob(10))
		name = "绒尾清酒"
		desc += " 瓶上画着一只妖狐，九条尾巴看着都很好摸。"
		icon_state = "sakebottle_k"
	else if(prob(10))
		name = "犬走家酿"
		desc += " 嗷呜。"
		icon_state = "sakebottle_i"
	return ..()

/obj/item/reagent_containers/cup/glass/bottle/sake/add_message_overlay()
	if(icon_state == "sakebottle_k") //doesn't fit the sprite
		return
	return ..()

/obj/item/reagent_containers/cup/glass/bottle/fernet
	name = "布隆卡菲奈特苦酒"
	desc = "一瓶意大利出产的纯正布隆卡菲奈特苦酒。" // DARKPACK EDIT CHANGE
	icon_state = "fernetbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/fernet = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/bitters
	name = "仙女座苦精"
	desc = "为各类饮品增添芳香，永远在新特立尼达生产。"
	icon_state = "bitters_bottle"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/bitters = 30)
	drink_type = ALCOHOL
	//allows for single unit dispensing
	possible_transfer_amounts = list(1, 2, 3, 4, 5)
	amount_per_transfer_from_this = 5

/obj/item/reagent_containers/cup/glass/bottle/curacao
	name = "贝克霍夫蓝橙酒"
	desc = "这么多年过去，仍在库拉索岛生产。"
	icon_state = "curacao_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/curacao = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/curacao/add_message_overlay()
	return //doesn't fit the sprite

/obj/item/reagent_containers/cup/glass/bottle/navy_rum
	name = "联邦之傲海军烈度朗姆酒"
	desc = "考虑到它产自百慕大，这名字真讽刺。"
	icon_state = "navy_rum_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/navy_rum = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/grenadine
	name = "弄臣红石榴糖浆"
	desc = "真正樱桃含量为0%！"
	custom_price = PAYCHECK_CREW
	icon_state = "grenadine"
	list_reagents = list(/datum/reagent/consumable/grenadine = 100)
	drink_type = FRUIT
	age_restricted = FALSE

/obj/item/reagent_containers/cup/glass/bottle/applejack
	name = "烈马苹果白兰地"
	desc = "劲头像马踢，滋味如苹果！"
	custom_price = PAYCHECK_CREW
	icon_state = "applejack_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/applejack = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/wine_voltaic
	name = "伏打黄酒"
	desc = "注入电能的酒！可为以太人充电，能安全饮用。"
	custom_price = PAYCHECK_CREW
	icon_state = "wine_voltaic_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/wine_voltaic = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/champagne
	name = "花花公子极干香槟"
	desc = "精选自法国最故作高雅的葡萄园。"
	icon_state = "champagne_bottle"
	base_icon_state = "champagne_bottle"
	initial_reagent_flags = TRANSPARENT
	list_reagents = list(/datum/reagent/consumable/ethanol/champagne = 100)
	drink_type = ALCOHOL
	///Used for sabrage; increases the chance of success per 1 force of the attacking sharp item
	var/sabrage_success_percentile = 5
	///Whether this bottle was a victim of a successful sabrage attempt
	var/sabraged = FALSE

/obj/item/reagent_containers/cup/glass/bottle/champagne/add_message_overlay()
	return //doesn't stylistically fit the sprite

/obj/item/reagent_containers/cup/glass/bottle/champagne/cursed
	sabrage_success_percentile = 0 //force of the sharp item used to sabrage will not increase success chance

/obj/item/reagent_containers/cup/glass/bottle/champagne/attack_self(mob/user)
	if(is_open_container())
		return ..()
	balloon_alert(user, "正在摆弄软木塞……")
	if(do_after(user, 1 SECONDS, src))
		return pop_cork(user, sabrage = FALSE, froth_severity = pick(0, 1))

/obj/item/reagent_containers/cup/glass/bottle/champagne/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(is_open_container())
		return NONE

	if(tool.get_sharpness() != SHARP_EDGED)
		return NONE

	if(tool != user.get_active_held_item()) //no TK allowed
		to_chat(user, span_userdanger("这种壮举超出了你的念力本领！"))
		return ITEM_INTERACT_BLOCKING

	if(tool.force < 5)
		balloon_alert(user, "力气不够！")
		return ITEM_INTERACT_BLOCKING

	playsound(user, 'sound/items/unsheath.ogg', 25, TRUE)
	balloon_alert(user, "准备挥砍……")
	if(!do_after(user, 2 SECONDS, src)) //takes longer because you are supposed to take the foil off the bottle first
		return ITEM_INTERACT_BLOCKING

	//The bonus to success chance that the user gets for being a command role
	var/obj/item/organ/liver/liver = user.get_organ_slot(ORGAN_SLOT_LIVER)
	var/command_bonus = (!isnull(liver) && HAS_TRAIT(liver, TRAIT_ROYAL_METABOLISM)) ? 20 : 0

	//The bonus to success chance that the user gets for having a sabrage skillchip installed/otherwise having the trait through other means
	var/skillchip_bonus = HAS_TRAIT(user, TRAIT_SABRAGE_PRO) ? 35 : 0
	//calculate success chance. example: captain's sabre - 15 force = 75% chance
	var/sabrage_chance = (tool.force * sabrage_success_percentile) + command_bonus + skillchip_bonus

	if(prob(sabrage_chance))
		///Severity of the resulting froth to pass to make_froth()
		var/severity_to_pass
		if(sabrage_chance > 100)
			severity_to_pass = 0
		else
			switch(sabrage_chance) //the less likely we were to succeed, the more of the drink will end up wasted in froth
				if(1 to 33)
					severity_to_pass = 3
				if(34 to 66)
					severity_to_pass = 2
				if(67 to 99)
					severity_to_pass = 1
		return pop_cork(user, sabrage = TRUE, froth_severity = severity_to_pass) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

	user.visible_message(
		span_danger("[user]挥刀开香槟时失手，将[src]劈成两半，洒了自己一身！"),
		span_danger("你表演失败，将[src]劈成两半，洒了自己一身！"),
		)
	user.add_mood_event("sabrage_fail", /datum/mood_event/sabrage_fail)
	return smash(target = user, break_top = TRUE) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

/obj/item/reagent_containers/cup/glass/bottle/champagne/update_icon_state()
	. = ..()
	if(is_open_container())
		if(sabraged)
			icon_state = "[base_icon_state]_sabrage"
		else
			icon_state = "[base_icon_state]_popped"
	else
		icon_state = base_icon_state

/obj/item/reagent_containers/cup/glass/bottle/champagne/proc/pop_cork(mob/living/user, sabrage, froth_severity)
	if(!sabrage)
		user.visible_message(
			span_danger("[user]松开[src]的软木塞，瓶塞猛地弹了出去。"),
			span_nicegreen("你优雅地松开[src]的软木塞，瓶塞猛地弹了出去。"),
			)
	else
		sabraged = TRUE
		user.visible_message(
			span_danger("[user]利落地削开[src]的软木塞，瓶塞猛地飞了出去。"),
			span_nicegreen("你优雅地削开[src]的软木塞，瓶塞猛地飞了出去。"),
			)
		for(var/mob/living/carbon/stunt_witness in view(7, user))
			stunt_witness.clear_mood_event("sabrage_success")
			if(stunt_witness == user)
				stunt_witness.add_mood_event("sabrage_success", /datum/mood_event/sabrage_success)
				continue
			stunt_witness.add_mood_event("sabrage_witness", /datum/mood_event/sabrage_witness)

	add_container_flags(OPENCONTAINER)
	playsound(src, 'sound/items/champagne_pop.ogg', 70, TRUE)
	update_appearance()
	make_froth(offset_x = 0, offset_y = sabraged ? 13 : 15, intensity = froth_severity) //the y offset for sabraged is lower because the bottle's lip is smashed
	///Type of cork to fire away
	var/obj/projectile/bullet/cork_to_fire = sabraged ? /obj/projectile/bullet/champagne_cork/sabrage : /obj/projectile/bullet/champagne_cork
	///Our resulting cork projectile
	var/obj/projectile/bullet/champagne_cork/popped_cork = new cork_to_fire (drop_location())
	popped_cork.firer = user
	popped_cork.fired_from = src
	popped_cork.fire(dir2angle(user.dir) + rand(-30, 30))
	return TRUE

/obj/projectile/bullet/champagne_cork
	name = "香槟软木塞"
	icon = 'icons/obj/drinks/drink_effects.dmi'
	icon_state = "champagne_cork"
	hitsound = 'sound/items/weapons/genhit.ogg'
	damage = 10
	sharpness = NONE
	impact_effect_type = null
	ricochets_max = 3
	ricochet_chance = 70
	ricochet_decay_damage = 1
	ricochet_incidence_leeway = 0
	range = 7
	knockdown = 2 SECONDS
	var/drop_type = /obj/item/trash/champagne_cork

/obj/projectile/bullet/champagne_cork/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/projectile_drop, drop_type)

/obj/projectile/bullet/champagne_cork/sabrage
	icon_state = "champagne_cork_sabrage"
	damage = 12
	ricochets_max = 2 //bit heavier
	range = 6
	drop_type = /obj/item/trash/champagne_cork/sabrage

/obj/item/trash/champagne_cork
	name = "香槟软木塞"
	icon = 'icons/obj/drinks/drink_effects.dmi'
	icon_state = "champagne_cork"

/obj/item/trash/champagne_cork/sabrage
	icon_state = "champagne_cork_sabrage"

/obj/item/reagent_containers/cup/glass/bottle/blazaam
	name = "金巴德闪现佳酿"
	desc = "你觉得开瓶前应该好好擦一擦瓶子。"
	icon_state = "blazaambottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/blazaam = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/trappist
	name = "鲨山修道院蓝标啤酒"
	desc = "比利时酿造，真讲究！" // DARKPACK EDIT CHANGE
	icon_state = "trappistbottle"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/ethanol/trappist = 50)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/hooch
	name = "劣酿酒瓶"
	desc = "一瓶劣酒，主人运用街头智慧，巧妙地用棕色纸袋伪装起来。"
	icon_state = "hoochbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/hooch = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/hooch/add_message_overlay()
	return //doesn't fit the sprite

/obj/item/reagent_containers/cup/glass/bottle/moonshine
	name = "私酿烈酒陶壶"
	desc = "据说古老的阿巴拉契亚人用这种粗陶壶将闪电装进瓶中。"
	icon_state = "moonshinebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/moonshine = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/moonshine/add_message_overlay()
	return //doesn't fit the sprite

/obj/item/reagent_containers/cup/glass/bottle/mushi_kombucha
	name = "索尔扎拉酿酒公司蘑菇康普茶"
	desc = "加冰饮用最能品出蘑菇风味。"
	icon_state = "shroomy_bottle"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/mushi_kombucha = 30)
	isGlass = FALSE
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/hakka_mate
	name = "黑客马黛"
	desc = "黑客马黛：喝惯了才懂。"
	icon_state = "hakka_mate_bottle"
	list_reagents = list(/datum/reagent/consumable/hakka_mate = 30)

/obj/item/reagent_containers/cup/glass/bottle/shochu
	name = "舒库巴纯烧酎"
	desc = "专供调酒的高酒精度烧酎，直接来自火星的尘土之城舒库巴。"
	icon_state = "shochu_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/shochu = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/yuyake
	name = "月劳夕烧"
	desc = "将迪斯科与喇叭裤的精髓蒸馏成酒，如同把闪电装入瓶中。"
	icon_state = "yuyake_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/yuyake = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/coconut_rum
	name = "微风浅滩椰子朗姆酒"
	desc = "微风浅滩，畅享轻松生活，仅用*最优质的加勒比朗姆酒调制。"
	icon_state = "coconut_rum_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/coconut_rum = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/aperitivo
	name = "卡米洛红色开胃酒"
	desc = "这瓶酒促成了现代卡米洛饮料集团的诞生。你最爱那款酒的生产商，很可能至少部分归卡米洛所有。"
	icon_state = "aperitivo_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/aperitivo = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/herbal_liqueur
	name = "贝拉尔米诺D.O.P草本利口酒"
	desc = "拥有近千年历史的草本利口酒，采用修士代代相传的秘方。其草药香料配方保密得比纳诺传讯核武库密码还严，这可不是什么好消息。"
	icon_state = "herbal_liqueur_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/herbal_liqueur = 100)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/maraschino
	name = "达尔马提亚原酿马拉斯奇诺樱桃利口酒"
	desc = "瓶后的小字提示，觉得樱桃味不够的顾客可以拨打所列号码投诉，那号码似乎早已停用。"
	icon_state = "maraschino_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/maraschino = 100)
	drink_type = ALCOHOL

////////////////////////// MOLOTOV ///////////////////////
/obj/item/reagent_containers/cup/glass/bottle/molotov
	name = "莫洛托夫燃烧瓶"
	desc = "通常装有助燃剂的投掷燃烧武器，深受暴乱者和革命者推荐。点燃后扔出。"
	icon_state = "vodkabottle"
	list_reagents = list()
	heatable = FALSE
	var/active = FALSE
	var/list/accelerants = list(
		/datum/reagent/consumable/ethanol,
		/datum/reagent/fuel,
		/datum/reagent/clf3,
		/datum/reagent/phlogiston,
		/datum/reagent/napalm,
		/datum/reagent/hellwater,
		/datum/reagent/toxin/plasma,
		/datum/reagent/toxin/spore_burning,
	)

/obj/item/reagent_containers/cup/glass/bottle/molotov/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	var/obj/item/reagent_containers/cup/glass/bottle/bottle = locate() in components
	if(!bottle)
		return ..()
	icon_state = bottle.icon_state
	bottle.reagents.trans_to(src, 100, copy_only = TRUE)
	if(istype(bottle, /obj/item/reagent_containers/cup/glass/bottle/juice))
		desc += " You're not sure if making this out of a carton was the brightest idea."
		isGlass = FALSE
	return ..()

/obj/item/reagent_containers/cup/glass/bottle/molotov/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum, do_splash = FALSE)
	..(hit_atom, throwingdatum, do_splash = FALSE)

/obj/item/reagent_containers/cup/glass/bottle/molotov/smash(atom/target, mob/thrower, datum/thrownthing/throwingdatum, break_top)
	var/firestarter = FALSE
	for(var/datum/reagent/contained_reagent in reagents.reagent_list)
		for(var/accelerant_type in accelerants)
			if(istype(contained_reagent, accelerant_type))
				firestarter = TRUE
				break
	..()
	if(firestarter && active)
		if(!QDELETED(target))
			target.fire_act()
		// DARKPACK EDIT CHANGE START - TURF_FIRE
		var/turf/the_turf = get_turf(target)
		the_turf.ignite_turf(30)
		new /obj/effect/hotspot(the_turf)
		// DARKPACK EDIT CHANGE END

/obj/item/reagent_containers/cup/glass/bottle/molotov/item_interaction(mob/living/user, obj/item/item, list/modifiers)
	if(item.get_temperature() < FIRE_MINIMUM_TEMPERATURE_TO_EXIST || active)
		return NONE

	active = TRUE
	log_bomber(user, "has primed a", src, "for detonation")

	to_chat(user, span_info("你点燃了[src]。"))
	add_overlay(custom_fire_overlay() || GLOB.fire_overlay)
	if(!isGlass)
		addtimer(CALLBACK(src, PROC_REF(explode)), 5 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/glass/bottle/molotov/proc/explode()
	if(!active)
		return
	if(get_turf(src))
		var/atom/target = loc
		for(var/i in 1 to 2)
			if(istype(target, /obj/item/storage))
				target = target.loc
		splash_reagents(target, allow_closed_splash = TRUE)
		target.fire_act()
	qdel(src)

/obj/item/reagent_containers/cup/glass/bottle/molotov/attack_self(mob/user)
	if(active)
		if(!isGlass)
			to_chat(user, span_danger("火势已经蔓延得太大了！"))
			return
		to_chat(user, span_info("你熄灭了[src]上的火焰。"))
		cut_overlay(custom_fire_overlay() || GLOB.fire_overlay)
		active = FALSE
		return
	return ..()

/obj/item/reagent_containers/cup/glass/bottle/pruno
	name = "狱酿果酒原浆"
	desc = "装满水果、糖、酵母和水的垃圾袋，捣成刺鼻浆液后放在封闭空间发酵，传统上就用马桶。警察很爱没收这东西，这也是他们的诸多毛病之一。" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/service/janitor.dmi'
	icon_state = "trashbag"
	list_reagents = list(/datum/reagent/consumable/prunomix = 50)
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	var/fermentation_time = 30 SECONDS /// time it takes to ferment
	var/fermentation_time_remaining /// for partial fermentation
	var/fermentation_timer /// store the timer id of fermentation

/obj/item/reagent_containers/cup/glass/bottle/pruno/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(check_fermentation))

/obj/item/reagent_containers/cup/glass/bottle/pruno/Destroy()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	return ..()

// Checks to see if the pruno can ferment, i.e. is it inside a structure (e.g. toilet), or a machine (e.g. washer)?
// TODO: make it so the washer spills reagents if a reagent container is in there, for now, you can wash pruno

/obj/item/reagent_containers/cup/glass/bottle/pruno/proc/check_fermentation()
	SIGNAL_HANDLER
	if (!(ismachinery(loc) || isstructure(loc)))
		if(fermentation_timer)
			fermentation_time_remaining = timeleft(fermentation_timer)
			deltimer(fermentation_timer)
			fermentation_timer = null
		return
	if(fermentation_timer)
		return
	if(!fermentation_time_remaining)
		fermentation_time_remaining = fermentation_time
	fermentation_timer = addtimer(CALLBACK(src, PROC_REF(do_fermentation)), fermentation_time_remaining, TIMER_UNIQUE|TIMER_STOPPABLE)
	fermentation_time_remaining = null

// actually ferment

/obj/item/reagent_containers/cup/glass/bottle/pruno/proc/do_fermentation()
	fermentation_time_remaining = null
	fermentation_timer = null
	reagents.remove_reagent(/datum/reagent/consumable/prunomix, 50)
	if(prob(10))
		reagents.add_reagent(/datum/reagent/toxin/bad_food, 15) // closest thing we have to botulism
		reagents.add_reagent(/datum/reagent/consumable/ethanol/pruno, 35)
	else
		reagents.add_reagent(/datum/reagent/consumable/ethanol/pruno, 50)
	name = "袋装狱酿果酒"
	desc = "用水果、糖和绝望发酵的监狱果酒，最好别在安保面前喝。"
	icon_state = "trashbag1" // pruno releases air as it ferments, we don't want to simulate this in atmos, but we can make it look like it did
	for (var/mob/living/M in view(2, get_turf(src))) // letting people and/or narcs know when the pruno is done
		if(HAS_TRAIT(M, TRAIT_ANOSMIA))
			to_chat(M, span_info("[src]散发出刺鼻气味，仿佛水果把内脏都吐了出来。"))
		playsound(get_turf(src), 'sound/effects/bubbles/bubbles2.ogg', 25, TRUE)

/**
 * Cartons
 * Subtype of glass that don't break, and share a common carton hand state.
 * Meant to be a subtype for use in Molotovs
 */
/obj/item/reagent_containers/cup/glass/bottle/juice
	custom_price = PAYCHECK_CREW
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	isGlass = FALSE
	age_restricted = FALSE
	custom_materials = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT * 1.5)

/obj/item/reagent_containers/cup/glass/bottle/juice/orangejuice
	name = "橙汁"
	desc = "满满的维生素和美味！"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "orangejuice"
	list_reagents = list(/datum/reagent/consumable/orangejuice = 100)
	drink_type = FRUIT | BREAKFAST

/obj/item/reagent_containers/cup/glass/bottle/juice/lemonjuice
	name = "柠檬汁"
	desc = "有人喜欢在鱼上滴几滴。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "lemonjuice"
	list_reagents = list(/datum/reagent/consumable/lemonjuice = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/juice/cream
	name = "奶油"
	desc = "就是奶油，用牛奶做的。你还以为里面能有什么？"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "cream"
	list_reagents = list(/datum/reagent/consumable/cream = 100)
	drink_type = DAIRY
	custom_price = 5 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/cup/glass/bottle/juice/eggnog
	name = "蛋奶酒"
	desc = "享受一年中最美好的时光。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "nog2"
	list_reagents = list(/datum/reagent/consumable/ethanol/eggnog = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/juice/dreadnog
	name = "蛋奶酒"
	desc = "适合想往蛋奶酒里兑点不知名汽水的人！"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "dreadnog"
	list_reagents = list(/datum/reagent/consumable/ethanol/dreadnog = 100)
	drink_type = FRUIT | GROSS

/obj/item/reagent_containers/cup/glass/bottle/juice/tomatojuice
	name = "番茄汁"
	desc = "至少看起来像番茄汁。红成这样，实在分辨不出来。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "tomatojuice"
	list_reagents = list(/datum/reagent/consumable/tomatojuice = 100)
	drink_type = VEGETABLES

/obj/item/reagent_containers/cup/glass/bottle/juice/limejuice
	name = "青柠汁"
	desc = "酸甜好滋味。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "limejuice"
	list_reagents = list(/datum/reagent/consumable/limejuice = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/juice/pineapplejuice
	name = "菠萝汁"
	desc = "极酸的黄色果汁。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "pineapplejuice"
	list_reagents = list(/datum/reagent/consumable/pineapplejuice = 100)
	drink_type = FRUIT | PINEAPPLE

/obj/item/reagent_containers/cup/glass/bottle/juice/menthol
	name = "薄荷醇"
	desc = "天然薄荷味，带来非常轻微的麻木感。"
	list_reagents = list(/datum/reagent/consumable/menthol = 100)
	age_restricted = TRUE

#undef BOTTLE_KNOCKDOWN_DEFAULT_DURATION
