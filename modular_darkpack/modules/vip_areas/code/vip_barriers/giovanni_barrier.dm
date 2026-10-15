/obj/effect/vip_barrier/giovanni
	name = "乔凡尼检查点"
	desc = "这里是家族聚会，懂了吗？"
	protected_zone_id = "giovanni"
	social_roll_difficulty = 7

/obj/effect/vip_barrier/giovanni/check_entry_permission_custom(mob/living/carbon/human/entering_mob)
	if(entering_mob.mind && entering_mob.mind.assigned_role && (entering_mob.mind.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_GIOVANNI))
		return TRUE
	return FALSE
