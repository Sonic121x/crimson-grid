/datum/splat/vampire/kindred/proc/adjust_morality(mob/living/carbon/human/owner, value, limit, forced, difficulty = 6)
	SIGNAL_HANDLER

	// "Enlightenment" is essentially the Path of Pure Evil. Inverts Humanity changes and limits.
	var/is_enlightenment = owner.is_enlightenment()
	var/path = is_enlightenment ? "启迪" : "人性"
	if (is_enlightenment && !forced)
		value = -value
		limit = 10 - limit

	// Work out actual change in Humanity
	var/new_humanity
	var/humanity_change
	if (value > 0)
		new_humanity = clamp(owner.st_get_stat(STAT_MORALITY) + value, 0, limit)
		humanity_change = new_humanity - owner.st_get_stat(STAT_MORALITY)

		// Hit the limit for increase, no change
		if (humanity_change <= 0)
			return
	else if (value < 0)
		var/loss_modifier = HAS_TRAIT(owner, TRAIT_SENSITIVE_HUMANITY) ? 2 : 1
		value *= loss_modifier

		new_humanity = clamp(owner.st_get_stat(STAT_MORALITY) + value, limit, 10)
		humanity_change = new_humanity - owner.st_get_stat(STAT_MORALITY)

		// Hit the limit for decrease, no change
		if (humanity_change >= 0)
			return
	else
		return

	//before going any further, roll either conscience or conviction to determine if we actually lose path/humanity
	if(humanity_change < 0)
		var/stat_to_roll = is_enlightenment ? STAT_CONVICTION : STAT_CONSCIENCE
		var/datum/storyteller_roll/degeneration_roll = new()
		degeneration_roll.applicable_stats = list(stat_to_roll)
		degeneration_roll.difficulty = difficulty
		degeneration_roll.roll_output_type = ROLL_FLAG_ROLLER|ROLL_FLAG_ADMIN
		var/roll_result = degeneration_roll.st_roll(owner)

		if(roll_result == ROLL_SUCCESS)
			to_chat(owner, span_green("你成功为自己的行为找到了理由，[is_enlightenment ? "信念" : "良知"]使你的[path]免于降低！"))
			return
		else
			to_chat(owner, span_danger("你无法为自己的行为辩解，体内的心兽正在苏醒……"))

	var/signal_return = SEND_SIGNAL(owner, COMSIG_LIVING_CHANGING_HUMANITY, humanity_change)
	if (signal_return & BLOCK_HUMANITY_CHANGE)
		return

	// Change morality according to calculated values
	owner.st_set_stat(STAT_MORALITY, owner.st_get_stat(STAT_MORALITY) + humanity_change)
	if (humanity_change > 0)
		SEND_SOUND(owner, sound('modular_darkpack/modules/deprecated/sounds/humanity_gain.ogg', volume = 75))
		to_chat(owner, span_boldnicegreen("[uppertext(path)]提升了！"))

		// Gaining Path flavour text
		switch (owner.st_get_stat(STAT_MORALITY))
			if (10)
				to_chat(owner, span_green("你的[path]达到顶峰，你感到心兽[is_enlightenment ? "与你达成了完美的和谐" : "陷入沉睡，静候时机"]。"))
	else if (humanity_change < 0)
		SEND_SOUND(owner, sound('modular_darkpack/modules/deprecated/sounds/humanity_loss.ogg', volume = 75))
		to_chat(owner, span_userdanger(span_bold("[uppertext(path)]降低了！")))

		// Losing Path flavour text
		switch (owner.st_get_stat(STAT_MORALITY))
			if (1)
				to_chat(owner, span_userdanger(span_bold("鲜血。进食。饥渴。")))
			if (2)
				to_chat(owner, span_userdanger("你正在失去理智。[span_bold("心兽")]正在支配你。"))
			if (3)
				to_chat(owner, span_danger("你的理性正在瓦解。心兽正逐渐夺取控制权……"))
			if (4)
				to_chat(owner, span_danger("你感到心兽正啃噬着你的理智……"))
			if (9)
				to_chat(owner, span_warning("你的[path]不再完美，你感到心兽[is_enlightenment ? "开始掌控灵魂的黑暗角落" : "在灵魂的黑暗角落中重新苏醒"]。"))

	SEND_SIGNAL(owner, COMSIG_LIVING_CHANGED_HUMANITY, humanity_change)
