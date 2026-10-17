/obj/item/toy/plush
	name = "plush"
	desc = "This is the special coder plush, do not steal."
	icon = 'icons/obj/toys/plushes.dmi'
	icon_state = "debug"
	worn_icon_state = "plushie"
	attack_verb_continuous = list("捶打", "拍打", "碰撞")
	attack_verb_simple = list("捶打", "拍打", "碰撞")
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	floor_placeable = TRUE
	var/list/squeak_override //Weighted list; If you want your plush to have different squeak sounds use this
	var/stuffed = TRUE //If the plushie has stuffing in it
	var/obj/item/grenade/grenade //You can remove the stuffing from a plushie and add a grenade to it for *nefarious uses*
	//--love ~<3--
	gender = NEUTER
	var/obj/item/toy/plush/lover
	var/obj/item/toy/plush/partner
	var/obj/item/toy/plush/plush_child
	var/obj/item/toy/plush/paternal_parent //who initiated creation
	var/obj/item/toy/plush/maternal_parent //who owns, see love()
	var/list/scorned = list() //who the plush hates
	var/list/scorned_by = list() //who hates the plush, to remove external references on Destroy()
	var/heartbroken = FALSE
	var/vowbroken = FALSE
	var/young = FALSE
	///Prevents players from cutting stuffing out of a plushie if true
	var/divine = FALSE
	var/mood_message
	var/list/love_message
	var/list/partner_message
	var/list/heartbroken_message
	var/list/vowbroken_message
	var/list/parent_message
	var/normal_desc
	/// The type of offspring this plush generates. If not set, it'll default to the type itself on init.
	var/offspring_type

	//--end of love :'(--

/*
** If you add a new plushie please add it to the lists at both:
** /obj/effect/spawner/random/entertainment/plushie
** /obj/effect/spawner/random/entertainment/plushie_delux
*/

/obj/item/toy/plush/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, squeak_override)
	AddElement(/datum/element/bed_tuckable, mapload, 6, -5, 90)
	AddElement(/datum/element/toy_talk)
	AddElement(/datum/element/cuffable_item)

	//have we decided if Pinocchio goes in the blue or pink aisle yet?
	if(gender == NEUTER)
		if(prob(50))
			gender = FEMALE
		else
			gender = MALE

	if(!offspring_type)
		offspring_type = type

	love_message = list("\n[src]高兴得缝线都快绷开了！")
	partner_message = list("\n[src]的手指上戴着戒指！上面写着：与亲爱的[partner]永结同心。")
	heartbroken_message = list("\n[src]看起来非常伤心。")
	vowbroken_message = list("\n[src]弄丢了戒指……")
	parent_message = list("\n[src]已经忘了睡觉是什么感觉。")

	normal_desc = desc

/obj/item/toy/plush/Destroy()
	QDEL_NULL(grenade)

	//inform next of kin and... acquaintances
	if(partner)
		partner.bad_news(src)
		partner = null
		lover = null
	else if(lover)
		lover.bad_news(src)
		lover = null

	if(paternal_parent)
		paternal_parent.bad_news(src)
		paternal_parent = null

	if(maternal_parent)
		maternal_parent.bad_news(src)
		maternal_parent = null

	if(plush_child)
		plush_child.bad_news(src)
		plush_child = null

	var/i
	var/obj/item/toy/plush/P
	for(i=1, i <= scorned.len, i++)
		P = scorned[i]
		P.bad_news(src)
	scorned = null

	for(i=1, i <= scorned_by.len, i++)
		P = scorned_by[i]
		P.bad_news(src)
	scorned_by = null

	//null remaining lists
	squeak_override = null

	love_message = null
	partner_message = null
	heartbroken_message = null
	vowbroken_message = null
	parent_message = null

	return ..()

/obj/item/toy/plush/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == grenade)
		grenade = null

/obj/item/toy/plush/attack_self(mob/user)
	. = ..()
	if(stuffed || grenade)
		to_chat(user, span_notice("你摸了摸[src]。真可爱。"))
		if(grenade && !grenade.active)
			user.log_message("activated a hidden grenade in [src].", LOG_VICTIM)
			grenade.arm_grenade(user, msg = FALSE, volume = 10)
	else
		to_chat(user, span_notice("你想摸摸[src]，可它已经没有填充物了。唉……"))

