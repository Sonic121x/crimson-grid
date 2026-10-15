/mob/living/proc/torpor(source = DAMAGE_TRAIT, force)
	if(HAS_TRAIT(src, TRAIT_TORPOR))
		return

	fakedeath(source)

	to_chat(src, span_danger("你陷入了长眠。点击右上角的按钮了解详情，或尝试苏醒。"))
	throw_alert(ALERT_UNTORPOR, /atom/movable/screen/alert/untorpor)
	ADD_TRAIT(src, TRAIT_TORPOR, source)
	if(get_kindred_splat(src) && !force)
		var/mob/living/carbon/human/vampire = src
		var/datum/splat/vampire/kindred/vampirism = get_kindred_splat(vampire)
		var/morality_score = st_get_stat(STAT_MORALITY)
		var/torpor_time = (14 - morality_score) MINUTES
		COOLDOWN_START(vampirism, torpor_timer, torpor_time)
//	RegisterSignal(new_kindred, COMSIG_PATH_HIT, PROC_REF(adjust_morality))

/mob/living/proc/cure_torpor(source, force)
	if(!HAS_TRAIT_FROM(src, TRAIT_TORPOR, source))
		return

	// Heal to a tiny bit above crit, with less severe damage types being healed first
	var/amount_to_heal = HEALTH_THRESHOLD_CRIT + 5 - health
	if((amount_to_heal > 0) && !force)
		heal_ordered_damage(amount_to_heal, list(STAMINA, OXY, BRUTE, TOX, BURN))

	cure_fakedeath(source)
	clear_alert(ALERT_UNTORPOR)
	REMOVE_TRAIT(src, TRAIT_TORPOR, source)
	to_chat(src, span_notice("你从长眠中苏醒了。"))

/mob/living/proc/untorpor()
	if(!HAS_TRAIT(src, TRAIT_TORPOR))
		return

	if(get_kindred_splat(src))
		if(bloodpool > 0)
			adjust_blood_pool(-1)
			cure_torpor(DAMAGE_TRAIT)
			to_chat(src, span_notice("你从长眠中苏醒了。"))
		else
			to_chat(src, span_warning("你没有可供苏醒的鲜血……"))

/atom/movable/screen/alert/untorpor
	name = "苏醒"
	desc = "从长眠中苏醒。"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "awaken"

/atom/movable/screen/alert/untorpor/Click()
	. = ..()
	if(!.)
		return

	if(!isliving(owner))
		return
	var/mob/living/living_owner = owner

	if(living_owner.stat == DEAD)
		to_chat(living_owner, span_warning("你已迎来终亡，再也无法苏醒。"))
		return

	if(get_kindred_splat(living_owner))
		var/mob/living/carbon/human/vampire = living_owner
		var/datum/splat/vampire/kindred/vampirism = get_kindred_splat(vampire)
		if(!COOLDOWN_STARTED(vampirism, torpor_timer))
			to_chat(owner, span_purple(span_italics("你正处于长眠，这是吸血鬼在受伤、饥饿或筋疲力尽时陷入的死亡般的沉睡。")))
			to_chat(owner, span_danger(span_italics("外力拔出你心脏中的木桩后，你就会苏醒。")))
			return
		if(COOLDOWN_FINISHED(vampirism, torpor_timer) && (vampire.bloodpool > 0))
			vampire.untorpor()
		else
			to_chat(owner, span_purple(span_italics("你正处于长眠，这是吸血鬼在受伤、饥饿或筋疲力尽时陷入的死亡般的沉睡。")))
			if (vampire.bloodpool > 0)
				to_chat(owner, span_purple(span_italics("再过<b>[DisplayTimeText(COOLDOWN_TIMELEFT(vampirism, torpor_timer))]</b>，你就能苏醒。")))
			else
				to_chat(owner, span_danger(span_italics("你无法苏醒，因为你没有可供苏醒的鲜血。")))
