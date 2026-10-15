
/// how much health healed from casting a chuuni spell
#define CHUUNIBYOU_HEAL_AMOUNT 3
///cooldown between healing to prevent stuff like instant blink spell spam healing
#define CHUUNIBYOU_COOLDOWN_TIME 5 SECONDS

/**
 * ## chuunibyou component!
 *
 * Component that makes casted spells always a shout invocation, a very dumb one. And their projectiles are dumb too.
 * Oh, but it does heal after each spell cast.
 */
/datum/component/chuunibyou
	/// invocations per school the spell is from
	var/static/list/chuunibyou_invocations
	/// amount healed per spell cast
	var/heal_amount = CHUUNIBYOU_HEAL_AMOUNT
	/// cooldown for healing
	COOLDOWN_DECLARE(heal_cooldown)
	/// are we casting a spell right now
	var/casting_spell = FALSE

/datum/component/chuunibyou/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	if(!chuunibyou_invocations)
		chuunibyou_invocations = list(
			SCHOOL_UNSET = "太丢脸了……我想不起咒词了……呃……也许这样挥挥手就行……不，还是没——啊！出来了！",
			SCHOOL_HOLY = "承蒙圣者恩典，我召来救赎之光。愿吾之同伴欢欣。苍天啊！赐予他们祝福！",
			SCHOOL_PSYCHIC = "凭借隐秘之主的奥秘，我揭示创世真理。让我的心智拓展。玄秘啊！启迪我吧！",
			SCHOOL_MIME = "寂静啊！拥抱我的灵魂，赋予我的手势力量。让我创造幻象，操纵感知！",
			SCHOOL_RESTORATION = "我呼唤慈悲女神之名，聆听我的祈求，赐福于这个灵魂！神圣恩典！",

			SCHOOL_EVOCATION = "见识漆黑烈焰使的终极力量吧！我召唤远古的混沌与毁灭之力，将怒火倾泻于吾之敌！",
			SCHOOL_TRANSMUTATION = "我援引等价交换之律，维系宇宙之衡。我献上此祭，索求新的造物。显现吧，炼化的奥秘！",
			SCHOOL_TRANSLOCATION = "凭借空间裂隙之力，我扭曲现实，跨越维度！在我抵达目的地的路上，万物皆不可阻挡！",
			SCHOOL_CONJURATION = "以命运之眼，我看穿宿命的丝线。万物皆无所遁形。见证我吧，见证显现的奇迹！",

			SCHOOL_NECROMANCY = "我是亡者之君、白骨之主、暗影之王。我命令受诅咒的军团从坟墓中崛起，为我效命！",
			SCHOOL_FORBIDDEN = "我舍弃此世的法则，拥抱古神的混沌！让禁忌之力流贯我身，摧毁沿途的一切！",
			SCHOOL_SANGUINE = "我以眼罩封印真正的力量，如今便向你释放。我吞噬猎物的生命之力，每一滴都让我更加强大！",
		)

/datum/component/chuunibyou/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOB_SPELL_PROJECTILE, PROC_REF(on_spell_projectile))
	RegisterSignal(parent, COMSIG_MOB_PRE_INVOCATION, PROC_REF(on_pre_invocation))
	RegisterSignal(parent, COMSIG_MOB_TRY_SPEECH, PROC_REF(on_try_speech))
	RegisterSignal(parent, COMSIG_MOB_AFTER_SPELL_CAST, PROC_REF(on_after_spell_cast))
	ADD_TRAIT(parent, TRAIT_CHUUNIBYOU, REF(src))

/datum/component/chuunibyou/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(
		COMSIG_MOB_SPELL_PROJECTILE,
		COMSIG_MOB_PRE_INVOCATION,
		COMSIG_MOB_TRY_SPEECH,
		COMSIG_MOB_AFTER_SPELL_CAST,
	))
	REMOVE_TRAIT(parent, TRAIT_CHUUNIBYOU, REF(src))

/// signal sent when the parent tries to speak. we let speech pass if we are casting a spell so mimes still chuuni their spellcasts
/// (this may end in the mime dying)
/datum/component/chuunibyou/proc/on_try_speech(datum/source, message, ignore_spam, forced)
	SIGNAL_HANDLER

	if(casting_spell && !HAS_TRAIT(src, TRAIT_MUTE))
		return COMPONENT_IGNORE_CAN_SPEAK

///signal sent when the parent casts a spell that has a projectile
/datum/component/chuunibyou/proc/on_spell_projectile(mob/living/source, datum/action/cooldown/spell/spell, atom/cast_on, obj/projectile/to_fire)
	SIGNAL_HANDLER

	playsound(to_fire,'sound/effects/magic/staff_change.ogg', 75, TRUE)
	to_fire.color = "#f825f8"
	to_fire.name = "中二的[to_fire.name]"
	to_fire.set_light(2, 2, LIGHT_COLOR_PINK, l_on = TRUE)

///signal sent before parent invokes a spell
/datum/component/chuunibyou/proc/on_pre_invocation(mob/living/source, datum/action/cooldown/spell/spell, list/invocation_list)
	SIGNAL_HANDLER

	// this makes it bypass speech checks (being a mime) until the spell is done casting
	// this lets mimes cast with it, but, um... might get them lynched
	casting_spell = TRUE
	invocation_list[INVOCATION_TYPE] = INVOCATION_SHOUT
	invocation_list[INVOCATION_GARBLE_PROB] = 0
	var/chuuni_invocation = chuunibyou_invocations[spell.school]
	if(!chuuni_invocation) // someone forgot to update the CHUUNI LIST to include a desc for the new school
		stack_trace("Chunnibyou invocations is missing a line for spell school \"[spell.school]\"")
		chuuni_invocation = chuunibyou_invocations[SCHOOL_UNSET]
	invocation_list[INVOCATION_MESSAGE] = chuuni_invocation

///signal sent after parent casts a spell
/datum/component/chuunibyou/proc/on_after_spell_cast(mob/living/source, datum/action/cooldown/spell/spell, atom/cast_on)
	SIGNAL_HANDLER

	casting_spell = FALSE
	if(!COOLDOWN_FINISHED(src, heal_cooldown))
		to_chat(source, span_danger("你的中二之力尚在冷却！治疗失败！"))
		return
	COOLDOWN_START(src, heal_cooldown, CHUUNIBYOU_COOLDOWN_TIME)

	source.heal_overall_damage(heal_amount)
	playsound(source, 'sound/effects/magic/staff_healing.ogg', 30)
	to_chat(source, span_danger("你感觉中二之力稍微治愈了你。"))

/datum/component/chuunibyou/no_healing
	heal_amount = 0

#undef CHUUNIBYOU_HEAL_AMOUNT
#undef CHUUNIBYOU_COOLDOWN_TIME