/obj/item/toy/plush/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.get_sharpness())
		if(grenade)
			to_chat(user, span_notice("你从[src]中取出手榴弹。"))
			user.put_in_hands(grenade)
			return ITEM_INTERACT_SUCCESS
		if(!stuffed)
			to_chat(user, span_warning("你已经杀死它了！"))
			return ITEM_INTERACT_BLOCKING
		if(!divine)
			user.visible_message(span_notice("[user]扯出了[src]的填充物！"), span_notice("你从[src]里扯出一大把填充物。你这个凶手。"))
			tool.play_tool_sound(src)
			stuffed = FALSE
			return ITEM_INTERACT_SUCCESS

		to_chat(user, span_notice("你真是个傻瓜。[src]可是神，你怎能杀死神？多么宏大而令人陶醉的天真。"))
		user.adjust_drunk_effect(20, up_to = 50)

		var/turf/current_location = get_turf(user)
		var/area/current_area = current_location.loc //copied from hand tele code
		if(current_location && current_area && (current_area.area_flags & NOTELEPORT))
			to_chat(user, span_notice("你无处可逃。在这里，召回与神力干预都无法奏效。"))
		else
			to_chat(user, span_notice("你无处可逃。虽然这里可以使用召回或神力干预，但企图逃离[src]的无边伟力仍是徒劳。"))
		user.visible_message(span_notice("[user]放下武器，祈求[src]的怜悯！"), span_notice("你放下武器，祈求[src]的怜悯。"))
		user.drop_all_held_items()
		return ITEM_INTERACT_SUCCESS

	if(isgrenade(tool))
		if(stuffed)
			to_chat(user, span_warning("你得先取出一些填充物！"))
			return ITEM_INTERACT_BLOCKING
		if(grenade)
			to_chat(user, span_warning("[src]里面已经有一枚手榴弹了！"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(span_warning("[user]将[grenade]塞入[src]。"), \
		span_danger("你将[tool]塞入[src]。"))
		grenade = tool
		user.log_message("added a grenade ([tool.name]) to [src]", LOG_GAME)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/toy/plush))
		love(tool, user)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/toy/plush/proc/love(obj/item/toy/plush/Kisser, mob/living/user) //~<3
	var/chance = 100 //to steal a kiss, surely there's a 100% chance no-one would reject a plush such as I?
	var/concern = 20 //perhaps something might cloud true love with doubt
	var/loyalty = 30 //why should another get between us?
	var/duty = 50 //conquering another's is what I live for

	//we are not catholic
	if(young == TRUE || Kisser.young == TRUE)
		user.show_message(span_notice("[src]和[Kisser]玩起了捉人游戏。"), MSG_VISUAL,
			span_notice("它们很开心。"), NONE)
		Kisser.cheer_up()
		cheer_up()

	//never again
	else if(Kisser in scorned)
		//message, visible, alternate message, neither visible nor audible
		user.show_message(span_notice("[src]拒绝了[Kisser]的示爱！"), MSG_VISUAL,
			span_notice("感觉没什么效果。"), NONE)
	else if(src in Kisser.scorned)
		user.show_message(span_notice("[Kisser]认出了[src]，转过身去。"), MSG_VISUAL,
			span_notice("感觉没什么效果。"), NONE)

	//first comes love
	else if(Kisser.lover != src && Kisser.partner != src) //cannot be lovers or married
		if(Kisser.lover) //if the initiator has a lover
			Kisser.lover.heartbreak(Kisser) //the old lover can get over the kiss-and-run whilst the kisser has some fun
			chance -= concern //one heart already broken, what does another mean?
		if(lover) //if the recipient has a lover
			chance -= loyalty //mustn't... but those lips
		if(partner) //if the recipient has a partner
			chance -= duty //do we mate for life?

		if(prob(chance)) //did we bag a date?
			user.visible_message(span_notice("[user]让[Kisser]亲吻[src]！"),
									span_notice("你让[Kisser]亲吻[src]！"))
			if(lover) //who cares for the past, we live in the present
				lover.heartbreak(src)
			new_lover(Kisser)
			Kisser.new_lover(src)
		else
			user.show_message(span_notice("[src]拒绝了[Kisser]的示爱，也许下次会成功？"), MSG_VISUAL,
								span_notice("这次似乎没什么效果。"), NONE)

	//then comes marriage
	else if(Kisser.lover == src && Kisser.partner != src) //need to be lovers (assumes loving is a two way street) but not married (also assumes similar)
		user.visible_message(span_notice("[user]宣布[Kisser]与[src]结为伴侣！真可爱。"),
									span_notice("你宣布[Kisser]与[src]结为伴侣！"))
		new_partner(Kisser)
		Kisser.new_partner(src)

	//then comes a baby in a baby's carriage, or an adoption in an adoption's orphanage
	else if(Kisser.partner == src && !plush_child) //the one advancing does not take ownership of the child and we have a one child policy in the toyshop
		user.visible_message(span_notice("[user]再这样把[Kisser]和[src]撞来撞去，迟早要把它们弄坏。"),
									span_notice("[Kisser]在你手里热情地拥抱[src]。别看了，你这个变态！"))
		user.client.give_award(/datum/award/achievement/misc/rule8, user)
		if(plop(Kisser))
			user.visible_message(span_notice("有什么东西落在了[user]脚边。"),
							span_notice("生命的奇迹……天啊，那刚刚是从[src]里出来的？！"))

	//then comes protection, or abstinence if we are catholic
	else if(Kisser.partner == src && plush_child)
		user.visible_message(span_notice("[user]让[Kisser]蹭了蹭[src]！"),
									span_notice("你让[Kisser]蹭了蹭[src]！"))

	//then oh fuck something unexpected happened
	else
		user.show_message(span_warning("[Kisser]和[src]不知道该如何面对彼此。"), NONE)

