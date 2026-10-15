#define MAX_RENOWN 10

/datum/splat/werewolf/proc/adjust_renown(attribute, amount)
	if(!renown[attribute])
		renown[attribute] = 0


	var/old_rank = renown_rank
	var/new_amount = clamp(renown[attribute] + amount, 0, MAX_RENOWN)

	renown[attribute] = new_amount
	if(amount < 0)
		to_chat(owner, span_userdanger("你感到[get_negative_emotion(attribute)]！"))
	else if(amount > 0)
		to_chat(owner, span_bold("你感到[get_positive_emotion(attribute)]！"))

	switch(attribute)
		if(RENOWN_HONOR)
			owner.write_preference_midround(/datum/preference/numeric/renown/honor, new_amount)
		if(RENOWN_GLORY)
			owner.write_preference_midround(/datum/preference/numeric/renown/glory, new_amount)
		if(RENOWN_WISDOM)
			owner.write_preference_midround(/datum/preference/numeric/renown/wisdom, new_amount)

	renown_rank = auspice_rank_check()
	if(old_rank != renown_rank)
		to_chat(owner, span_boldnotice("你现在的位阶是[fera_rank_name(renown_rank, id)]。"))

	// Not acctually used ANYWHERE rn. Its super easy to just calculate it from our renown anyway.
	// owner.write_preference_midround(/datum/preference/numeric/fera_rank, renown_rank)


/datum/splat/werewolf/proc/get_negative_emotion(attribute)
	switch(attribute)
		if(RENOWN_HONOR)
			return "羞愧"

		if(RENOWN_GLORY)
			return "屈辱"

		if(RENOWN_WISDOM)
			return "自己很愚蠢"

	return "茫然"

/datum/splat/werewolf/proc/get_positive_emotion(attribute)
	switch(attribute)

		if(RENOWN_HONOR)
			return "自己得到了认可"

		if(RENOWN_GLORY)
			return "勇气倍增"

		if(RENOWN_WISDOM)
			return "头脑敏锐"

	return "自信"


/datum/splat/werewolf/proc/auspice_rank_check()
	if(!auspice)
		return RANK_CUB
	return auspice.rank_requirments(renown)

// Pretty iffy on this. This could likely just be moved onto the splat itself so corax and other breeds can override it.
/proc/fera_rank_name(rank, breed)
	switch(breed)
		if(SPLAT_CORAX)
			switch(rank)
				if(RANK_CUB)
					return "雏鸦"
				if(RANK_CLIATH)
					return "初羽"
				if(RANK_FOSTERN)
					return "新鸦"
				if(RANK_ADREN)
					return "展翼"
				if(RANK_ATHRO)
					return "翔羽"
				if(RANK_ELDER)
					return "鸦长"
				if(RANK_LEGEND)
					return "灰羽贤者"
		else
			switch(rank)
				if(RANK_CUB)
					return "幼崽" // in lowercase so that \a might function during the character examine
				if(RANK_CLIATH)
					return "幼徒"
				if(RANK_FOSTERN)
					return "同伴"
				if(RANK_ADREN)
					return "贤者"
				if(RANK_ATHRO)
					return "导师"
				if(RANK_ELDER)
					return "长老"
				if(RANK_LEGEND)
					return "传奇"

#undef MAX_RENOWN
