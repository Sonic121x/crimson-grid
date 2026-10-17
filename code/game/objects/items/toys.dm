/* Toys!
 * Contains
 * Balloons
 * Captain's Aid
 * Fake singularity
 * Toy gun
 * Toy swords
 * Crayons
 * Snap pops
 * AI core prizes
 * Toy codex gigas
 * Skeleton toys
 * Toy nuke
 * Fake meteor
 * Foam armblade
 * Toy big red button
 * Beach ball
 * Toy xeno
 * Kitty toys!
 * Snowballs
 * Clockwork Watches
 * Toy Daggers
 * Squeaky Brain
 * Broken Radio
 * Fake heretic codex
 * Fake Pierced Reality
 * Intento
 * Extendo hand
 * Ban hammer
 */
/obj/item/toy
	abstract_type = /obj/item/toy
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	force = 0
	worn_icon_state = "nothing"

	/// Can this toy be placed on the floor?
	var/floor_placeable = FALSE

/obj/item/toy/Initialize(mapload)
	. = ..()
	if(floor_placeable)
		AddElement(/datum/element/floor_placeable)

/*
 * Balloons
 */
/obj/item/toy/waterballoon
	name = "水气球"
	desc = "一个半透明气球，里面空空如也。"
	icon = 'icons/obj/toys/balloons.dmi'
	icon_state = "balloon_red-e"
	inhand_icon_state = "balloon-empty"
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/toy/waterballoon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	create_reagents(10)

/obj/item/toy/waterballoon/attack(mob/living/carbon/human/M, mob/user)
	return

/obj/item/toy/waterballoon/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if (!istype(interacting_with, /obj/structure/reagent_dispensers))
		return NONE
	var/obj/structure/reagent_dispensers/RD = interacting_with
	if(RD.reagents.total_volume <= 0)
		to_chat(user, span_warning("[RD]已经空了。"))
	else if(reagents.total_volume >= 10)
		to_chat(user, span_warning("[src]已经满了。"))
	else
		interacting_with.reagents.trans_to(src, 10, transferred_by = user)
		to_chat(user, span_notice("你将[interacting_with]的内容物灌入气球。"))
		desc = "一个半透明气球，里面晃荡着某种液体。"
		update_appearance()
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/toy/waterballoon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/reagent_containers/cup) && tool.reagents)
		if(tool.reagents.total_volume <= 0)
			to_chat(user, span_warning("[tool]已经空了。"))
			return ITEM_INTERACT_BLOCKING

		if(reagents.total_volume >= 10)
			to_chat(user, span_warning("[src]已经满了。"))
			return ITEM_INTERACT_BLOCKING

		desc = "一个半透明气球，里面晃荡着某种液体。"
		to_chat(user, span_notice("你将[tool]的内容物灌入气球。"))
		tool.reagents.trans_to(src, 10, transferred_by = user)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(tool.get_sharpness())
		balloon_burst()
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/toy/waterballoon/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		balloon_burst(hit_atom)

/obj/item/toy/waterballoon/proc/balloon_burst(atom/AT)
	if(reagents.total_volume >= 1)
		var/turf/T
		if(AT)
			T = get_turf(AT)
		else
			T = get_turf(src)
		T.visible_message(span_danger("[src]爆开了！"),span_hear("你听到了砰的一声，随后是液体泼溅声。"))
		reagents.expose(T)
		for(var/atom/A in T)
			reagents.expose(A)
		icon_state = "burst"
		qdel(src)

/obj/item/toy/waterballoon/update_icon_state()
	if(reagents.total_volume >= 1)
		icon_state = "waterballoon"
		inhand_icon_state = "balloon"
	else
		icon_state = "balloon_red-e"
		inhand_icon_state = "balloon-empty"
	return ..()

#define BALLOON_COLORS list("red", "blue", "green", "yellow", "orange", "purple")

/obj/item/toy/balloon
	name = "气球"
	desc = "生日少了它可不完整。采用机械蓝空间封膜，无论如何都会保持漂浮。"
	icon = 'icons/obj/toys/balloons.dmi'
	icon_state = "balloon"
	inhand_icon_state = "balloon"
	lefthand_file = 'icons/mob/inhands/items/balloons_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/balloons_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	force = 0
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 0.6)
	var/random_color = TRUE
	/// the string describing the name of balloon's current colour.
	var/current_color

/obj/item/toy/balloon/long
	name = "长气球"
	desc = "非常适合扭成各种滑稽造型的气球。采用机械蓝空间封膜，无论如何都会保持漂浮。"
	icon_state = "balloon_long"
	inhand_icon_state = "balloon"
	w_class = WEIGHT_CLASS_NORMAL
	/// Combinations of balloon colours to make specific animals.
	var/list/balloon_combos = list(
		list("red", "blue") = /obj/item/toy/balloon_animal/guy,
		list("red", "green") = /obj/item/toy/balloon_animal/nukie,
		list("red", "yellow") = /obj/item/toy/balloon_animal/clown,
		list("red", "orange") = /obj/item/toy/balloon_animal/cat,
		list("red", "purple") = /obj/item/toy/balloon_animal/fly,
		list("blue", "green") = /obj/item/toy/balloon_animal/podguy,
		list("blue", "yellow") = /obj/item/toy/balloon_animal/ai,
		list("blue", "orange") = /obj/item/toy/balloon_animal/dog,
		list("blue", "purple") = /obj/item/toy/balloon_animal/xeno,
		list("green", "yellow") = /obj/item/toy/balloon_animal/banana,
		list("green", "orange") = /obj/item/toy/balloon_animal/lizard,
		list("green", "purple") = /obj/item/toy/balloon_animal/slime,
		list("yellow", "orange") = /obj/item/toy/balloon_animal/moth,
		list("yellow", "purple") = /obj/item/toy/balloon_animal/ethereal,
		list("orange", "purple") = /obj/item/toy/balloon_animal/plasmaman,
	)


/obj/item/toy/balloon/long/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/balloon/long) || !HAS_TRAIT(user, TRAIT_BALLOON_SUTRA))
		return ..()

	var/obj/item/toy/balloon/long/hit_by = tool
	if(hit_by.current_color == current_color)
		to_chat(user, span_warning("必须使用不同颜色的气球才行！"))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(
		span_notice("[user.name]开始扭制气球动物！"),
		span_notice("你开始将气球扭成动物造型！"),
		span_hear("你听到了气球被扭动的声音。"),
		vision_distance = 3,
		ignored_mobs = user,
	)
	for(var/list/pair_of_colors in balloon_combos)
		if((hit_by.current_color == pair_of_colors[1] && current_color == pair_of_colors[2]) || (current_color == pair_of_colors[1] && hit_by.current_color == pair_of_colors[2]))
			var/path_to_spawn = balloon_combos[pair_of_colors]
			user.put_in_hands(new path_to_spawn)
			break
	qdel(hit_by)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/balloon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/ammo_casing/foam_dart) || !HAS_TRAIT(user, TRAIT_SIMIAN))
		return NONE
	pop_balloon(monkey_pop = TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/balloon/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	var/mob/thrower = throwingdatum?.get_thrower()
	if(HAS_TRAIT(thrower, TRAIT_SIMIAN) && istype(AM, /obj/item/ammo_casing/foam_dart))
		pop_balloon(monkey_pop = TRUE)
	else
		return ..()

/obj/item/toy/balloon/bullet_act(obj/projectile/proj)
	if((istype(proj, /obj/projectile/bullet/p50) || istype(proj,/obj/projectile/bullet/foam_dart)) && HAS_TRAIT(proj.firer, TRAIT_SIMIAN))
		pop_balloon(monkey_pop = TRUE)
		return BULLET_ACT_HIT
	return ..()

/obj/item/toy/balloon/proc/pop_balloon(monkey_pop = FALSE)
	playsound(src, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 50, vary = TRUE)
	if(monkey_pop) // Monkeys make money from popping bloons
		new /obj/item/coin/iron(get_turf(src))
	qdel(src)

/obj/item/toy/balloon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(!random_color)
		return
	current_color = pick(BALLOON_COLORS)
	update_appearance()

/obj/item/toy/balloon/update_name(updates)
	. = ..()
	name = "[current_color ? "[list("red" = "红色", "blue" = "蓝色", "green" = "绿色", "yellow" = "黄色", "orange" = "橙色", "purple" = "紫色")[current_color] || current_color]":null][initial(name)]"

/obj/item/toy/balloon/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, current_color))
		update_appearance()