/obj/item/toy/plush/proc/heartbreak(obj/item/toy/plush/Brutus)
	if(lover != Brutus)
		CRASH("plushie heartbroken by a plushie that is not their lover")

	scorned.Add(Brutus)
	Brutus.scorned_by(src)

	lover = null
	Brutus.lover = null //feeling's mutual

	heartbroken = TRUE
	mood_message = pick(heartbroken_message)

	if(partner == Brutus) //oh dear...
		partner = null
		Brutus.partner = null //it'd be weird otherwise
		vowbroken = TRUE
		mood_message = pick(vowbroken_message)

	update_desc()

/obj/item/toy/plush/proc/scorned_by(obj/item/toy/plush/Outmoded)
	scorned_by.Add(Outmoded)

/obj/item/toy/plush/proc/new_lover(obj/item/toy/plush/Juliet)
	if(lover == Juliet)
		return //nice try
	lover = Juliet

	cheer_up()
	lover.cheer_up()

	mood_message = pick(love_message)
	update_desc()

	if(partner) //who?
		partner = null //more like who cares

/obj/item/toy/plush/proc/new_partner(obj/item/toy/plush/Apple_of_my_eye)
	if(partner == Apple_of_my_eye)
		return //double marriage is just insecurity
	if(lover != Apple_of_my_eye)
		return //union not born out of love will falter

	partner = Apple_of_my_eye

	heal_memories()
	partner.heal_memories()

	mood_message = pick(partner_message)
	update_desc()

/obj/item/toy/plush/proc/plop(obj/item/toy/plush/daddy)
	if(partner != daddy)
		return FALSE //we do not have bastards in our toyshop

	// Ask the RNG if it looks more like mommy or daddy.
	var/chosen_type = pick(offspring_type, daddy.offspring_type)

	plush_child = new chosen_type(get_turf(loc))
	plush_child.make_young(src, daddy)

/obj/item/toy/plush/proc/make_young(obj/item/toy/plush/Mama, obj/item/toy/plush/Dada)
	if(Mama == Dada)
		return //cloning is reserved for plants and spacemen

	maternal_parent = Mama
	paternal_parent = Dada
	young = TRUE
	name = "小[Mama]" //Icelandic naming convention pending
	normal_desc = "[src] is a little baby of [maternal_parent] and [paternal_parent]!" //original desc won't be used so the child can have moods
	transform *= 0.75
	update_desc()

	Mama.mood_message = pick(Mama.parent_message)
	Mama.update_desc()
	Dada.mood_message = pick(Dada.parent_message)
	Dada.update_desc()

/obj/item/toy/plush/proc/bad_news(obj/item/toy/plush/Deceased) //cotton to cotton, sawdust to sawdust
	var/is_that_letter_for_me = FALSE
	if(partner == Deceased) //covers marriage
		is_that_letter_for_me = TRUE
		partner = null
		lover = null
	else if(lover == Deceased) //covers lovers
		is_that_letter_for_me = TRUE
		lover = null

	//covers children
	if(maternal_parent == Deceased)
		is_that_letter_for_me = TRUE
		maternal_parent = null

	if(paternal_parent == Deceased)
		is_that_letter_for_me = TRUE
		paternal_parent = null

	//covers parents
	if(plush_child == Deceased)
		is_that_letter_for_me = TRUE
		plush_child = null

	//covers bad memories
	if(Deceased in scorned)
		scorned.Remove(Deceased)
		cheer_up() //what cold button eyes you have

	if(Deceased in scorned_by)
		scorned_by.Remove(Deceased)

	//all references to the departed should be cleaned up by now

	if(is_that_letter_for_me)
		heartbroken = TRUE
		mood_message = pick(heartbroken_message)
		update_desc()

