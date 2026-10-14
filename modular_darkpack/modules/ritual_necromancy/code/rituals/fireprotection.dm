/obj/ritual_rune/necromancy/fireprotection
	name = "湮灭之寒"
	desc = "将冥土的寒冷引入灵魂，消除肉身畏火的弱点。这份亵渎的赐福会<b>玷污受术者的灵光</b>。"
	icon_state = "rune1"
	word = "DHAI'AD BHA'II DAWH'N"
	level = 4

/obj/ritual_rune/necromancy/fireprotection/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody.stat == DEAD)
			to_chat(usr, span_warning("目标已经死去，寒冷早已盘踞其体内。"))
			return

		else valid_bodies += targetbody

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("仪式的目标必须留在符文上。"))
		return

	var/mob/living/carbon/victim = pick(valid_bodies)

	if(victim.fakediablerist)
		to_chat(usr, span_warning("仪式的目标已经被寒冷占据。"))
		return

	playsound(loc, 'sound/effects/ghost.ogg', 50, FALSE)
	victim.emote("shiver")
	victim.Immobilize(4 SECONDS)

	to_chat(victim, span_revendanger("灼痛的冰寒从你的灵魂渗出，蔓延至全身。你僵立在寒冷中，动弹不得，死亡萦绕不去。"))
	victim.fakediablerist = TRUE
	//removing iscathayan from line 38 -- DAKPACK TODO -- readd KJs (iscathayan(victim))
	if(get_kindred_splat(victim) || victim.has_status_effect(/datum/status_effect/zombie)) //made this a deduction rather than a flat set because of an artifact that independently changes damage mods
		// Im not even certin this does anything for kindred waying heatmod only affects the breath you take and kindred shouldnt be breathing really.
		victim.dna.species.heatmod = max(0.5, victim.dna.species.heatmod-1) // This sucks why are we touching species for this.
	else
		victim.dna.species.heatmod = max(0.5, victim.dna.species.heatmod-0.5)
	qdel(src)