/obj/item/toy/balloon/update_icon_state()
	. = ..()
	var/new_icon = "[initial(icon_state)][current_color ? "_[current_color]":null]"
	inhand_icon_state = new_icon
	icon_state = "[new_icon][isturf(loc) ? null : "_storage"]"

/obj/item/toy/balloon/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	update_appearance()

/obj/item/toy/balloon/corgi
	name = "柯基气球"
	desc = "一个柯基头形状的气球，献给全年乖巧的好狗狗。"
	icon_state = "corgi"
	inhand_icon_state = "corgi"
	random_color = FALSE

/obj/item/toy/balloon/heart
	name = "爱心气球"
	desc = "一个心形气球，多么可爱。"
	icon_state = "heart"
	inhand_icon_state = "heart"
	random_color = FALSE

/obj/item/toy/balloon/syndicate
	name = "辛迪加气球"
	desc = "背面的标签上写着\"去他妈的纳诺传讯！11！\"。"
	icon_state = "syndballoon"
	inhand_icon_state = "syndballoon"
	random_color = FALSE

/obj/item/toy/balloon/syndicate/pickup(mob/living/user)
	. = ..()
	if(user && user.mind && user.mind.has_antag_datum(/datum/antagonist, TRUE))
		user.add_mood_event("badass_antag", /datum/mood_event/badass_antag)

/obj/item/toy/balloon/syndicate/dropped(mob/living/user)
	if(user)
		user.clear_mood_event("badass_antag")
	. = ..()

/obj/item/toy/balloon/syndicate/Destroy()
	if(ismob(loc))
		var/mob/living/M = loc
		M.clear_mood_event("badass_antag")
	. = ..()

/obj/item/toy/balloon/arrest
	name = "阿雷斯特气球"
	desc = "一个只充了一半气的气球，印着约十年前走红的男团阿雷斯特。他们以嘲笑红色连身服不时髦而闻名。"
	icon_state = "arrestballoon"
	inhand_icon_state = "arrestballoon"
	random_color = FALSE

#undef BALLOON_COLORS

/*
* Balloon animals
*/

/obj/item/toy/balloon_animal
	name = "balloon animal"
	desc = "You shouldn't have this."
	icon = 'icons/obj/toys/balloons.dmi'
	inhand_icon_state = "balloon"
	lefthand_file = 'icons/mob/inhands/items/balloons_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/balloons_righthand.dmi'
	abstract_type = /obj/item/toy/balloon_animal
	throwforce = 0
	throw_speed = 2
	throw_range = 5
	force = 0
	floor_placeable = TRUE

/obj/item/toy/balloon_animal/guy
	name = "气球人"
	desc = "一个普普通通、标准款人类的气球造型。不知道他交不交气球税，多半在逃税吧。"
	icon_state = "balloon_guy"

/obj/item/toy/balloon_animal/nukie
	name = "气球核特工"
	desc = "辛迪加核特工的气球造型。做它的人要么想讨好特工求条活路，要么就是想嘲弄他们。"
	icon_state = "balloon_nukie"

/obj/item/toy/balloon_animal/clown
	name = "气球小丑"
	desc = "一个气球小丑，笑容从一只耳朵咧到另一只，还不止呢！"
	icon_state = "balloon_clown"

/obj/item/toy/balloon_animal/cat
	name = "气球猫"
	desc = "没有锋利爪子的气球猫也许比真猫更可爱，只是没那么亲切、温暖和毛茸茸。"
	icon_state = "balloon_cat"

/obj/item/toy/balloon_animal/fly
	name = "气球苍蝇人"
	desc = "苍蝇人的气球造型。谢天谢地，不附带气球呕吐物。"
	icon_state = "balloon_fly"

/obj/item/toy/balloon_animal/podguy
	name = "气球荚人"
	desc = "荚人的气球造型。不过真正的荚人长着脑袋，而非茎秆和叶子。"
	icon_state = "balloon_podguy"

/obj/item/toy/balloon_animal/ai
	name = "气球AI核心"
	desc = "一个不太逼真的空间站AI核心气球造型。真正的AI大概不会笑成这样。"
	icon_state = "balloon_ai"

/obj/item/toy/balloon_animal/dog
	name = "气球狗"
	desc = "最乖狗狗的气球造型。虽说无法真正相比，但它已经很努力了。"
	icon_state = "balloon_dog"

/obj/item/toy/balloon_animal/xeno
	name = "气球异形"
	desc = "吓人异形的气球造型！不过本身太软了，吓不到谁。"
	icon_state = "balloon_xeno"

/obj/item/toy/balloon_animal/banana
	name = "气球香蕉"
	desc = "一根气球香蕉，不会把人滑倒。不过很适合心理战。"
	icon_state = "balloon_banana"

/obj/item/toy/balloon_animal/lizard
	name = "气球蜥蜴人"
	desc = "蜥蜴人的气球造型。他们是最早适应小丑星文化的物种之一，也许因为天生就很可笑？"
	icon_state = "balloon_lizard"

/obj/item/toy/balloon_animal/slime
	name = "气球史莱姆"
	desc = "肆虐银河的史莱姆之一，紫色品种的气球造型。史莱姆曾试图入侵小丑星，结果很快就被喷水花冲走了。"
	icon_state = "balloon_slime"

/obj/item/toy/balloon_animal/moth
	name = "气球蛾人"
	desc = "蛾人船队普通成员的气球造型。他们很少定居小丑星，但留下来的总有最精彩的'布料消失'表演。"
	icon_state = "balloon_moth"

/obj/item/toy/balloon_animal/ethereal
	name = "气球以太人"
	desc = "以太人工匠的气球造型。小丑表演也是艺术，所以以太人既向往小丑星，也在那里很受欢迎。别在意灯泡脑袋，那也是艺术。"
	icon_state = "balloon_ethereal"

/obj/item/toy/balloon_animal/plasmaman
	name = "气球等离子人"
	desc = "等离子人的气球造型，是小丑星上最罕见的种类之一，直到最近小丑星与纳诺传讯贸易便利后才出现。"
	icon_state = "balloon_plasmaman"


/*
* Captain's Aid
*/
#define CAPTAINSAID_MODE_OFF 1

/obj/item/toy/captainsaid
	name = "\improper 站长好帮手"
	desc = "每位站长探索浩瀚虚空时的最佳伙伴，如今配备彩色显示屏！"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "captainsaid_off"
	custom_price = PAYCHECK_COMMAND * 1.25

	/// List of modes it can cycle through
	var/list/modes = list(
		"off",
		"port",
		"starboard",
		"fore",
		"aft",
	)
	/// Current mode of the item, changed when cycling through modes
	var/current_mode = CAPTAINSAID_MODE_OFF

/obj/item/toy/captainsaid/examine_more(mob/user)
	. = ..()
	. += span_notice("你敢发誓，那个平板版'即将推出'的广告，你已经听了快三年了……")

/obj/item/toy/captainsaid/attack_self(mob/living/user)
	current_mode++
	playsound(src, 'sound/items/tools/screwdriver2.ogg', 50, vary = TRUE)
	if (current_mode <= modes.len)
		balloon_alert(user, "已设为模式[current_mode]")
	else
		balloon_alert(user, "已关闭")
		current_mode = CAPTAINSAID_MODE_OFF
	icon_state = "captainsaid_[modes[current_mode]]"
	update_appearance(UPDATE_ICON)

#undef CAPTAINSAID_MODE_OFF

/obj/item/toy/captainsaid/collector
	name = "\improper 典藏版站长好帮手"
	desc = "站长好帮手最初发行批次的一件产品。功能和后来批次一样，只是更贵。献给真正的贵族。"

/*
 * Fake singularity
 */
/obj/item/toy/spinningtoy
	name = "引力奇点"
	desc = "\"奇点\"牌旋转玩具。"
	icon = 'icons/obj/machines/engine/singularity.dmi'
	icon_state = "singularity_s1"
	item_flags = NO_PIXEL_RANDOM_DROP

/obj/item/toy/spinningtoy/suicide_act(mob/living/user)
	if (!iscarbon(user))
		user.visible_message(span_suicide("[user]吞下了[src]！看起来是想自杀！"))
		user.spin(8 SECONDS, 1)
		return BRUTELOSS
	var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
	if(!myhead)
		user.visible_message(span_suicide("[user]试图吞下[src]……可根本没有嘴！")) // and i must scream
		return SHAME
	user.visible_message(span_suicide("[user]吞下了[src]！看起来是想自杀！"))
	playsound(user, 'sound/items/eatfood.ogg', 50, TRUE)
	user.adjust_nutrition(50) // mmmm delicious
	addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), (3 SECONDS))
	return MANUAL_SUICIDE

