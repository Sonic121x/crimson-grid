/datum/action/cooldown/power/gift/primal_anger
	name = "原始怒意"
	desc = "每个场景一次，角色可对自身造成一级恶性伤害，换取三点怒火。"
	button_icon_state = "primal_anger"
	rank = 1
	cooldown_time = 1 SCENES

/datum/action/cooldown/power/gift/primal_anger/Activate(atom/target)
	. = ..()

	var/mob/living/living_owner = astype(owner)
	living_owner?.adjust_agg_loss(1 TTRPG_DAMAGE)

	var/datum/splat/werewolf/werewolf_splat = get_werewolf_splat(owner)
	werewolf_splat?.adjust_rage(3)
