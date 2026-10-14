/obj/ritual_rune/necromancy/death
	name = "死亡"
	desc = "立即将自己送往冥土。"
	icon_state = "rune2"
	word = "Y'HO 'LLOH"

/obj/ritual_rune/necromancy/death/complete()
	last_activator.death()
	qdel(src)