/**
 * Internal function used in the toy singularity suicide
 *
 * Cavity implants the toy singularity into the body of the user (arg1), and kills the user.
 * Makes the user vomit and receive 120 suffocation damage if there already is a cavity implant in the user.
 * Throwing the singularity away will cause the user to start choking themself to death.
 * Arguments:
 * * user - Whoever is doing the suiciding
 */
/obj/item/toy/spinningtoy/proc/manual_suicide(mob/living/carbon/human/user)
	if(!user)
		return
	if(!user.is_holding(src)) // Half digestion? Start choking to death
		user.visible_message(span_suicide("[user]惊慌失措，开始把自己掐死！"))
		user.adjust_oxy_loss(200)
		user.death(FALSE) // unfortunately you have to handle the suiciding yourself with a manual suicide
		user.ghostize(FALSE) // get the fuck out of our body
		return
	var/obj/item/bodypart/chest/CH = user.get_bodypart(BODY_ZONE_CHEST)
	if(CH.cavity_item) // if he's (un)bright enough to have a round and full belly...
		user.visible_message(span_danger("[user]把[src]吐了出来！")) // I swear i dont have a fetish
		user.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 100, distance = 0)
		user.adjust_oxy_loss(120)
		user.dropItemToGround(src) // incase the crit state doesn't drop the singulo to the floor
		user.set_suicide(FALSE)
		return
	user.transferItemToLoc(src, user, TRUE)
	CH.cavity_item = src // The mother came inside and found Andy, dead with a HUGE belly full of toys
	user.adjust_oxy_loss(200) // You know how most small toys in the EU have that 3+ onion head icon and a warning that says "Unsuitable for children under 3 years of age due to small parts - choking hazard"? This is why.
	user.death(FALSE)
	user.ghostize(FALSE)

/*
 * Fake dark matter singularity!
 */
/obj/item/toy/spinningtoy/dark_matter
	name = "暗物质奇点"
	desc = "<i>\"从那可怕之物面前\
		侥幸活下来后，我立刻意识到\
		自己该做什么：拿它做成畅销玩具来卖。\
		\"</i><br>——总工程师中村天心"
	icon = 'icons/obj/machines/engine/singularity.dmi'
	icon_state = "dark_matter_s1"

/*
 * Toy gun: Why isn't this an /obj/item/gun?
 */
/obj/item/toy/gun
	name = "火药纸玩具枪"
	desc = "看起来几乎跟真枪一样！适合8岁以上人士。火药纸用完后，请放入自动车床回收。"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "revolver"
	inhand_icon_state = "gun"
	worn_icon_state = "gun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT)
	attack_verb_continuous = list("击打", "枪柄砸击", "打击", "猛砸")
	attack_verb_simple = list("击打", "枪柄砸击", "打击", "猛砸")
	var/bullets = 7

/obj/item/toy/gun/examine(mob/user)
	. = ..()
	. += "还剩[bullets]发火药纸。"

/obj/item/toy/gun/item_interaction(mob/living/user, obj/item/tool, list/modifiers)

	if(!istype(tool, /obj/item/toy/ammo/gun))
		return NONE
	var/obj/item/toy/ammo/gun/ammunition = tool
	if (bullets >= 7)
		to_chat(user, span_warning("已经装满了！"))
		return ITEM_INTERACT_BLOCKING
	if (ammunition.amount_left <= 0)
		to_chat(user, span_warning("没有火药纸了！"))
		return ITEM_INTERACT_BLOCKING
	if (ammunition.amount_left < (7 - bullets))
		bullets += ammunition.amount_left
		to_chat(user, span_notice("你装入了[ammunition.amount_left]发火药纸。"))
		ammunition.amount_left = 0
	else
		to_chat(user, span_notice("你装入了[7 - bullets]发火药纸。"))
		ammunition.amount_left -= 7 - bullets
		bullets = 7
	tool.update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/gun/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ISADVANCEDTOOLUSER(user))
		to_chat(user, span_warning("你的动作不够灵巧，做不到！"))
		return ITEM_INTERACT_BLOCKING
	add_fingerprint(user)
	if (bullets < 1)
		user.show_message(span_warning("*咔嗒*"), MSG_AUDIBLE)
		playsound(src, 'sound/items/weapons/gun/revolver/dry_fire.ogg', 30, TRUE)
		return ITEM_INTERACT_SUCCESS
	playsound(user, 'sound/items/weapons/gun/revolver/shot.ogg', 100, TRUE)
	bullets--
	user.visible_message(span_danger("[user]用[src]朝[interacting_with]开火！"), \
		span_danger("你用[src]朝[interacting_with]开火！"), \
		span_hear("你听到了一声枪响！"))
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/ammo
	abstract_type = /obj/item/toy/ammo

/obj/item/toy/ammo/gun
	name = "玩具枪火药纸"
	desc = "用空后，记得将盒子放入自动车床回收。"
	icon = 'icons/obj/weapons/guns/ammo.dmi'
	icon_state = "357OLD-7"
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 3)
	var/amount_left = 7

/obj/item/toy/ammo/gun/update_icon_state()
	icon_state = "357OLD-[amount_left]"
	return ..()

/obj/item/toy/ammo/gun/examine(mob/user)
	. = ..()
	. += "还剩[amount_left]发火药纸。"

/*
 * Toy swords
 */
/obj/item/toy/sword
	name = "玩具剑"
	desc = "能量剑的廉价塑料仿制品。音效逼真！适合8岁及以上儿童。"
	icon_state = "e_sword"
	inhand_icon_state = "e_sword"
	icon_angle = -45
	icon = 'icons/obj/weapons/transforming_energy.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("攻击", "击打", "打击")
	attack_verb_simple = list("攻击", "击打", "打击")
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.1, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.1)
	/// Whether our sword has been multitooled to rainbow
	var/hacked = FALSE
	/// The color of our fake energy sword
	var/saber_color = "blue"

/obj/item/toy/sword/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		throw_speed_on = throw_speed, \
		hitsound_on = hitsound, \
		clumsy_check = FALSE, \
		inhand_icon_change = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	AddElement(/datum/element/update_icon_updates_onmob)

	var/static/list/tool_behaviors = list(
		TOOL_SCREWDRIVER = list(
			SCREENTIP_CONTEXT_LMB = "Change blade color"
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Updates our icon to have the correct color, and give some feedback.
 */
/obj/item/toy/sword/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(user)
		balloon_alert(user, "[active ? "弹出":"收起"][src]")

	playsound(src, active ? 'sound/items/weapons/saberon.ogg' : 'sound/items/weapons/saberoff.ogg', 20, TRUE)
	update_appearance(UPDATE_ICON)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/toy/sword/examine(mob/user)
	. = ..()
	. += span_notice("灯光旋钮目前设为[list("red" = "红色", "blue" = "蓝色", "green" = "绿色", "purple" = "紫色", "rainbow" = "彩虹色")[saber_color] || saber_color]，似乎能用<b>螺丝刀</b>转动。")

/obj/item/toy/sword/screwdriver_act(mob/living/user, obj/item/tool)
	switch(saber_color)
		if("red")
			saber_color = "blue"
		if("blue")
			saber_color = "green"
		if("green")
			saber_color = "purple"
		if("purple")
			saber_color = "red"
		else
			return ITEM_INTERACT_SUCCESS
	balloon_alert(user, "已改为[list("red" = "红色", "blue" = "蓝色", "green" = "绿色", "purple" = "紫色")[saber_color] || saber_color]")
	update_appearance(UPDATE_ICON)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/sword/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, saber_color))
		update_appearance(UPDATE_ICON)

/obj/item/toy/sword/update_icon_state()
	. = ..()
	var/last_part = HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) ? "_on[saber_color ? "_[saber_color]" : null]" : null
	icon_state = "[initial(icon_state)][last_part]"
	inhand_icon_state = "[initial(inhand_icon_state)][last_part]"

/obj/item/toy/sword/multitool_act(mob/living/user, obj/item/tool)
	if(hacked)
		to_chat(user, span_warning("已经够绚丽了！"))
		return
	hacked = TRUE
	saber_color = "rainbow"
	to_chat(user, span_warning("彩虹模式启动"))
	update_appearance(UPDATE_ICON)

