/mob/living/basic/bane/suffocating
	desc = "一个恶心的怪物，不停地喘息，扭动着畸形的身躯。"
	icon_state = "suffocating_bane"
	maxHealth = 50
	health = 50

	mob_size = MOB_SIZE_SMALL

/* Cant be asked to setup a ai controller for 1 random speech.
/datum/bt_node/ai_behavior/random_speech/suffocating_bane
	speech_chance = 15
	speak = list("gasps")
	sound = list(
		'sound/mobs/humanoids/human/gasp/gasp_female1.ogg',
		'sound/mobs/humanoids/human/gasp/gasp_female2.ogg',
		'sound/mobs/humanoids/human/gasp/gasp_female3.ogg',
		'sound/mobs/humanoids/human/gasp/gasp_male1.ogg',
		'sound/mobs/humanoids/human/gasp/gasp_male2.ogg',
	)
*/
