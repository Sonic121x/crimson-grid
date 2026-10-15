/datum/st_stat/pooled/permanent_willpower
	name = "永久意志力"
	description = "角色克服逆境的内在动力与能力。用于检定。"
	freebie_point_cost = FREEBIE_COST_WILLPOWER
	stat_flags = AFFECTS_STATS

/datum/st_stat/pooled/temporary_willpower
	name = "临时意志力"
	description = "角色克服逆境的内在动力与能力。作为可消耗的资源。"
	editable = FALSE


/// Prompts the user to burn an amount of willpower then returns the amount spent.
/mob/living/proc/prompt_burn_willpower(amount = 1)
	if(st_get_stat(STAT_TEMPORARY_WILLPOWER) < amount)
		return 0
	var/choices = list(
		"消耗意志力" = image(icon = 'modular_darkpack/modules/storyteller_stats/icons/assets.dmi', icon_state = "willpower"),
		"否" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no"),
	)

	var/chosen_option = show_radial_menu(src, src, choices, radius = 36, tooltips = TRUE)
	if(chosen_option == "消耗意志力")
		st_change_stat(STAT_TEMPORARY_WILLPOWER, -amount)
		to_chat(src, span_warning("你消耗了 [amount] 点意志力。"))
		return amount

	return 0
