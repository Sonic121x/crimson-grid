/obj/effect/vip_barrier/stripclub
	name = "贵宾区"
	desc = "从这里开始，便是城中非人者的中立区。在此之后，真正的暗夜异类可以安全聚集。"
	protected_zone_id = "elysium_strip"
	social_roll_difficulty = 9


/obj/effect/vip_barrier/stripclub/check_entry_permission_custom(mob/living/carbon/human/entering_mob)
	if(issupernatural(entering_mob) || istype(entering_mob.mind?.assigned_role, /datum/outfit/job/vampire/club_worker))
		return TRUE
	return FALSE
