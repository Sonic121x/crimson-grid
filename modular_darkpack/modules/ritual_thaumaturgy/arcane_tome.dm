/obj/item/ritual_tome/arcane
	name = "奥术典籍"
	desc = "血魔法的奥秘……"
	icon_state = "arcane"
	icon = 'modular_darkpack/modules/ritual_thaumaturgy/icons/arcane_tome.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ritual_thaumaturgy/icons/arcane_tome_onfloor.dmi')
	rune_type = /obj/ritual_rune/thaumaturgy
	discipline_type = /datum/discipline/thaumaturgy
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/paper = SHEET_MATERIAL_AMOUNT * 0.75)

/obj/item/ritual_tome/arcane/attack_self(mob/user)
	var/mob/living/living_user = astype(user)
	if(!living_user || !living_user.get_discipline(/datum/discipline/thaumaturgy))
		to_chat(user, span_cult("一本以拉丁文题名、覆满各种符印与图案的书。若想进一步学习，你需要一位老师。不知为何，它怎么也打不开。"))
		return
	. = ..()

/datum/crafting_recipe/arctome
	name = "奥术典籍"
	time = 10 SECONDS
	reqs = list(/obj/item/paper = 3, /obj/item/reagent_containers/blood = 2)
	result = /obj/item/ritual_tome/arcane
	category = CAT_MISC
	skill_required_for_use = STAT_OCCULT
	skill_dots_minimum = 1

/datum/crafting_recipe/arctome/is_recipe_available(mob/user)
	. = ..()
	var/mob/living/living_user = astype(user)
	if(!living_user?.get_discipline(/datum/discipline/thaumaturgy))
		return FALSE