/obj/item/toy/plush/proc/cheer_up() //it'll be all right
	if(!heartbroken)
		return //you cannot make smile what is already
	if(vowbroken)
		return //it's a pretty big deal

	heartbroken = !heartbroken

	if(mood_message in heartbroken_message)
		mood_message = null
	update_desc()

/obj/item/toy/plush/proc/heal_memories() //time fixes all wounds
	if(!vowbroken)
		vowbroken = !vowbroken
		if(mood_message in vowbroken_message)
			mood_message = null
	cheer_up()

/obj/item/toy/plush/update_desc()
	desc = normal_desc
	. = ..()
	if(mood_message)
		desc += mood_message

/obj/item/toy/plush/carpplushie
	name = "太空鲤鱼玩偶"
	desc = "模样像太空鲤鱼的可爱毛绒玩具。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/carpplushie"
	worn_icon = "carp"
	post_init_icon_state = "map_plushie_carp"
	greyscale_config = /datum/greyscale_config/plush_carp
	greyscale_colors = "#cc99ff#000000"
	inhand_icon_state = "carp_plushie"
	attack_verb_continuous = list("撕咬", "啃食", "鳍拍")
	attack_verb_simple = list("撕咬", "啃食", "鳍拍")
	squeak_override = list('sound/items/weapons/bite.ogg'=1)

/obj/item/toy/plush/bubbleplush
	name = "\improper 泡泡糖玩偶"
	desc = "友善的红色恶魔，会给乖矿工送礼物。"
	icon_state = "bubbleplush"
	attack_verb_continuous = list("撕裂")
	attack_verb_simple = list("撕裂")
	squeak_override = list('sound/effects/magic/demon_attack1.ogg'=1)

/obj/item/toy/plush/ratplush
	name = "\improper 拉特瓦尔玩偶"
	desc = "发条执法者本尊的可爱玩偶，搭载全新改良的弹簧手臂动作。"
	icon_state = "plushvar"
	worn_icon = "ratvar"
	divine = TRUE
	var/obj/item/toy/plush/narplush/clash_target
	gender = MALE //he's a boy, right?

/obj/item/toy/plush/ratplush/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(clash_target)
		return
	var/obj/item/toy/plush/narplush/P = locate() in range(1, src)
	if(P && istype(P.loc, /turf/open) && !P.clashing)
		INVOKE_ASYNC(src, PROC_REF(clash_of_the_plushies), P)

/obj/item/toy/plush/ratplush/proc/clash_of_the_plushies(obj/item/toy/plush/narplush/P)
	clash_target = P
	P.clashing = TRUE
	say("是你。")
	P.say("拉特瓦尔？！")
	var/obj/item/toy/plush/a_winnar_is
	var/victory_chance = 10
	for(var/i in 1 to 10) //We only fight ten times max
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		if(!Adjacent(P))
			visible_message(span_warning("两只玩偶愤怒地朝彼此挥舞手臂，最后放弃了。"))
			clash_target = null
			P.clashing = FALSE
			return
		playsound(src, 'sound/effects/magic/clockwork/ratvar_attack.ogg', 50, TRUE, frequency = 2)
		sleep(0.24 SECONDS)
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		if(prob(victory_chance))
			a_winnar_is = src
			break
		P.SpinAnimation(5, 0)
		sleep(0.5 SECONDS)
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		playsound(P, 'sound/effects/magic/clockwork/narsie_attack.ogg', 50, TRUE, frequency = 2)
		sleep(0.33 SECONDS)
		if(QDELETED(src))
			P.clashing = FALSE
			return
		if(QDELETED(P))
			clash_target = null
			return
		if(prob(victory_chance))
			a_winnar_is = P
			break
		SpinAnimation(5, 0)
		victory_chance += 10
		sleep(0.5 SECONDS)
	if(!a_winnar_is)
		a_winnar_is = pick(src, P)
	if(a_winnar_is == src)
		say(pick("去死。", "腐朽吧。"))
		P.say(pick("不——……", "别死。对你——", "死吧。拉特——", "Sas tyen re-"))
		playsound(src, 'sound/effects/magic/clockwork/anima_fragment_attack.ogg', 50, TRUE, frequency = 2)
		playsound(P, 'sound/effects/magic/demon_dies.ogg', 50, TRUE, frequency = 2)
		explosion(P, light_impact_range = 1)
		qdel(P)
		clash_target = null
	else
		say("不！我不会再被放逐了……")
		P.say(pick("哈。", "Ra'sha fonn dest.", "蠢货。竟敢来到这里。"))
		playsound(src, 'sound/effects/magic/clockwork/anima_fragment_death.ogg', 62, TRUE, frequency = 2)
		playsound(P, 'sound/effects/magic/demon_attack1.ogg', 50, TRUE, frequency = 2)
		explosion(src, light_impact_range = 1)
		qdel(src)
		P.clashing = FALSE