/obj/item/toy/sword/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/sword))
		return NONE
	var/obj/item/toy/sword/attatched_sword = tool
	if(HAS_TRAIT(tool, TRAIT_NODROP))
		to_chat(user, span_warning("[tool]粘在你手上了，无法把它装到[src]上！"))
		return ITEM_INTERACT_BLOCKING
	if(HAS_TRAIT(src, TRAIT_NODROP))
		to_chat(user, span_warning("[src]粘在你手上了，无法把它装到[tool]上！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把两把塑料剑的尾部接在一起，做成了一把双刃玩具剑！你可真会装酷。"))
	var/obj/item/dualsaber/toy/new_saber = new /obj/item/dualsaber/toy(user.loc)
	if(attatched_sword.hacked || hacked)
		new_saber.hacked = TRUE
		new_saber.saber_color = "rainbow"
	qdel(tool)
	qdel(src)
	user.put_in_hands(new_saber)
	return ITEM_INTERACT_SUCCESS

/*
 * Foam armblade
 */
/obj/item/toy/foamblade
	name = "泡沫臂刃"
	desc = "上面写着\"艉区异形头号粉丝\"。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "foamblade"
	inhand_icon_state = "arm_blade"
	icon_angle = -180
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	attack_verb_continuous = list("刺扎", "吸收", "戳刺")
	attack_verb_simple = list("刺扎", "吸收", "戳刺")
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/obj/item/toy/windup_toolbox
	name = "发条工具箱"
	desc = "拧动钥匙后会隆隆作响的仿制工具箱。"
	icon = 'icons/obj/storage/toolbox.dmi'
	icon_state = "green"
	inhand_icon_state = "toolbox_green"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	hitsound = 'sound/items/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	attack_verb_continuous = list("狠揍")
	attack_verb_simple = list("狠揍")
	var/active = FALSE

/obj/item/toy/windup_toolbox/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/toy/windup_toolbox/update_overlays()
	. = ..()
	if(active)
		. += "single_latch_open"
	else
		. += "single_latch"

/obj/item/toy/windup_toolbox/attack_self(mob/user)
	if(!active)
		to_chat(user, span_notice("你给[src]上紧发条，它开始隆隆作响。"))
		active = TRUE
		update_appearance()
		playsound(src, 'sound/effects/pope_entry.ogg', 100)
		Rumble()
		addtimer(CALLBACK(src, PROC_REF(stopRumble)), 60 SECONDS)
	else
		to_chat(user, span_warning("[src]已经启动了！"))

/obj/item/toy/windup_toolbox/proc/Rumble()
	var/static/list/transforms
	if(!transforms)
		var/matrix/M1 = matrix()
		var/matrix/M2 = matrix()
		var/matrix/M3 = matrix()
		var/matrix/M4 = matrix()
		M1.Translate(-1, 0)
		M2.Translate(0, 1)
		M3.Translate(1, 0)
		M4.Translate(0, -1)
		transforms = list(M1, M2, M3, M4)
	animate(src, transform=transforms[1], time=0.2, loop=-1)
	animate(transform=transforms[2], time=0.1)
	animate(transform=transforms[3], time=0.2)
	animate(transform=transforms[4], time=0.3)

/obj/item/toy/windup_toolbox/proc/stopRumble()
	active = FALSE
	update_appearance()
	visible_message(span_warning("[src]的响动逐渐停歇，静了下来，箱扣啪地合上。")) //subtle difference
	playsound(loc, 'sound/items/weapons/batonextend.ogg', 100, TRUE)
	animate(src, transform = matrix())

/*
 * Subtype of Double-Bladed Energy Swords
 */
/obj/item/dualsaber/toy
	name = "双刃玩具剑"
	desc = "两把能量剑的廉价塑料仿制品。双倍快乐！"
	force = 0
	throwforce = 0
	throw_speed = 3
	throw_range = 5
	two_hand_force = 0
	attack_verb_continuous = list("攻击", "击打", "打击")
	attack_verb_simple = list("攻击", "击打", "打击")

/obj/item/dualsaber/toy/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	return 0

/obj/item/dualsaber/toy/IsReflect() //Stops Toy Dualsabers from reflecting energy projectiles
	return 0

/obj/item/dualsaber/toy/impale(mob/living/user)//Stops Toy Dualsabers from injuring clowns
	to_chat(user, span_warning("你转了几圈，随后失去平衡，把自己戳在了[src]上。"))
	user.adjust_stamina_loss(25)

/obj/item/toy/katana
	name = "仿制武士刀"
	desc = "在D20规则中弱得令人悲伤。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "katana"
	inhand_icon_state = "katana"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("攻击", "劈砍", "切削")
	attack_verb_simple = list("攻击", "劈砍", "切削")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	var/list/alt_continuous = list("刺击", "穿刺", "贯穿")
	var/list/alt_simple = list("刺击", "穿刺", "贯穿")

/obj/item/toy/katana/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)

/*
 * Snap pops
 */
/obj/item/toy/snappop
	name = "摔炮"
	desc = "哇！"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "snappop"
	w_class = WEIGHT_CLASS_TINY
	var/ash_type = /obj/effect/decal/cleanable/ash

/obj/item/toy/snappop/proc/pop_burst(n = 3, c = TRUE)
	do_sparks(n, c, src)
	new ash_type(loc)
	visible_message(span_warning("[src]炸响了！"),
		span_hear("你听到啪的一声！"))
	playsound(src, 'sound/effects/snap.ogg', 50, TRUE)
	qdel(src)

/obj/item/toy/snappop/fire_act(exposed_temperature, exposed_volume)
	pop_burst()

/obj/item/toy/snappop/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..())
		pop_burst()

/obj/item/toy/snappop/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/toy/snappop/proc/on_entered(datum/source, H as mob|obj)
	SIGNAL_HANDLER
	if(ishuman(H) || issilicon(H)) //i guess carp and shit shouldn't set them off
		var/mob/living/carbon/M = H
		if(issilicon(H) || M.move_intent == MOVE_INTENT_RUN)
			to_chat(M, span_danger("你踩到了摔炮！"))
			pop_burst(2, 0)

/obj/item/toy/snappop/phoenix
	name = "凤凰摔炮"
	desc = "哇！又来一次！再来一次！"
	ash_type = /obj/effect/decal/cleanable/ash/snappop_phoenix

/obj/effect/decal/cleanable/ash/snappop_phoenix
	var/respawn_time = 300

/obj/effect/decal/cleanable/ash/snappop_phoenix/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(respawn)), respawn_time)

/obj/effect/decal/cleanable/ash/snappop_phoenix/proc/respawn()
	new /obj/item/toy/snappop/phoenix(get_turf(src))
	qdel(src)

/obj/item/toy/talking
	name = "会说话的动作玩偶"
	desc = "一个没照着任何特定原型制作的普通动作玩偶。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "owlprize"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = FALSE
	var/messages = list("我超级普通！", "数学课的难度是个变量！")
	var/span = "danger"
	var/recharge_time = 30

	var/chattering = FALSE
	var/phomeme

