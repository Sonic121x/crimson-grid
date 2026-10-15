/datum/splat/vampire/ghoul/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#ac151d", update = FALSE)
	human.set_hairstyle("Long Fringe", update = TRUE)
	human.set_eye_color("#2D4118")
	human.undershirt = "Tank Top (Fire)"
	human.update_body()

/datum/splat/vampire/ghoul/get_splat_description()
	return "血仆是依靠吸血鬼血粹维生、也受其束缚的凡人。他们获得超乎常人的生命力与永驻的青春，却在情感上依赖自己的血主。有些人出于血粹催生的爱慕、忠诚或野心甘愿效力；另一些人则因成瘾而困在无法挣脱的血缚之中。\n\n在世界各地，血仆为各派系的血族担任保镖、仆役、代理人和中间人。尽管比普通人更强，也能在白天行动，他们依然受制于主人反复无常的意志，以及血族社会的政治斗争。"

// Pulled straight from the wiki https://whitewolf.fandom.com/wiki/Ghoul_(VTM)
/datum/splat/vampire/ghoul/get_splat_lore()
	return list(
		"几乎任何活物只要喝下一点吸血鬼之血，就会变成血仆，至少暂时如此。在《吸血鬼：避世潜藏》的世界中，血仆是随处可见的仆役，易于制造，也饱受虐待，尽管确有组织帮助他们逃离主人。血粹这种令人沉醉的毒品流淌在血仆体内，使他们的情绪趋于极端，更遑论血缚的影响；他们常被暴怒与令人不安的渴望吞噬。英文中借用“食尸鬼”一词称呼他们，绝非偶然。"
	)

/datum/splat/vampire/ghoul/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_DROPLET,
			SPECIES_PERK_NAME = "血缚",
			SPECIES_PERK_DESC = "血仆通常受到血缚约束，替主人办事。",
		),
	)

	return to_add