/obj/item/toy/plush/narplush
	name = "\improper 纳尔西玩偶"
	desc = "古老女神纳尔西的小毛绒玩偶。谁会觉得这适合给孩子玩？"
	icon_state = "narplush"
	worn_icon = "narsie"
	divine = TRUE
	var/clashing
	gender = FEMALE //it's canon if the toy is

/obj/item/toy/plush/narplush/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	var/obj/item/toy/plush/ratplush/P = locate() in range(1, src)
	if(P && istype(P.loc, /turf/open) && !P.clash_target && !clashing)
		INVOKE_ASYNC(P, TYPE_PROC_REF(/obj/item/toy/plush/ratplush, clash_of_the_plushies), src)

/obj/item/toy/plush/lizard_plushie
	name = "蜥蜴人玩偶"
	desc = "模样像蜥蜴人的可爱毛绒玩具。"
	icon_state = "map_plushie_lizard"
	greyscale_config = /datum/greyscale_config/plush_lizard
	attack_verb_continuous = list("爪击", "嘶鸣", "尾击")
	attack_verb_simple = list("爪击", "嘶鸣", "尾击")
	squeak_override = list('sound/items/weapons/slash.ogg' = 1)

/obj/item/toy/plush/lizard_plushie/Initialize(mapload)
	. = ..()
	if(!greyscale_colors)
		// Generate a random valid lizard color for our plushie friend
		var/generated_lizard_color = "#" + random_color()
		var/list/lizard_hsv = rgb2hsv(generated_lizard_color)

		// If our color is too dark, use the classic green lizard plush color
		if(lizard_hsv[3] < 50)
			generated_lizard_color = "#66ff33"

		// Set our greyscale colors to the lizard color we made + black eyes
		set_greyscale(colors = list(generated_lizard_color, COLOR_BLACK))

// Preset lizard plushie that uses the original lizard plush green. (Or close to it)
/obj/item/toy/plush/lizard_plushie/green
	desc = "模样像绿色蜥蜴人的可爱毛绒玩具，让你满怀怀旧之情与灵魂共鸣。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/lizard_plushie/green"
	post_init_icon_state = "map_plushie_lizard"
	greyscale_colors = "#66ff33#000000"

/obj/item/toy/plush/lizard_plushie/greyscale
	desc = "模样像蜥蜴人的可爱毛绒玩具，这一只是专门定制的。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/lizard_plushie/greyscale"
	post_init_icon_state = "map_plushie_lizard"
	greyscale_colors = "#d3d3d3#000000"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/toy/plush/lizard_plushie/space
	name = "太空蜥蜴人玩偶"
	desc = "模样像意志坚定的太空蜥蜴人的可爱毛绒玩具。飞向宇宙，浩瀚无垠，小家伙。"
	icon_state = "map_plushie_spacelizard"
	greyscale_config = /datum/greyscale_config/plush_spacelizard
	// space lizards can't hit people with their tail, it's stuck in their suit
	attack_verb_continuous = list("爪击", "嘶鸣", "轻敲")
	attack_verb_simple = list("爪击", "嘶鸣", "轻敲")

/obj/item/toy/plush/lizard_plushie/space/green
	desc = "模样像意志坚定的绿色太空蜥蜴人的可爱毛绒玩具。飞向宇宙，浩瀚无垠，小家伙。它让你满怀怀旧之情与灵魂共鸣。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/lizard_plushie/space/green"
	post_init_icon_state = "map_plushie_spacelizard"
	greyscale_colors = "#66ff33#000000"

/obj/item/toy/plush/snakeplushie
	name = "蛇玩偶"
	desc = "模样像蛇的可爱毛绒玩具，可别当成真蛇。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/snakeplushie"
	post_init_icon_state = "map_plushie_snake"
	greyscale_config = /datum/greyscale_config/plush_snake
	greyscale_colors = "#99ff99#000000"
	inhand_icon_state = null
	attack_verb_continuous = list("撕咬", "嘶鸣", "尾击")
	attack_verb_simple = list("撕咬", "嘶鸣", "尾击")
	squeak_override = list('sound/items/weapons/bite.ogg' = 1)

