/datum/splat/werewolf/kinfolk/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#C3BA88", update = FALSE)
	human.set_eye_color("B2B2B2", "B2B2B2")
	human.set_hairstyle("Bangs (Diagonal Alt)", update = TRUE)
	human.undershirt = "Shirt (Ian)"
	human.update_body()

// note - we have unused desc vars on splats
/datum/splat/werewolf/kinfolk/get_splat_description()
	return "眷属，也被称为 Gallain 或 Kin，是与变形者有血缘关系的人类或野生动物。他们不会轻易陷入谵妄，但自身并不具备变形能力。"

/datum/splat/werewolf/kinfolk/get_splat_lore()
	return list(
		"虽然眷属比同类出身的狼人更擅长与自己的物种相处，但无论人类眷属还是动物眷属，都已不再完全属于原本的物种。人类眷属带有些许狼性，通常比普通人更具灵性，与自然的联系也更深。动物眷属则比普通同类更有悟性，带着一丝人性，因此在一定程度上有别于其他狼。\n\n眷属与狼人有远近不一的血缘联系，却缺少完成初变所需的灵性要素。他们分为人类与狼两类，其他变形者的眷属则对应各自动物种类；这与盖亚选民特有的人裔、狼裔分类不同。眷属没有怒火，也未获露娜或赫利俄斯赐予月相。\n\n未获这份眷顾也意味着，银对狼人、或金对某些变形者造成的伤害，不会同样作用于他们。盖亚仍比普通人类与动物更眷顾眷属，因此一些杰出的眷属能学会基础天赋，极少数还获赐灵悟，得以使用更强的天赋。盖亚之子与其他部族不同，普遍支持自己的眷属学习治疗与社交天赋。"
	)

/datum/splat/werewolf/shifter/garou/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#502D15", update = FALSE)
	human.set_hairstyle("Long Hair 3", update = TRUE)
	human.undershirt = "Shirt (Alien)"
	human.update_body()

/datum/splat/werewolf/shifter/garou/get_splat_description()
	return "黑暗世界中的狼人，是盖亚创造的变形战士，负责保护自然，抵御腐化、衰败与超自然邪恶，尽管黑螺旋舞者等群体如今已转而侍奉邪恶。他们领地意识极强，对吸血鬼几乎总是怀有暴烈的敌意，是黑暗世界中最危险的生物之一。\n\n对大多数血族而言，狼人是可怕的自然伟力。在城市边界之外遭遇他们，往往意味着突如其来的暴力、自认正义的怒火，以及几乎无法逃脱的死亡。"

/datum/splat/werewolf/shifter/garou/get_splat_lore()
	return list(
		"狼人拥有完整的神话体系，用来解释自身的存在，以及与自然和大地的联系。他们遵循围绕盖亚与三相神展开的创世神话和宇宙观。\n\n三相神由荒野、织者与妖蛆组成，分别代表创造、秩序与毁灭。狼人视自己为盖亚选定的守护者，并相信盖亚就是大地本身。月亮之灵露娜赐予他们灵性力量，也使他们对银有了那广为人知的弱点。\n\n狼人的口述传统认为，三相神曾经保持平衡，使现实与盖亚和谐共存。然而，在污染、大规模工业化和肆意掠夺自然资源的现代，平衡已经破裂，末日浩劫迅速逼近。人类与现代文明的兴起使代表秩序的织者空前强大；随着大地遭到掠夺，妖蛆的毁灭之力也随之增长，荒野的影响不断退缩，三相神由此陷入失衡。\n\n各狼人部族对这段口述历史，以及阻止末日浩劫所需采取的行动，持有不同看法。所谓末日浩劫，就是三相神中的毁灭力量妖蛆压倒织者，得以毫无约束地摧毁、吞噬一切的那一天。",
	)

/datum/splat/werewolf/shifter/garou/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_DOG,
			SPECIES_PERK_NAME = "变形",
			SPECIES_PERK_DESC = "狼人可以在五种形态之间切换，获得不同加成。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_BAND_AID,
			SPECIES_PERK_NAME = "被动再生",
			SPECIES_PERK_DESC = "狼人处于天生形态以外的形态时，拥有强大的被动再生能力。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_MOON,
			SPECIES_PERK_NAME = "惧银",
			SPECIES_PERK_DESC = "处于非天生形态时，银制武器造成的伤害无法被吸收，还会导致灵悟流失。",
		),
	)

	return to_add

/datum/splat/werewolf/shifter/corax/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#241e1c", update = FALSE)
	human.set_hairstyle("Long Over Eye", update = TRUE)
	human.undershirt = "Shirt (Black)"
	human.update_body()

/datum/splat/werewolf/shifter/corax/get_splat_description()
	return "盖亚的信使、渡鸦的子女、赫利俄斯的后裔——渡鸦变形者受天生的好奇心与对传闻永不满足的渴望驱使，游历世界各地。\n他们既以搜集有用情报的本领闻名，也以一开口就难以停下而著称。"

/datum/splat/werewolf/shifter/corax/get_splat_lore()
	return list(
		"渡鸦变形者是在怒火之战后仍与狼人保持友好关系的少数变形者之一，甚至可能是唯一的一支。那场古老战争发生在狼人和几乎所有其他变形者之间。\n\n正如狼人将露娜视为庇护者，渡鸦变形者相信自己受到太阳之灵赫利俄斯的祝福。他们凭借与狼人的友好关系及默契四处旅行、搜集情报，无需担心狼人的袭击与敌意。\n\n渡鸦变形者与狼人一样拥有怒火，但极少将其发展壮大，因此并不像狼人那样以暴烈失控闻名。\n\n狼人因月亮之灵露娜的祝福而惧怕银；同样，赫利俄斯的祝福也使渡鸦变形者对金有相似的弱点。",
	)

/datum/splat/werewolf/shifter/corax/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_CROW,
			SPECIES_PERK_NAME = "变形",
			SPECIES_PERK_DESC = "渡鸦变形者可以在三种形态之间切换，获得不同加成。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_BAND_AID,
			SPECIES_PERK_NAME = "被动再生",
			SPECIES_PERK_DESC = "渡鸦变形者处于天生形态以外的形态时，拥有强大的被动再生能力。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_SUN,
			SPECIES_PERK_NAME = "惧金",
			SPECIES_PERK_DESC = "处于非天生形态时，金制武器造成的伤害无法被吸收，还会导致灵悟流失。",
		),
	)

	return to_add
