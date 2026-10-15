// extra fluff text for examines
/mob/proc/p_handsome_gorgeous(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	var/list/male_descriptors = list("英俊", "迷人", "符合大众审美的俊朗")
	var/list/female_descriptors = list("惊艳", "美艳", "性感", "美丽", "漂亮")
	var/list/other_descriptors = list("很迷人，但你难以辨认其性别", "性感……还是英俊？总之很迷人", "美得令人惊叹", "美得让人心神不宁", "美丽")
	if(temp_gender == MALE)
		return pick(male_descriptors)
	if(temp_gender == FEMALE)
		return pick(female_descriptors)
	return pick(pick(other_descriptors), pick(male_descriptors), pick(female_descriptors)) // drank all the gender fluid

/mob/living/carbon/proc/display_darkpack_examine_text(mob/user)
	. = list()
	// WEREWOLF
	var/datum/splat/werewolf/werewolf_splat = get_werewolf_splat(user)
	if(werewolf_splat && !(obscured_slots & HIDEFACE))
		. += werewolf_splat.examine_other_human(src)
	// WEREWOLF

/mob/living/carbon/human/display_darkpack_examine_text(mob/user)
	. = ..()

	var/list/zero = list("丑得吓人。这是在搞什么糟糕的角色扮演吗……？", "天啊，简直像是从恐怖片里走出来的！", "老天，这也太丑了。", "丑得你几乎要哭出来。")
	var/list/one = list("哎呀。这副长相实在不太顺眼。", "光是看着对方，你就忍不住微微皱眉。", "显然，有人没抽中基因彩票。", "这长相肯定赢不了选美比赛。")
	var/list/two = list("长相相当普通，没什么值得一提的。", "论相貌，既不出众也不难看。", "外表完全平平无奇。", "简直就是“相貌平平”的典范。", "算不上好看，但也不难看。")
	var/list/three = list("对方看起来颇有吸引力。", "总的来说，这张脸让人看着很舒服。", "颇有魅力。", "对方[p_handsome_gorgeous()]。")
	var/list/four = list("对方相当迷人。", "让人赏心悦目。", "明显是个好看的人。", "你发现自己正盯着对方看。")
	var/list/five = list("对方的相貌格外出众。", "对方[p_handsome_gorgeous()]。", "路人很难不注意到对方。", "你发现自己的目光不由自主地被对方吸引。", "对方好看得令人印象深刻。", "对方走过时，人们纷纷回头。")
	if(obscured_slots & HIDEFACE)
		return

	if(HAS_TRAIT(src, TRAIT_MASQUERADE_VIOLATING_FACE) || HAS_TRAIT(src, TRAIT_MASQUERADE_VIOLATING_EYES))
		switch(get_clan()?.alt_sprite)
			if("nosferatu")
				. += span_warning("对方的模样极度畸形，完全不像人类！<br>")
			if("gargoyle")
				. += span_warning("对方似乎是由石头构成的！<br>")
			if("kiasyd")
				if (!is_eyes_covered())
					. += span_boldwarning("对方的眼睛没有眼白！</b><br>")
			if("rotten1")
				. += span_warning("对方显得异常枯瘦。<br>")
			if("rotten2")
				. += span_warning("对方面色如同死尸。<br>")
			if("rotten3")
				. += span_boldwarning("对方是一具腐烂的尸体！<br>")
			if("rotten4")
				. += span_boldwarning("对方是一具只剩骨架的尸体！</b><br>")

	if(iszomboid(src) && !(obscured_slots & HIDEFACE)) // for necromancy player-controlled zombies
		. += span_danger("<b>对方是一具腐烂的尸体！</b><br>")

	if(HAS_TRAIT(src, TRAIT_SERPENTIS_SKIN) && !(HIDEJUMPSUIT)) // 'hidden by modest clothing'
		. += span_danger("对方浑身长满了……鳞片！？<br>")

	if(HAS_TRAIT(src, TRAIT_ANIMAL_MUSK))
		. += span_warning("对方身上有股奇怪的动物气味……<br>")

	if(HAS_TRAIT(src, TRAIT_GRAVE_SMELL))
		. += span_warning("对方身上有雨后泥土和新翻土壤的气味。<br>")

	if(HAS_TRAIT(src, TRAIT_BEACON_OF_THE_UNHOLY))
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.mind.holy_role)
				. += span_cult("对方散发着清晰可感的邪恶气息！这人很不对劲！")

	if((!is_eyes_covered()) && HAS_TRAIT(src, TRAIT_GLOWING_EYES))
		. += span_warning("对方的双眼发出诡异的光！<br>")

	if((!is_eyes_covered()) && HAS_TRAIT(src, TRAIT_REFLECTIVE_EYES))
		. += span_warning("对方的双眼泛着诡异的亮光！<br>")

	if((!is_eyes_covered()) && HAS_TRAIT(src, TRAIT_ABYSSAL_EYES))
		. += span_warning("对方的双眼漆黑如墨！<br>")

	if(!(obscured_slots & HIDEFACE))
		switch(st_get_stat(STAT_APPEARANCE))
			if(0)
				. += span_bolddanger("[pick(zero)]<br>")
			if(1)
				. += span_danger("[pick(one)]<br>")
			if(2)
				. += span_notice("[pick(two)]<br>")
			if(3)
				. += span_nicegreen("[pick(three)]<br>")
			if(4)
				. += span_purple("[pick(four)]<br>")
			if(5 to INFINITY)
				. += span_rose(span_bold("[pick(five)]<br>"))
		if(HAS_TRAIT(src, TRAIT_PERMAFANGS) && !HAS_TRAIT(src, TRAIT_DULLFANGS))
			. += span_warning("对方口中的尖牙清晰可见。<br>")
		if(HAS_TRAIT(src, TRAIT_DISFIGURED_APPEARANCE))
			. += span_warning("对方明显毁了容。<br>")
	if(!src.head)
		if(HAS_TRAIT(src, TRAIT_THIRD_EYE))
			. += span_bolddanger("对方额头上长着第三只眼！<br>")
		if(HAS_TRAIT(src, TRAIT_BETRAYERS_MARK))
			if(isliving(user))
				var/mob/living/living_user = user
				if(living_user.is_clan(/datum/subsplat/vampire_clan/tremere))
					. += span_bolddanger("对方额头上有一个发光的“T”——这是背叛睿魔尔氏族的背叛者烙印！<br>")
