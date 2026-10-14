/datum/splat/werewolf/proc/examine_other_human(mob/living/carbon/examined)
	var/datum/splat/werewolf/wolp_splat = get_werewolf_splat(examined)
	if(wolp_splat)
		var/list/honor_flavor = list("端正品行", "荣誉事迹", "侠义之举")
		var/list/wisdom_flavor = list("独到见解", "智慧之举", "卓越远见")
		var/list/glory_flavor = list("勇敢之举", "英勇事迹", "荣耀功绩")

		var/same_tribe = FALSE
		var/is_known = FALSE

		if(!tribe)
			return
		if(!wolp_splat.tribe || !wolp_splat.auspice)
			return
		if(tribe.name == wolp_splat.tribe.name)
			same_tribe = TRUE

		switch(wolp_splat.renown_rank)
			if(RANK_CUB to RANK_FOSTERN)
				if(same_tribe)
					. += "<b>你认得[examined]，是[FERA_DISPLAY_NAME(wolp_splat.tribe.name)]的[fera_rank_name(wolp_splat.renown_rank, wolp_splat.id)]。</b>"
					is_known = TRUE
			if(RANK_ADREN to RANK_LEGEND)
				. += "<b>你认得[examined]，是[FERA_DISPLAY_NAME(wolp_splat.tribe.name)]的[fera_rank_name(wolp_splat.renown_rank, wolp_splat.id)]，月相为[FERA_DISPLAY_NAME(wolp_splat.auspice.name)]。</b>"
				is_known = TRUE

		if(is_known)
			switch(wolp_splat.renown[RENOWN_HONOR])
				if(4,5,6)
					. += "<i>你听当地狼人提起过[examined]的[honor_flavor[1]]。</i>"
				if(7,8,9)
					. += "<i>你听当地狼人提起过[examined]的[honor_flavor[2]]。</i>"
				if(10)
					. += "<i>你听当地狼人提起过[examined]的[honor_flavor[3]]。</i>"
			switch(wolp_splat.renown[RENOWN_WISDOM])
				if(4,5,6)
					. += "<i>你听当地狼人提起过[examined]的[wisdom_flavor[1]]。</i>"
				if(7,8,9)
					. += "<i>你听当地狼人提起过[examined]的[wisdom_flavor[2]]。</i>"
				if(10)
					. += "<i>你听当地狼人提起过[examined]的[wisdom_flavor[3]]。</i>"
			switch(wolp_splat.renown[RENOWN_GLORY])
				if(4,5,6)
					. += "<i>你听当地狼人提起过[examined]的[glory_flavor[1]]。</i>"
				if(7,8,9)
					. += "<i>你听当地狼人提起过[examined]的[glory_flavor[2]]。</i>"
				if(10)
					. += "<i>你听当地狼人提起过[examined]的[glory_flavor[3]]。</i>"
