/obj/item/occult_artifact/vampire/key_of_alamut
	true_name = "阿拉穆特之钥"
	true_desc = "降低受到的伤害。"
	icon_state = "k_alamut"
	research_value = 30

/obj/item/occult_artifact/vampire/key_of_alamut/grant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 70)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier+20

/obj/item/occult_artifact/vampire/key_of_alamut/ungrant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 50)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier-20