// Talking toys are language universal, and thus all species can use them
/obj/item/toy/talking/attack_alien(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/item/toy/talking/attack_self(mob/user)
	if(!cooldown)
		activation_message(user)
		playsound(loc, 'sound/machines/click.ogg', 20, TRUE)

		INVOKE_ASYNC(src, PROC_REF(do_toy_talk), user)

		cooldown = TRUE
		addtimer(VARSET_CALLBACK(src, cooldown, FALSE), recharge_time)
		return
	..()

/obj/item/toy/talking/proc/activation_message(mob/user)
	user.visible_message(
		span_notice("[user]拉动了[src]的绳子。"),
		span_notice("你拉动了[src]的绳子。"),
		span_notice("你听到了拉绳声。"))

/obj/item/toy/talking/proc/generate_messages()
	return list(pick(messages))

/obj/item/toy/talking/proc/do_toy_talk(mob/user)
	for(var/message in generate_messages())
		toy_talk(user, message)
		sleep(1 SECONDS)

/obj/item/toy/talking/proc/toy_talk(mob/user, message)
	say(message, spans = list(span))
	if(chattering)
		chatter(message, phomeme, user)

/*
 * AI core prizes
 */
/obj/item/toy/talking/ai
	name = "玩具AI"
	desc = "一个小小的AI核心模型，真的能宣读法则！"
	icon_state = "AI"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/talking/ai/generate_messages()
	return list(generate_ion_law())

/obj/item/toy/talking/codex_gigas
	name = "玩具巨人抄本"
	desc = "帮助你编写虚构魔鬼的工具！"
	icon = 'icons/obj/service/library.dmi'
	icon_state = "demonomicon"
	inhand_icon_state = "demonomicon"
	lefthand_file = 'icons/mob/inhands/items/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/books_righthand.dmi'
	messages = list("你必须向魔鬼发起斗舞挑战！", "魔鬼的真名是伊恩", "魔鬼讨厌盐！", "你想要无穷力量吗？", "你想要无穷智慧吗？", "你想要无限治疗吗？")
	w_class = WEIGHT_CLASS_SMALL
	recharge_time = 60

/obj/item/toy/talking/codex_gigas/activation_message(mob/user)
	user.visible_message(
		span_notice("[user]按下了[src]上的按钮。"),
		span_notice("你按下了[src]上的按钮。"),
		span_notice("你听到了一声轻微的咔嗒声。"))

/obj/item/toy/talking/owl
	name = "猫头鹰动作玩偶"
	desc = "以正义守护者'猫头鹰'为原型的动作玩偶。"
	icon_state = "owlprize"
	messages = list("狮鹫，这次你跑不掉了！", "站住，罪犯！", "咕！咕！", "我就是黑夜！")
	chattering = TRUE
	phomeme = "owl"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/talking/griffin
	name = "狮鹫动作玩偶"
	desc = "以犯罪首脑'狮鹫'为原型的动作玩偶。"
	icon_state = "griffinprize"
	messages = list("你阻止不了我，猫头鹰！", "我的计划天衣无缝！金库是我的了！", "嘎——！", "你永远抓不到我！")
	chattering = TRUE
	phomeme = "griffin"
	w_class = WEIGHT_CLASS_SMALL

/*
 * Fake nuke
 */
/obj/item/toy/nuke
	name = "\improper 核裂变爆炸装置玩具"
	desc = "核裂变爆炸装置的塑料模型。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "nuketoyidle"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0

/obj/item/toy/nuke/attack_self(mob/user)
	if (obj_flags & EMAGGED && cooldown < world.time)
		cooldown = world.time + 600
		user.audible_message(span_hear("你听到了按钮的咔嗒声。"), self_message = span_notice("你启动[src]，它发出一声巨响！"))
		sleep(0.5 SECONDS)
		playsound(src, 'sound/announcer/alarm/nuke_alarm.ogg', 20, FALSE)
		sleep(14 SECONDS)
		user.visible_message(span_alert("[src]猛烈爆炸！"))
		explosion(src, light_impact_range = 1)
		qdel(src)
	else if (cooldown < world.time)
		cooldown = world.time + 600 //1 minute
		user.visible_message(span_warning("[user]按下了[src]上的按钮。"), span_notice("你启动[src]，它发出一声巨响！"), span_hear("你听到了按钮的咔嗒声。"))
		sleep(0.5 SECONDS)
		icon_state = "nuketoy"
		playsound(src, 'sound/announcer/alarm/nuke_alarm.ogg', 20, FALSE)
		sleep(13.5 SECONDS)
		icon_state = "nuketoycool"
		sleep(cooldown - world.time)
		icon_state = "nuketoyidle"
	else
		var/timeleft = (cooldown - world.time)
		to_chat(user, span_alert("什么也没发生，小显示屏上出现了'</span>[round(timeleft/10)]<span class='alert'>'。"))
		sleep(0.5 SECONDS)

/obj/item/toy/nuke/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE
	balloon_alert(user, "爆炸模拟已启用")
	obj_flags |= EMAGGED
	return TRUE

/*
 * Fake meteor
 */
/obj/item/toy/minimeteor
	name = "\improper 迷你流星"
	desc = "重温流星雨的刺激！甜肉流星公司不对迷你流星造成的任何受伤、头痛或听力损失负责。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "minimeteor"
	inhand_icon_state = "minimeteor"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE

/obj/item/toy/minimeteor/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE
	to_chat(user, span_warning("你让里面的电子元件短路了。这颗\"流星\"突然感觉重了不少……？"))
	// not adding a balloon alert here since its hard to actually describe what this emag does in the balloon
	obj_flags |= EMAGGED
	return TRUE

/obj/item/toy/minimeteor/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(src, 'sound/effects/meteorimpact.ogg', 40, TRUE)
	for(var/mob/M in urange(10, src))
		if(!IS_UNCONSCIOUS_OR_CRIT(M) && !isAI(M))
			shake_camera(M, 3, 1)
	if (obj_flags & EMAGGED)
		explosion(src, devastation_range = -1, heavy_impact_range = -1, light_impact_range = 1)

/*
 * Toy big red button
 */
/obj/item/toy/redbutton
	name = "大红按钮"
	desc = "一个红色塑料大按钮，背面写着'HONK公司恶作剧出品！'。"
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "bigred"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0

/obj/item/toy/redbutton/attack_self(mob/user)
	if (cooldown < world.time)
		cooldown = (world.time + 300) // Sets cooldown at 30 seconds
		user.visible_message(span_warning("[user]按下了大红按钮。"), span_notice("你按下按钮，它发出一声巨响！"), span_hear("按钮发出了响亮的咔嗒声。"))
		playsound(src, 'sound/effects/explosion/explosionfar.ogg', 50, FALSE)
		for(var/mob/M in urange(10, src)) // Checks range
			if(!IS_UNCONSCIOUS_OR_CRIT(M) && !isAI(M)) // Checks to make sure whoever's getting shaken is alive/not the AI
				// Short delay to match up with the explosion sound
				// Shakes player camera 2 squares for 1 second.
				addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(shake_camera), M, 2, 1), 0.8 SECONDS)

	else
		to_chat(user, span_alert("什么也没发生。"))

/*
 * Snowballs
 */
/obj/item/toy/snowball
	name = "雪球"
	desc = "一个压实的雪球，很适合拿来砸人。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "snowball"
	throwforce = 20 //the same damage as a disabler shot
	damtype = STAMINA //maybe someday we can add stuffing rocks (or perhaps ore?) into snowballs to make them deal brute damage
	custom_materials = list(/datum/material/snow = SHEET_MATERIAL_AMOUNT)

/obj/item/toy/snowball/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	user.throw_item(interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/snowball/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..())
		playsound(src, 'sound/effects/pop.ogg', 20, TRUE)
		qdel(src)

/*
 * Beach ball
 */
/obj/item/toy/beach_ball
	name = "沙滩球"
	icon = 'icons/obj/fluff/beach.dmi'
	icon_state = "ball"
	inhand_icon_state = "beachball"
	w_class = WEIGHT_CLASS_BULKY //Stops people from hiding it in their bags/pockets
	item_flags = NO_PIXEL_RANDOM_DROP

/obj/item/toy/beach_ball/branded
	name = "\improper 纳诺传讯牌沙滩球"
	desc = "朴素的沙滩球是纳诺传讯最畅销的产品之一。'我们为什么要造沙滩球？因为我们造得出来！（TM）'——纳诺传讯"

/obj/item/toy/beach_ball/baseball
	name = "棒球"
	desc = "踏入脑震荡的世界，成为命中注定的自己。"
	icon = 'icons/obj/toys/balls.dmi'
	icon_state = "baseball"
	inhand_icon_state = "baseball"
	w_class = WEIGHT_CLASS_SMALL
	throw_range = 9
	throw_speed = 0.5

/*
 * Clockwork Watch
 */
/obj/item/toy/clockwork_watch
	name = "蒸汽朋克怀表"
	desc = "一块由成千上万个微型齿轮组成的时髦蒸汽朋克怀表。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "dread_ipad"
	worn_icon_state = "dread_ipad"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	var/cooldown = 0

/obj/item/toy/clockwork_watch/attack_self(mob/user)
	if (cooldown < world.time)
		cooldown = world.time + 1800 //3 minutes
		user.visible_message(span_warning("[user]转动了[src]上的齿轮。"), span_notice("你转动[src]上的齿轮，它发出一声巨响！"), span_hear("你听到了齿轮转动的声音。"))
		playsound(src, 'sound/effects/magic/clockwork/ark_activation.ogg', 50, FALSE)
	else
		to_chat(user, span_alert("齿轮已经在转了！"))

/obj/item/toy/clockwork_watch/examine(mob/user)
	. = ..()
	. += span_info("空间站时间：[server_timestamp(ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))]")
	if(user.is_literate())
		. += span_info("也就是说，本班次已进行[round_timestamp()]。")