/obj/item/toy/plush/nukeplushie
	name = "特工玩偶"
	desc = "模样像辛迪加核特工的毛绒玩具。标签声称这些特工纯属虚构。"
	icon_state = "plushie_nuke"
	inhand_icon_state = null
	attack_verb_continuous = list("射击", "核爆", "引爆")
	attack_verb_simple = list("射击", "核爆", "引爆")
	squeak_override = list('sound/effects/hit_punch.ogg' = 1)

/obj/item/toy/plush/plasmamanplushie
	name = "等离子人玩偶"
	desc = "模样像你的紫色同事的毛绒玩具。嗯，没错，尽管设计师竭尽全力，它还是像真正的等离子人一样，一点也不可爱。"
	icon_state = "plushie_pman"
	inhand_icon_state = null
	attack_verb_continuous = list("灼烧", "太空兽击", "呼啸")
	attack_verb_simple = list("灼烧", "太空兽击", "呼啸")
	squeak_override = list('sound/effects/extinguish.ogg' = 1)

/obj/item/toy/plush/slimeplushie
	name = "史莱姆玩偶"
	desc = "模样像史莱姆的可爱毛绒玩具，其实基本就是个沙包。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/toy/plush/slimeplushie"
	post_init_icon_state = "map_plushie_slime"
	greyscale_config = /datum/greyscale_config/plush_slime
	greyscale_colors = "#aaaaff#000000"
	inhand_icon_state = null
	attack_verb_continuous = list("咕噜", "黏击", "吸收")
	attack_verb_simple = list("咕噜", "黏击", "吸收")
	squeak_override = list('sound/effects/blob/blobattack.ogg' = 1)
	gender = FEMALE //given all the jokes and drawings, I'm not sure the xenobiologists would make a slimeboy

// This is supposed to be only in the bus ruin, don't spawn it elsewhere
/obj/item/toy/plush/awakenedplushie
	name = "觉醒玩偶"
	desc = "一只已经领悟现实真正本质的古老玩偶。"
	icon_state = "plushie_awake"
	inhand_icon_state = null

/obj/item/toy/plush/awakenedplushie/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/edit_complainer)

/obj/item/toy/plush/whiny_plushie
	name = "哭闹玩偶"
	desc = "一只被遗忘太久、如今要求时刻有人陪伴的古老玩偶。"
	icon_state = "plushie_whiny"
	inhand_icon_state = null
	/// static list of cry messages it picks from to speak when it is insecure from no movement
	var/static/list/cry_still_messages
	/// static list of cry messages it picks from to speak when it is insecure from no holder
	var/static/list/cry_alone_messages
	/// cooldown for it sending messages, it will every 10 seconds
	COOLDOWN_DECLARE(cry_cooldown)

/obj/item/toy/plush/whiny_plushie/Initialize(mapload)
	. = ..()
	if(!cry_still_messages)
		cry_still_messages = list(
			"我们为什么停下来了？！你要丢下我吗？！！",
			"我们会被袭击的，待着就是活靶子，快走，走啊啊啊！！",
			"你打算把我扔下对不对，我知道你就是这么想的啊啊啊！！",
			"辛迪加正在三角定位我们的位置啊啊啊！！",
			"这地方好可怕，我要离开啊啊啊！！",
			"救命，救命，救——命——啊！！",
		)
		cry_alone_messages = list(
			"不——别丢下我啊啊啊！！",
			"呜，大家都去哪里了啊啊啊，呜哇！！",
			"谁都好，来个人把我抱起来啊！！",
			"我不该受这种委屈啊啊啊！！",
			"我挨一下就会死的啊啊啊！！",
			"我不——会——掉好装备的啊啊啊！！",
		)
	AddComponent(/datum/component/keep_me_secure, CALLBACK(src, PROC_REF(secured_process)) , CALLBACK(src, PROC_REF(unsecured_process)), 0)

/obj/item/toy/plush/whiny_plushie/proc/secured_process(last_move)
	icon_state = initial(icon_state)

/obj/item/toy/plush/whiny_plushie/proc/unsecured_process(last_move)
	if(!COOLDOWN_FINISHED(src, cry_cooldown))
		return
	COOLDOWN_START(src, cry_cooldown, 10 SECONDS)
	icon_state = "plushie_whiny_crying"
	if(isturf(loc))
		say(pick(cry_alone_messages))
	else
		say(pick(cry_still_messages))
	playsound(src, 'sound/items/intents/Help.ogg', 50, FALSE)

