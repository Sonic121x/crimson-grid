/datum/quirk/darkpack/beserker
	name = "Berserker"
	desc = {"你能以非同寻常的方式控制内心的愤怒，运用怒火的能力令大多数狼人望尘莫及。
		你可以随时主动进入狂暴性的狂乱，无视伤势惩罚。
		但你仍须承担狂乱期间所作所为带来的一切后果。
		当外界情境可能引发狂乱时，你仍须按通常规则掷骰，判定自己是否陷入狂乱。"}
	ttrpg_sources = list(/datum/source_book/wta20 = 476)
	value = 2
	icon = FA_ICON_ANGRY
	allowed_splats = SPLAT_SHIFTERS

/datum/quirk/darkpack/beserker/add(client/client_source)
	. = ..()
	add_verb(quirk_holder, /mob/living/carbon/human/proc/manual_frenzy)

/datum/quirk/darkpack/beserker/remove()
	. = ..()
	remove_verb(quirk_holder, /mob/living/carbon/human/proc/manual_frenzy)