/*
 * Toy Dagger
 */
/obj/item/toy/toy_dagger
	name = "玩具匕首"
	desc = "一把廉价的塑料仿制匕首，由手臂玩具公司生产。"
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "render"
	inhand_icon_state = "cultdagger"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

/*
 * Xenomorph action figure
 */
/obj/item/toy/toy_xeno
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "toy_xeno"
	name = "异形动作玩偶"
	desc = "巨量牌推出全新《异形：隔离》动作玩偶！配备逼真音效！拉动背后的绳子即可使用。"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0

/obj/item/toy/toy_xeno/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 50) //5 second cooldown
		user.visible_message(span_notice("[user]拉动了[src]背后的绳子。"))
		icon_state = "[initial(icon_state)]_used"
		sleep(0.5 SECONDS)
		audible_message(span_danger("[icon2html(src, viewers(src))] 嘶！"))
		var/list/possible_sounds = list('sound/mobs/non-humanoids/hiss/hiss1.ogg', 'sound/mobs/non-humanoids/hiss/hiss2.ogg', 'sound/mobs/non-humanoids/hiss/hiss3.ogg', 'sound/mobs/non-humanoids/hiss/hiss4.ogg')
		var/chosen_sound = pick(possible_sounds)
		playsound(get_turf(src), chosen_sound, 50, TRUE)
		addtimer(VARSET_CALLBACK(src, icon_state, "[initial(icon_state)]"), 4.5 SECONDS)
	else
		to_chat(user, span_warning("[src]的拉绳还没完全收回！"))
		return

// TOY MOUSEYS :3 :3 :3
/obj/item/toy/cattoy
	name = "玩具老鼠"
	desc = "一只色彩鲜艳的玩具老鼠！"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "toy_mouse"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	floor_placeable = TRUE


/*
 * Action Figures
 */
/obj/item/toy/figure
	name = "\improper 普通角色手办"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "nuketoy"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0
	var/toysay = "你他妈干了什么？"
	var/toysound = 'sound/machines/click.ogg'

/obj/item/toy/figure/Initialize(mapload)
	. = ..()
	desc = "黑犬游戏工厂出品的[src]。" // DARKPACK EDIT CHANGE
	AddElement(/datum/element/toy_talk)

/obj/item/toy/figure/attack_self(mob/user as mob)
	if(cooldown <= world.time)
		cooldown = world.time + 50
		to_chat(user, span_notice("[src]说：“[toysay]”"))
		playsound(user, toysound, 20, TRUE)

/obj/item/toy/figure/cmo
	name = "\improper 医疗主管手办"
	icon_state = "cmo"
	toysay = "打开制服传感器！"

/obj/item/toy/figure/assistant
	name = "\improper 助理手办"
	icon_state = "assistant"
	inhand_icon_state = "assistant"
	toysay = "灰潮席卷全球！"

/obj/item/toy/figure/atmos
	name = "\improper 大气技师手办"
	icon_state = "atmos"
	toysay = "荣耀归于大气之国！"

/obj/item/toy/figure/bartender
	name = "\improper 调酒师手办"
	icon_state = "bartender"
	toysay = "庞庞在哪儿？"

/obj/item/toy/figure/bitrunner
	name = "\improper 比特潜行者手办"
	icon_state = "bitrunner"
	toysay = "我进来了……"

/obj/item/toy/figure/borg
	name = "\improper 机器人手办"
	icon_state = "borg"
	toysay = "我。又。活了。"
	toysound = 'sound/mobs/non-humanoids/cyborg/liveagain.ogg'

/obj/item/toy/figure/botanist
	name = "\improper 植物学家手办"
	icon_state = "botanist"
	toysay = "抽起来！"

/obj/item/toy/figure/captain
	name = "\improper 站长手办"
	icon_state = "captain"
	toysay = "有部门主管在吗？"

/obj/item/toy/figure/cargotech
	name = "\improper 货运技师手办"
	icon_state = "cargotech"
	toysay = "为了货运国！"

/obj/item/toy/figure/ce
	name = "\improper 总工程师手办"
	icon_state = "ce"
	toysay = "给太阳能板接线！"

/obj/item/toy/figure/chaplain
	name = "\improper 随站牧师手办"
	icon_state = "chaplain"
	toysay = "赞美太空耶稣！"

/obj/item/toy/figure/chef
	name = "\improper 厨师手办"
	icon_state = "chef"
	toysay = "我要把你做成汉堡！"

/obj/item/toy/figure/chemist
	name = "\improper 化学家手办"
	icon_state = "chemist"
	toysay = "快来领药！"

/obj/item/toy/figure/clown
	name = "\improper 小丑手办"
	icon_state = "clown"
	toysay = "HONK！"
	toysound = 'sound/items/bikehorn.ogg'

/obj/item/toy/figure/ian
	name = "\improper 伊恩手办"
	icon_state = "ian"
	toysay = "汪！"

/obj/item/toy/figure/detective
	name = "\improper 侦探手办"
	icon_state = "detective"
	toysay = "这扇气闸上有灰色连体服和绝缘手套的纤维。"

/obj/item/toy/figure/dsquad
	name = "\improper 死亡小队队员手办"
	icon_state = "dsquad"
	toysay = "杀光他们！"

/obj/item/toy/figure/engineer
	name = "\improper 空间站工程师手办"
	icon_state = "engineer"
	toysay = "天啊，奇点失控了！"

/obj/item/toy/figure/geneticist
	name = "\improper 遗传学家手办"
	icon_state = "geneticist"
	toysay = "砸烂！"

/obj/item/toy/figure/hop
	name = "\improper 人事主管手办"
	icon_state = "hop"
	toysay = "人人都有全站通行权！"

/obj/item/toy/figure/hos
	name = "\improper 安保主管手办"
	icon_state = "hos"
	toysay = "来啊，让我痛快一回。"

/obj/item/toy/figure/qm
	name = "\improper 军需官手办"
	icon_state = "qm"
	toysay = "请签署这份一式三份的表格，我们会争取在三个工作日内给您配发焊接面罩。"

/obj/item/toy/figure/janitor
	name = "\improper 清洁工手办"
	icon_state = "janitor"
	toysay = "看警示牌啊，白痴。"

/obj/item/toy/figure/lawyer
	name = "\improper 律师手办"
	icon_state = "lawyer"
	toysay = "我的当事人是个卑鄙的叛徒！"

/obj/item/toy/figure/curator
	name = "\improper 馆员手办"
	icon_state = "curator"
	toysay = "有一天……"

/obj/item/toy/figure/md
	name = "\improper 医生手办"
	icon_state = "md"
	toysay = "病人已经死了！"

/obj/item/toy/figure/coroner
	name = "\improper 法医手办"
	icon_state = "coroner"
	toysay = "把那该死的亡魂赶出去！"

/obj/item/toy/figure/paramedic
	name = "\improper 急救员手办"
	icon_state = "paramedic"
	toysay = "最妙的是？我甚至不是真正的医生！"

/obj/item/toy/figure/psychologist
	name = "\improper 心理医生手办"
	icon_state = "psychologist"
	toysay = "好啦，把这些快乐药丸吃下去！"

/obj/item/toy/figure/prisoner
	name = "\improper 囚犯手办"
	icon_state = "prisoner"
	toysay = "我没有打她！我没有！"

/obj/item/toy/figure/mime
	name = "\improper 默剧演员手办"
	icon_state = "mime"
	toysay = "..."
	toysound = null

/obj/item/toy/figure/miner
	name = "\improper 矿工手办"
	icon_state = "miner"
	toysay = "巨像就在基地外面！"

/obj/item/toy/figure/ninja
	name = "\improper 太空忍者手办"
	icon_state = "ninja"
	toysay = "我是暗影武士！"

/obj/item/toy/figure/wizard
	name = "\improper 巫师手办"
	icon_state = "wizard"
	toysay = "化为尘埃！"
	toysound = 'sound/effects/magic/disintegrate.ogg'

/obj/item/toy/figure/wizard/special
	name = "\improper 巫师手办特别版"
	toysay = "铛！";
	toysound = 'sound/effects/clang.ogg'

/obj/item/toy/figure/rd
	name = "\improper 科研主管手办"
	icon_state = "rd"
	toysay = "引爆所有机器人！"

