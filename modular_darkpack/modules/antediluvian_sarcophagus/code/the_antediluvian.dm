#define ANTEDILUVIAN_SCORE "Antediluvians Killed"
#define BOSS_MEDAL_ANTEDILUVIAN "Antediluvian Killer"
/mob/living/simple_animal/hostile/megafauna/wendigo/antediluvian
	name = "不知名的玛士撒拉"
	desc = "一位神话传说中的血族，你恐怕活不过这一遭。"
	health = 2500
	maxHealth = 2500
	icon_state = "eva"
	icon_living = "eva"
	icon_dead = "eva_dead"
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/the_antediluvian.dmi'
	pixel_x = 0
	base_pixel_x = 0
	guaranteed_butcher_results = list()
	crusher_loot = null
	death_message = "轰然倒下，震动了周围的地面"
	achievement_type = /datum/award/achievement/boss/antediluvian_kill
	score_achievement_type = /datum/award/score/antediluvian_score

/mob/living/simple_animal/hostile/megafauna/colossus/antediluvian
	name = "不知名的玛士撒拉"
	desc = "一位神话传说中的血族，你恐怕活不过这一遭。"
	health = 2500
	maxHealth = 2500
	icon_state = "eva"
	icon_living = "eva"
	icon_dead = "eva_dead"
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/the_antediluvian.dmi'
	pixel_x = 0
	base_pixel_x = 0
	achievement_type = /datum/award/achievement/boss/antediluvian_kill
	score_achievement_type = /datum/award/score/antediluvian_score

/datum/award/achievement/boss/antediluvian_kill
	name = "玛士撒拉杀手"
	desc = "敌人越强大……战利品就越丰厚"
	database_id = BOSS_MEDAL_ANTEDILUVIAN
	icon_state = "firstboss"

/datum/award/score/antediluvian_score
	name = "玛士撒拉击杀数"
	desc = "你到底杀了多少个？！"
	database_id = ANTEDILUVIAN_SCORE

#undef ANTEDILUVIAN_SCORE
#undef BOSS_MEDAL_ANTEDILUVIAN
