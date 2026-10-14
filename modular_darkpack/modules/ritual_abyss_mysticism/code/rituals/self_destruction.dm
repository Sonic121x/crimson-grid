/obj/ritual_rune/abyss/selfgib
	name = "自毁"
	desc = "迎接终亡。"
	icon_state = "rune2"
	word = "YNT FRM MCHGN FYNV DN THS B'FO" //'youre not from michigan if youve never done this before'
	cost = 1

/obj/ritual_rune/abyss/selfgib/complete()
	. = ..()
	last_activator.death()