/obj/item/toy/figure/roboticist
	name = "\improper 机器人专家手办"
	icon_state = "roboticist"
	toysay = "轰隆作响的大机甲！"
	toysound = 'sound/vehicles/mecha/mechstep.ogg'

/obj/item/toy/figure/scientist
	name = "\improper 科学家手办"
	icon_state = "scientist"
	toysay = "军械实验归我。"
	toysound = 'sound/effects/explosion/explosionfar.ogg'

/obj/item/toy/figure/syndie
	name = "\improper 核武特工手办"
	icon_state = "syndie"
	toysay = "快拿到那该死的磁盘！"

/obj/item/toy/figure/secofficer
	name = "\improper 安保员手办"
	icon_state = "secofficer"
	toysay = "我就是法律！"
	toysound = 'sound/runtime/complionator/dredd.ogg'


/obj/item/toy/figure/warden
	name = "\improper 典狱长手办"
	icon_state = "warden"
	toysay = "对着警官咳嗽，关十七分钟！"

/obj/item/toy/dummy
	name = "腹语木偶"
	desc = "这是个木偶，木头脑袋。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "puppet"
	inhand_icon_state = "puppet"
	floor_placeable = TRUE
	var/doll_name = "木偶"

//Add changing looks when i feel suicidal about making 20 inhands for these.
/obj/item/toy/dummy/attack_self(mob/user)
	var/new_name = tgui_input_text(usr, "你想给木偶起什么名字？", "木偶名字", doll_name, max_length = MAX_NAME_LEN)
	if(!new_name || !user.is_holding(src))
		return
	doll_name = new_name
	to_chat(user, span_notice("你把木偶命名为\"[doll_name]\"。"))
	name = "[initial(name)] - [doll_name]"

/obj/item/toy/dummy/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/toy_talk)

/obj/item/toy/dummy/get_voice(add_id_name)
	return doll_name

/obj/item/toy/seashell
	name = "贝壳"
	desc = "愿你口袋里常有贝壳，鞋子里常有沙子。谁知道这到底是什么意思。"
	icon = 'icons/obj/fluff/beach.dmi'
	icon_state = "shell1"
	floor_placeable = TRUE
	var/static/list/possible_colors = list("" = 2, COLOR_PURPLE_GRAY = 1, COLOR_OLIVE = 1, COLOR_PALE_BLUE_GRAY = 1, COLOR_RED_GRAY = 1)

/obj/item/toy/seashell/Initialize(mapload)
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)
	icon_state = "shell[rand(1,3)]"
	color = pick_weight(possible_colors)
	setDir(pick(GLOB.cardinals))

/obj/item/toy/brokenradio
	name = "坏收音机"
	desc = "一台打开后只会发出杂音的旧收音机。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "broken_radio"
	w_class = WEIGHT_CLASS_SMALL
	var/cooldown = 0

/obj/item/toy/brokenradio/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 300)
		user.visible_message(span_notice("[user]调整了[src]上的旋钮。"))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/items/radiostatic.ogg', 50, FALSE), 0.5 SECONDS)
	else
		to_chat(user, span_warning("[src]上的旋钮卡住了"))
		return

/obj/item/toy/braintoy
	name = "吱吱脑"
	desc = "怪物先生牌玩具，在气味和触感上模仿人脑。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-old"
	var/cooldown = 0

/obj/item/toy/braintoy/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 10)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/effects/blob/blobattack.ogg', 50, FALSE), 0.5 SECONDS)

/*
 * Eldritch Toys
 */
/obj/item/toy/eldritch_book
	name = "瘢痕法典"
	desc = "一本酷似瘢痕法典的玩具书，覆着聚酯仿人肉，封面还粘着一只巨大的活动假眼。符文全是胡写的，不能用来召唤恶魔……希望如此？"
	icon = 'icons/obj/antags/eldritch.dmi'
	base_icon_state = "book"
	icon_state = "book"
	worn_icon_state = "book"
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("献祭", "嬗变", "抓握", "诅咒")
	attack_verb_simple = list("献祭", "嬗变", "抓握", "诅咒")
	/// Helps determine the icon state of this item when it's used on self.
	var/book_open = FALSE
	/// id for timer
	var/timer_id

/obj/item/toy/eldritch_book/attack_self(mob/user, modifiers)
	. = ..()
	if(.)
		return

	if(book_open)
		close_animation()
	else
		open_animation()

