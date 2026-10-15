/datum/subsplat/vampire_clan/tremere
	name = "Tremere"
	id = VAMPIRE_CLAN_TREMERE
	desc = "精研秘术的睿魔尔氏族原本是凡人法师家系，追求永生，却只得到了不死之躯。化为吸血鬼后，他们精通以意志驾驭自身血液的手段，运用巫术操纵凡人与血族世界。力量使他们备受重视，然而鲜有血族信任其诡计。睿魔尔是隐秘的神秘学知识搜集者和血魔法师，牢牢依附于金字塔：这一纽带体系将每个成员与内环及其意志紧密相连。氏族要求他们将集体利益置于个人之上，但仍有人投向卡尔纳家系，或成为追逐禁忌力量的恶魔崇拜者，或寻求独立，甚至加入魔宴同盟。氏族诅咒使血缚对他们的影响远强于其他血族。"
	icon = "tremere"
	curse = "血缚对睿魔尔的影响远强于其他血族。"
	roleplay_level = "Advanced"
	sense_the_sin_text = "对自身行为抱有完美主义的执念。"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/dominate,
		/datum/discipline/thaumaturgy
	)
	male_clothes = /obj/item/clothing/under/vampire/tremere
	female_clothes = /obj/item/clothing/under/vampire/tremere/female

/datum/subsplat/vampire_clan/tremere/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("鲜血从我的身体涌出，凝成怪诞的形体。"))
	new /obj/effect/client_image_holder/baali_demon/tremere(get_turf(target), list(target))