/obj/item/toy/plush/beeplushie
	name = "蜜蜂玩偶"
	desc = "一个可爱玩具，模样像更加可爱的蜜蜂。"
	icon_state = "plushie_h"
	inhand_icon_state = null
	attack_verb_continuous = list("蜇刺")
	attack_verb_simple = list("蜇刺")
	gender = FEMALE
	squeak_override = list('sound/mobs/humanoids/moth/scream_moth.ogg'=1)

/obj/item/toy/plush/moth
	name = "蛾人玩偶"
	desc = "一只模样像可爱蛾人的玩偶。是只可以抱抱的小虫！"
	icon_state = "moffplush"
	inhand_icon_state = null
	attack_verb_continuous = list("振翅", "拍翅")
	attack_verb_simple = list("振翅", "拍翅")
	squeak_override = list('sound/mobs/humanoids/moth/scream_moth.ogg'=1)
///Used to track how many people killed themselves with item/toy/plush/moth
	var/suicide_count = 0

/obj/item/toy/plush/moth/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]凝视着[src]的眼睛，它开始吞噬[user]！看起来是想自杀！"))
	suicide_count++
	if(suicide_count < 3)
		desc = "一只模样像令人不安的蛾人的玩偶。在杀死[suicide_count]个人后，它看起来已经不那么适合抱抱了……"
	else
		desc = "一只模样像诡异蛾人的玩偶。它已经杀死[suicide_count]个人了！我想我不想再抱它了！"
		divine = TRUE
		resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	playsound(src, 'sound/effects/hallucinations/wail.ogg', 50, TRUE, -1)
	var/list/available_spots = get_adjacent_open_turfs(loc)
	if(available_spots.len) //If the user is in a confined space the plushie will drop normally as the user dies, but in the open the plush is placed one tile away from the user to prevent squeak spam
		var/turf/open/random_open_spot = pick(available_spots)
		forceMove(random_open_spot)
	user.dust(just_ash = FALSE, drop_items = TRUE)
	return MANUAL_SUICIDE

/obj/item/toy/plush/pkplush
	name = "维和半机械人玩偶"
	desc = "一只模样像维和半机械人的玩偶。只有你能阻止人类受到伤害！"
	icon_state = "pkplush"
	attack_verb_continuous = list("拥抱", "挤压")
	attack_verb_simple = list("拥抱", "挤压")
	squeak_override = list('sound/items/weapons/thudswoosh.ogg'=1)

/obj/item/toy/plush/rouny
	name = "奔行异形玩偶"
	desc = "一只模样像奔行异形的玩偶，为纪念LV-426之战百周年而制作。比真家伙适合抱多了。"
	icon_state = "rouny"
	inhand_icon_state = null
	attack_verb_continuous = list("劈砍", "撕咬", "冲撞")
	attack_verb_simple = list("劈砍", "撕咬", "冲撞")
	squeak_override = list('sound/items/intents/Help.ogg' = 1)

/obj/item/toy/plush/abductor
	name = "绑架者玩偶"
	desc = "一只模样像外星绑架者的玩偶，标签上写着无法辨认的语言。"
	icon_state = "abductor"
	inhand_icon_state = null
	attack_verb_continuous = list("绑架", "探查")
	attack_verb_continuous = list("绑架", "探查")
	squeak_override = list('sound/ambience/weather/ashstorm/inside/weak_end.ogg' = 1) //very faint sound since abductors are silent as far as "speaking" is concerned.

/obj/item/toy/plush/abductor/agent
	name = "绑架者特工玩偶"
	desc = "一只模样像外星绑架者特工的玩偶。电击棍固定在玩偶手上，看起来没有启动。我可不想和它单独待着。"
	icon_state = "abductor_agent"
	inhand_icon_state = null
	attack_verb_continuous = list("绑架", "探查", "击晕")
	attack_verb_continuous = list("绑架", "探查", "击晕")
	squeak_override = list(
		'sound/items/weapons/egloves.ogg' = 2,
		'sound/items/weapons/cablecuff.ogg' = 1,
	)

/obj/item/toy/plush/shark
	name = "鲨鱼玩偶"
	desc = "一只略带卡通风格的鲨鱼玩偶。标签称它为'哈卡尔'，并注明产自旧斯堪的纳维亚一家不知名的家具制造商。"
	lefthand_file = 'icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/plushes_righthand.dmi'
	icon_state = "blahaj"
	inhand_icon_state = "blahaj"
	attack_verb_continuous = list("啃咬", "咬啮", "咀嚼")
	attack_verb_simple = list("啃咬", "咬啮", "咀嚼")

