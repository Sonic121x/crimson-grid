// **************************************************************** DEFLECTION OF THE WOODEN DOOM *************************************************************

//Deflection of the Wooden Doom ritual
//Protects you from being staked for a single hit. Is it useful? Marginally. But it is a level 1 rite.
/obj/ritual_rune/thaumaturgy/deflection_stake
	name = "抵御木桩之厄"
	desc = "护住你的心脏，击碎敌人的木桩。需要一根木桩。"
	icon_state = "rune7"
	word = "碎裂，崩解，破除木桩之厄。"
	level = 1
	sacrifices = list(/obj/item/vampire_stake)

/obj/ritual_rune/thaumaturgy/deflection_stake/complete()
	. = ..()
	for(var/mob/living/carbon/human/H in loc)
		if(!HAS_TRAIT(H, TRAIT_STAKE_RESISTANT))
			ADD_TRAIT(H, TRAIT_STAKE_RESISTANT, MAGIC_TRAIT)
			qdel(src)
		color = rgb(255,0,0)
		activated = TRUE
