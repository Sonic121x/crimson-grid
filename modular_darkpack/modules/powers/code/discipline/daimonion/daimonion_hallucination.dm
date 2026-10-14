/obj/effect/client_image_holder/baali_demon
	name = "炼狱恶魔"
	image_icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	image_state = "baali"
	var/mob/living/target //person who had daimonion 4 used on them
	COOLDOWN_DECLARE(move_cooldown)

/obj/effect/client_image_holder/baali_demon/Initialize(mapload, list/mobs_which_see_us)
	. = ..()
	for(var/mob/living/possible_target as anything in mobs_which_see_us)
		target = possible_target
		break // daimonion only has a demon chasing after one target at a time but parent init asks for a list.
	var/turf/closed/wall = locate(/turf/closed) in range(7, target)
	if(!wall)
		return INITIALIZE_HINT_QDEL
	forceMove(wall)
	target.playsound_local(wall, 'sound/effects/meteorimpact.ogg', 150, TRUE)
	RegisterSignal(src, COMSIG_BAALI_DEMON_REACHED_TARGET, PROC_REF(on_reached_target))
	START_PROCESSING(SSfastprocess, src)

/obj/effect/client_image_holder/baali_demon/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	target = null
	return ..()

/obj/effect/client_image_holder/baali_demon/process(seconds_per_tick)
	if(QDELETED(target) || target.stat == DEAD)
		qdel(src)
		return
	if(!COOLDOWN_FINISHED(src, move_cooldown))
		return
	setDir(get_dir(src, target))
	forceMove(get_step_towards(src, target))
	target.playsound_local(get_turf(src), 'sound/effects/meteorimpact.ogg', 150, TRUE)
	if(Adjacent(target))
		SEND_SIGNAL(src, COMSIG_BAALI_DEMON_REACHED_TARGET, target)
		qdel(src)
	COOLDOWN_START(src, move_cooldown, 0.4 SECONDS)

/obj/effect/client_image_holder/baali_demon/proc/on_reached_target(datum/source, mob/living/victim)
	SIGNAL_HANDLER
	on_contact(victim)
	step_away(victim, get_turf(src))

/obj/effect/client_image_holder/baali_demon/spectre
	name = "幽魂"
	image_icon = 'modular_darkpack/modules/deprecated/icons/mob.dmi'
	image_state = "shade"

/obj/effect/client_image_holder/baali_demon/wyrm
	name = "妖蛆化身"
	image_icon = 'modular_darkpack/modules/deprecated/icons/48x64.dmi'
	image_state = "bigskeleton"

/obj/effect/client_image_holder/baali_demon/tremere
	name = "回收者"
	image_icon = 'modular_darkpack/modules/deprecated/icons/48x64.dmi'
	image_state = "4armstzi"

/obj/effect/client_image_holder/baali_demon/banu
	name = "秘识大师"
	image_icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/the_antediluvian.dmi'
	image_state = "eva"

/obj/effect/client_image_holder/baali_demon/proc/on_contact(mob/living/victim)
	victim.visible_message(span_warning("[victim]双膝跪地。"), span_warning("[src.name]用双手抓住你的头。"))
	// CRIMSON GRID ADD: DARK THAUMATURGY
	victim.Immobilize(3 SECONDS)
	if(victim.body_position == STANDING_UP)
		victim.toggle_resting()
	// CRIMSON GRID ADD END: DARK THAUMATURGY
	victim.playsound_local(src, 'modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh1.ogg', 50, FALSE)
	to_chat(victim, span_cult("地狱真实存在，它已经触碰到了我！"))

/obj/effect/client_image_holder/baali_demon/spectre/on_contact(mob/living/victim)
	victim.visible_message(span_warning("[victim]瘫倒在地。"), span_warning("[src.name]伸出手触碰你。"))
	// CRIMSON GRID ADD: DARK THAUMATURGY
	victim.Immobilize(3 SECONDS)
	if(victim.body_position == STANDING_UP)
		victim.toggle_resting()
	// CRIMSON GRID ADD END: DARK THAUMATURGY
	to_chat(victim, span_cult("那个灵体从我身上夺走了什么！"))

/obj/effect/client_image_holder/baali_demon/wyrm/on_contact(mob/living/victim)
	victim.visible_message(span_warning("[victim]惊恐地发出野兽般的呜咽。"), span_cult("妖蛆注意到我了！"))
	// CRIMSON GRID ADD: DARK THAUMATURGY
	victim.Immobilize(3 SECONDS)
	if(victim.body_position == STANDING_UP)
		victim.toggle_resting()
	// CRIMSON GRID ADD END: DARK THAUMATURGY
	victim.playsound_local(src, 'modular_darkpack/modules/powers/sounds/daimonion_laughs/malklaugh.ogg', 50, FALSE)

/obj/effect/client_image_holder/baali_demon/banu/on_contact(mob/living/victim)
	victim.visible_message(span_warning("[victim]捂住胸口，摸索着仿佛存在的空洞。"), span_cult("[src.name]挖出了你的心脏！"))
	// CRIMSON GRID ADD: DARK THAUMATURGY
	victim.Immobilize(3 SECONDS)
	if(victim.body_position == STANDING_UP)
		victim.toggle_resting()
	// CRIMSON GRID ADD END: DARK THAUMATURGY

/obj/effect/client_image_holder/baali_demon/tremere/on_contact(mob/living/victim)
	victim.visible_message(span_warning("[victim]倒地抽搐。"), span_cult("[src.name]夺走了你的血粹！"))
	victim.playsound_local(src, 'modular_darkpack/modules/powers/sounds/daimonion_laughs/malklaugh.ogg', 50, FALSE)
	// CRIMSON GRID ADD: DARK THAUMATURGY
	victim.Immobilize(3 SECONDS)
	if(victim.body_position == STANDING_UP)
		victim.toggle_resting()
	// CRIMSON GRID ADD END: DARK THAUMATURGY
