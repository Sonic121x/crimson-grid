/**
 *A new subsystem for hydroponics, as a way to share specific traits into plants, as a way to phase out the DNA manipulator.
 */
/obj/item/graft
	name = "植物接穗"
	desc = "从新长成的植物上精心剪下的接穗。可以嫁接到其他植物上，使其获得独特的植物性状。"
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "graft_plant"
	worn_icon_state = "graft"
	attack_verb_continuous = list("栽种", "种菜", "收割", "收获", "耕作")
	attack_verb_simple = list("栽种", "种菜", "收割", "收获", "耕作")
	/// Our internal seed used to modify stats or genes by grafting or passed as our seed when propagating vegetatively,
	var/obj/item/seeds/plant_dna = /obj/item/seeds/apple

/obj/item/graft/Initialize(mapload, obj/item/seeds/mother_plant)
	. = ..()
	//create our "plant dna" internal seed from the plant the cuttings are taken from.
	if(mother_plant)
		if(ispath(mother_plant))
			plant_dna = new mother_plant()
			if(!istype(plant_dna))
				CRASH("Tried to create a graft using a non-seed path.")
		else if(istype(mother_plant))
			plant_dna = mother_plant.Copy()
		else
			CRASH("Tried to create a graft using a non-seed reference.")

	icon_state = pick(
		10 ; "graft_plant" , \
		5 ; "graft_flower" , \
		4 ; "graft_mushroom" , \
		1 ; "graft_doom" )

	name += " ([plant_dna.plantname])"

	var/static/list/hovering_item_typechecks = list(
		/obj/item/plant_analyzer = list(
			SCREENTIP_CONTEXT_LMB = "Scan graft",
		),
	)

	AddElement(/datum/element/contextual_screentip_item_typechecks, hovering_item_typechecks)
