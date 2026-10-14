/datum/quirk/darkpack/stillness_of_death
	name = "Stillness of Death"
	desc = "有些石像鬼能利用自己异于常人的外貌、不死之躯、岩石般的肤色，以及岩肤术赋予的岩石与混凝土亲和力，将自己伪装成真正的雕像。购买此优势后，石像鬼可进入“石像形态”，如雕像般纹丝不动，既能骗过旁观者，也能避免违反避世戒律。"
	ttrpg_sources = list(/datum/source_book/vtm20/lotb = 37)
	value = 2
	mob_trait = TRAIT_STILLNESS_OF_DEATH
	gain_text = span_notice("你有信心通过假扮雕像藏身。")
	lose_text = span_notice("你不想再假扮雕像藏身了。")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_GARGOYLE)
	icon = FA_ICON_MOUNTAIN
	failure_message = "你不想再假扮雕像藏身了。"

/datum/quirk/darkpack/stillness_of_death/add(client/client_source)
	var/datum/action/gargoyle_statue_form/statue_action = new()
	statue_action.Grant(quirk_holder)

/datum/action/gargoyle_statue_form
	name = "石像形态"
	desc = "纹丝不动地站立，让你岩石般的外貌骗过路人，以为你只是一尊雕像。"
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "gargoyle"
	var/active = FALSE
	var/original_name

/datum/action/gargoyle_statue_form/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return

	if(!owner)
		return

	if(active)
		deactivate_statue()
	else
		activate_statue()

/datum/action/gargoyle_statue_form/proc/activate_statue()
	if(!owner || active)
		return
	original_name = owner.name
	active = TRUE
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, "statue_form")
	ADD_TRAIT(owner, TRAIT_MUTE, "statue_form")
	REMOVE_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, SUBSPLAT_TRAIT)
	owner.name = "石像鬼雕像"
	var/newcolor = list(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0))
	owner.add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)

	to_chat(owner, span_notice("你化作一尊石像，静止不动，默不作声。"))

/datum/action/gargoyle_statue_form/proc/deactivate_statue()
	if(!owner || !active)
		return

	active = FALSE

	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, "statue_form")
	REMOVE_TRAIT(owner, TRAIT_MUTE, "statue_form")
	ADD_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, SUBSPLAT_TRAIT)

	owner.remove_atom_colour(FIXED_COLOUR_PRIORITY)
	owner.name = original_name

	to_chat(owner, span_notice("你恢复了原本的形态。"))

/datum/action/gargoyle_statue_form/Remove(mob/remove_from)
	if(active)
		deactivate_statue()
	return ..()
