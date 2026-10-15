/mob/living/basic/bear/vampire
	name = "灰熊"

/mob/living/basic/bear/vampire/blackbear
	name = "黑熊"
	desc = "唔，它看起来还挺温和的……等等，不对！！"
	icon = 'modular_vcg/modules/npc/icons/blackbear.dmi'
	icon_state = "blackbear"
	icon_living = "blackbear"
	icon_dead = "blackbear_dead"
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 8
	maxbloodpool = 8
	maxHealth = 650
	health = 650
	melee_damage_lower = 45
	melee_damage_upper = 45 //Black bears are more likely to go all out to kill you to eat you
	mob_size = MOB_SIZE_LARGE
	pixel_x = -16
	base_pixel_x = -16
