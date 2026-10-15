/obj/ritual_rune/thaumaturgy/selfgib
	name = "自毁"
	desc = "迎接终亡。"
	icon_state = "rune2"
	word = "CHNGE DA'WORD, GDBE"

/obj/ritual_rune/thaumaturgy/selfgib/complete()
	. = ..()
	last_activator.death()