/// Plays a little animation that shows the book opening and closing.
/obj/item/toy/eldritch_book/proc/open_animation()
	icon_state = "[base_icon_state]_open"
	flick("[base_icon_state]_opening", src)
	book_open = TRUE

	timer_id = addtimer(CALLBACK(src, PROC_REF(close_animation)), 5 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

/// Plays a closing animation and resets the icon state.
/obj/item/toy/eldritch_book/proc/close_animation()
	icon_state = base_icon_state
	flick("[base_icon_state]_closing", src)
	book_open = FALSE

	deltimer(timer_id)

/*
 * Fake tear
 */
/obj/item/toy/reality_pierce
	name = "现实裂隙"
	desc = "哈，你还以为是真家伙呢！"
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "pierced_illusion"
	item_flags = NO_PIXEL_RANDOM_DROP

/obj/item/toy/foamfinger
	name = "泡沫手指"
	desc = "为主队加油！等等，这座空间站有运动队吗？"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "foamfinger"
	inhand_icon_state = "foamfinger_inhand"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	COOLDOWN_DECLARE(foamfinger_cooldown)

/obj/item/toy/foamfinger/attack_self(mob/living/carbon/human/user)
	if(!COOLDOWN_FINISHED(src, foamfinger_cooldown))
		return
	COOLDOWN_START(src, foamfinger_cooldown, 5 SECONDS)
	user.manual_emote("挥舞着泡沫手指。")
	var/direction = prob(50) ? -1 : 1
	if(NSCOMPONENT(user.dir))
		animate(user, pixel_w = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		animate(pixel_w = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_w = (2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_w = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_w = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
	else
		animate(user, pixel_z = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		animate(pixel_z = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_z = (2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_z = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_z = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
	user.changeNext_move(CLICK_CD_MELEE)

///All people who have used an Intento this round along with their high scores.
GLOBAL_LIST_EMPTY(intento_players)

#define HELP "help"
#define DISARM "disarm"
#define GRAB "grab"
#define HARM "harm"
#define ICON_SPLIT ICON_SIZE_ALL/2

// These states do not have any associated processing.
#define STATE_AWAITING_PLAYER_INPUT "awaiting_player_input"
#define STATE_OFF "off"

// When the Intento is in one of these four states, it has an accompanying
// set of code that runs in processing()
#define STATE_STARTING "starting"
#define STATE_DEMO "demo"
#define STATE_END_OF_GAME "end_of_game"
#define STATE_RETALIATION "retaliation"

#define TIME_TO_BEGIN (1.6 SECONDS)
#define TIME_PER_DEMO_STEP (0.6 SECONDS)
#define TIME_TO_RESET_ICON (0.5 SECONDS)

/obj/item/toy/intento
	name = "\improper 意任堂"
	desc = "无论有意无意，基本都派不上用场。"
	icon = 'icons/obj/toys/intents.dmi'
	icon_state = "blank"
	custom_price = PAYCHECK_COMMAND * 1.25

	/// Current sequence of intents
	var/list/current_sequence = list()
	/// Sequence player inputs
	var/list/player_sequence = list()
	/// Score of the player
	var/score = 0
	/// Associated list of intents to their sounds
	var/static/list/sound_by_intent = list(
		HELP = 'sound/items/intents/Help.ogg',
		DISARM = 'sound/items/intents/Disarm.ogg',
		GRAB = 'sound/items/intents/Grab.ogg',
		HARM = 'sound/items/intents/Harm.ogg',
		)

	/// What state the toy is in.
	var/state = STATE_OFF
	/// Index used for iteration of steps for both demo and retaliation states
	var/index
	/// Time to delay until we start processing whatever state we're in
	COOLDOWN_DECLARE(next_process)
	/// Time until we reset the icon of the Intento
	COOLDOWN_DECLARE(next_icon_reset)

/obj/item/toy/intento/attack_self(mob/user, modifiers) //added params to attack_self, the alternative is registering a signal on clickon but i was advised not to
	..()
	if(state == STATE_OFF)
		boot()
		return

	if(!modifiers)
		return

	if(state != STATE_AWAITING_PLAYER_INPUT)
		return

	var/input
	var/icon_x = text2num(modifiers[ICON_X])
	var/icon_y = text2num(modifiers[ICON_Y])
	if(icon_x > ICON_SPLIT && icon_y > ICON_SPLIT)
		input = DISARM
	if(icon_x < ICON_SPLIT && icon_y > ICON_SPLIT)
		input = HELP
	if(icon_x > ICON_SPLIT && icon_y < ICON_SPLIT)
		input = GRAB
	if(icon_x < ICON_SPLIT && icon_y < ICON_SPLIT)
		input = HARM

	player_input(user, input)

/obj/item/toy/intento/proc/boot()
	say("游戏开始！")
	playsound(src, 'sound/machines/synth/synth_yes.ogg', 50, FALSE)

	state = STATE_STARTING
	COOLDOWN_START(src, next_process, TIME_TO_BEGIN)
	START_PROCESSING(SSfastprocess, src)

/obj/item/toy/intento/proc/player_input(mob/player, intent)
	// All branches of this proc lead to us wanting to process
	START_PROCESSING(SSfastprocess, src)

	render(intent)

	player_sequence += intent
	for(var/i in 1 to player_sequence.len)
		if(player_sequence[i] != current_sequence[i])
			state = STATE_END_OF_GAME
			COOLDOWN_START(src, next_process, TIME_TO_RESET_ICON)
			return

	if(player_sequence.len == current_sequence.len)
		score++

		state = STATE_STARTING
		COOLDOWN_START(src, next_process, TIME_TO_BEGIN)

/obj/item/toy/intento/process()
	if(next_icon_reset && next_icon_reset <= world.time)
		icon_state = initial(icon_state)
		COOLDOWN_RESET(src, next_icon_reset)

	if(next_process && next_process > world.time)
		return

	switch(state)
		if(STATE_STARTING)
			process_start()

		if(STATE_DEMO)
			process_demo()

		if(STATE_END_OF_GAME)
			process_end(isliving(loc) ? loc : null)

		if(STATE_RETALIATION)
			process_retaliation()

	if(!next_process && !next_icon_reset)
		return PROCESS_KILL

/obj/item/toy/intento/proc/process_start()
	player_sequence.Cut()

	current_sequence += pick(list(HELP, DISARM, GRAB, HARM))

	state = STATE_DEMO
	next_process = world.time
	index = 1

/obj/item/toy/intento/proc/process_demo()
	if(index > length(current_sequence))
		state = STATE_AWAITING_PLAYER_INPUT
		COOLDOWN_RESET(src, next_process)
		return

	var/intent = current_sequence[index]
	render(intent)

	index += 1
	COOLDOWN_START(src, next_process, TIME_PER_DEMO_STEP)

/obj/item/toy/intento/proc/process_end(mob/user)
	if(user && GLOB.intento_players[user.ckey] < score)
		GLOB.intento_players[user.ckey] = score
		var/award_status = user.client.get_award_status(/datum/award/score/intento_score)
		var/award_score = score - award_status
		if(award_score > 0)
			user.client.give_award(/datum/award/score/intento_score, user, award_score)

	say("游戏结束。你的得分为[score]！")
	playsound(src, 'sound/machines/synth/synth_no.ogg', 50, FALSE)

	if(user && loc == user && obj_flags & EMAGGED)
		ADD_TRAIT(src, TRAIT_NODROP, type)
		to_chat(user, span_userdanger("大错特错。"))

		state = STATE_RETALIATION
		next_process = world.time
		index = 1
	else
		cleanup()

/obj/item/toy/intento/proc/process_retaliation()
	var/mob/living/victim = loc
	if(!isliving(victim) || index > length(current_sequence))
		cleanup()
		return

	var/intent = current_sequence[index]
	render(intent)
	switch(intent)
		if(HELP)
			to_chat(victim, span_danger("[src]抱了抱你，想让你好受一点！"))
			victim.add_mood_event("hug", /datum/mood_event/hug)
		if(DISARM)
			to_chat(victim, span_danger("[src]一把将你推倒了！"))
			victim.Knockdown(2 SECONDS)
		if(GRAB)
			to_chat(victim, span_danger("[src]凶狠地抓住了你！"))
			victim.Stun(2 SECONDS)
		if(HARM)
			to_chat(victim, span_danger("[src]打了你一拳！"))
			victim.apply_damage(rand(20, 30), BRUTE)

	index += 1
	COOLDOWN_START(src, next_process, TIME_PER_DEMO_STEP)

/obj/item/toy/intento/proc/cleanup()
	score = 0
	index = 1
	player_sequence.Cut()
	current_sequence.Cut()

	state = STATE_OFF
	COOLDOWN_RESET(src, next_process)
	REMOVE_TRAIT(src, TRAIT_NODROP, type)

/obj/item/toy/intento/proc/render(input)
	icon_state = input
	playsound(src, sound_by_intent[input], 50, FALSE)

	START_PROCESSING(SSfastprocess, src)
	COOLDOWN_START(src, next_icon_reset, TIME_TO_RESET_ICON)

/obj/item/toy/intento/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "负反馈循环已启用")
	return TRUE

/obj/item/toy/intento/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

#undef HELP
#undef DISARM
#undef GRAB
#undef HARM
#undef ICON_SPLIT
#undef STATE_AWAITING_PLAYER_INPUT
#undef STATE_OFF
#undef STATE_STARTING
#undef STATE_DEMO
#undef STATE_END_OF_GAME
#undef STATE_RETALIATION
#undef TIME_TO_BEGIN
#undef TIME_PER_DEMO_STEP
#undef TIME_TO_RESET_ICON

/*
 * Runic Scepter
 */
/obj/item/toy/foam_runic_scepter
	name = "泡沫权杖"
	desc = "仿照巫师在售货机魔法足球中使用的权杖制成的泡沫玩具。"
	icon_state = "vendor_staff"
	worn_icon_state = "vendor_staff" //For the back
	inhand_icon_state = "vendor_staff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon = 'icons/obj/weapons/guns/magic.dmi'
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("拍打", "棍击", "敲打", "售货击")
	attack_verb_simple = list("拍打", "棍击", "敲打", "售货击")
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE

/obj/item/extendohand
	name = "伸缩手"
	desc = "未来科技让这种经典弹簧拳击玩具基本能充当功能齐全、由手操控的义手。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "extendohand"
	inhand_icon_state = "extendohand"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 0
	throwforce = 5
	reach = 2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	var/min_reach = 2

/obj/item/extendohand/acme
	name = "\improper ACME伸缩手"
	desc = "ACME公司制造的新奇伸缩手，最初设计用来打晕走鹃。"

/obj/item/extendohand/attack(atom/M, mob/living/carbon/human/user, list/modifiers, list/attack_modifiers)
	var/dist = get_dist(M, user)
	if(dist < min_reach)
		to_chat(user, span_warning("[M]太近了，没法使用[src]。"))
		return
	M.attack_hand(user, modifiers)

/obj/item/banhammer
	desc = "一把封禁锤。"
	name = "封禁锤"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "toyhammer"
	icon_angle = -45
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	force = 1
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	attack_verb_continuous = list("封禁")
	attack_verb_simple = list("封禁")
	max_integrity = 200
	armor_type = /datum/armor/item_banhammer
	resistance_flags = FIRE_PROOF

/datum/armor/item_banhammer
	fire = 100
	acid = 70

/obj/item/banhammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/banhammer/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正用[src]打自己！看起来是想把自己从生命中封禁。"))
	return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)
/*
oranges says: This is a meme relating to the english translation of the ss13 russian wiki page on lurkmore.
mrdoombringer sez: and remember kids, if you try and PR a fix for this item's grammar, you are admitting that you are, indeed, a newfriend.
for further reading, please see: https://github.com/tgstation/tgstation/pull/30173 and https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=%2F%2Flurkmore.to%2FSS13&edit-text=&act=url
*/
/obj/item/banhammer/attack(mob/M, mob/living/user)
	if(user.zone_selected == BODY_ZONE_HEAD)
		M.visible_message(span_danger("[user]正用邦伽锤抚摸[M]的头。"), span_userdanger("[user]正用邦伽锤抚摸你的头。"), span_hear("你听到邦伽锤抚摸脑袋的声音。")) // see above comment
	else
		M.visible_message(span_danger("[M]被[user]毫无葡萄干地封禁了！"), span_userdanger("你被[user]毫无葡萄干地封禁了！"), span_hear("你听到封禁锤正在封禁某人。"))
	playsound(loc, 'sound/effects/adminhelp.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much
	if(user.combat_mode)
		return ..(M, user)