/obj/item/toy/plush/donkpocket
	name = "当克口袋饼玩偶"
	desc = "老练叛徒首选的毛绒伙伴。"
	icon_state = "donkpocket"
	attack_verb_continuous = list("当克一击")
	attack_verb_simple = list("当克一击")

/obj/item/toy/plush/human
	name = "人类玩偶"
	desc = "这是一只人类毡布玩偶，做工极其低劣。人类在哭泣。人类在尖叫。"
	icon_state = "plushie_human"
	inhand_icon_state = null //i would rather not have a blue coder plushie inhand
	attack_verb_continuous = list("尖叫威吓", "击打", "猛砸")
	attack_verb_simple = list("尖叫威吓", "击打", "猛砸")
	squeak_override = list(
		'sound/mobs/humanoids/human/scream/malescream_2.ogg' = 10, //10% chance to scream, rare but not abysmal
		'sound/items/weapons/smash.ogg' = 90,
		)

/obj/item/toy/plush/horse
	name = "马玩偶"
	desc = "一只软绵绵的马玩偶，毛色为骝色，四蹄带有白袜斑。"
	icon_state = "horse"
	attack_verb_continuous = list("嘶鸣", "疾驰", "腾跃", "马击")  // Yes I'm using horse as a verb
	attack_verb_simple = list("嘶鸣", "疾驰", "腾跃", "马击")

/obj/item/toy/plush/unicorn
	name = "独角兽玩偶"
	desc = "一只软绵绵的独角兽玩偶，散发着魔法气息。"
	icon_state = "unicorn"
	attack_verb_continuous = list("嘶鸣", "疾驰", "腾跃", "施法")
	attack_verb_simple = list("嘶鸣", "疾驰", "腾跃", "施法")

/obj/item/toy/plush/monkey
	name = "猴子玩偶"
	desc = "标签上写着：'呜叽！我是黑猩猩！'，背面则是'现推出巨无霸尺寸！'。"
	w_class = WEIGHT_CLASS_BULKY
	throw_range = 2
	throw_speed = 1
	icon_state = "monkey"
	inhand_icon_state = null
	attack_verb_continuous = list("呜叫", "叽叫")
	attack_verb_simple = list("呜叫", "叽叫")
	squeak_override = list(SFX_SCREECH=1)
	/// if the monkey ate a mimana and has changed nationality
	var/french = FALSE

/obj/item/toy/plush/monkey/item_interaction(mob/living/feeder, obj/item/food/grown/banana/nana, list/modifiers)
	if(!istype(nana))
		return ..()
	nana.forceMove(src) // go into the cotton stomach
	to_chat(feeder, span_notice("你把[nana]递给[src]，看着它吃起来……"))
	playsound(src, 'sound/items/eatfood.ogg', 75, TRUE)
	addtimer(CALLBACK(src, PROC_REF(eat), feeder, nana), 3 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/plush/monkey/proc/eat(mob/living/feeder, obj/item/food/grown/banana/nana)
	if(istype(nana, /obj/item/food/grown/banana/bluespace))
		do_teleport(src, get_turf(src), 15, channel = TELEPORT_CHANNEL_BLUESPACE)
	else if(istype(nana, /obj/item/food/grown/banana/mime) && !french)
		name = "猴子毛绒玩偶"
		desc = "标签上写着：'呜叽！我是黑猩猩！'，背面则是'现推出巨无霸尺寸！'。"
		french = TRUE
	// throw the peel at a random mob, or a random turf if there are none
	var/obj/item/grown/bananapeel/peel = new nana.trash_type(get_turf(src))
	var/list/oviewers = oviewers(peel.throw_range, src)
	var/throw_src = src
	// if a player holds the plushie, the throw source will be the player
	if(isliving(loc))
		oviewers = oviewers(loc)
		throw_src = loc
	if(oviewers.len > 0 && (locate(feeder) in oviewers))
		oviewers -= feeder // remove feeder from targetables
	peel.throw_at(oviewers.len == 0 ? get_ranged_target_turf(throw_src, pick(GLOB.alldirs), peel.throw_range) : pick(oviewers), peel.throw_range, peel.throw_speed, quickstart = FALSE)
	playsound(src, 'sound/mobs/non-humanoids/gorilla/gorilla.ogg', 100, FALSE)
	spasm_animation(5 SECONDS)
	qdel(nana)
