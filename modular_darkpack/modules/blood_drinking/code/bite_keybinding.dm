/datum/keybinding/human/bite
	hotkey_keys = list("V")
	name = "bite"
	full_name = "啃咬"
	description = "啃咬你正强力抓住的目标，并在可能的情况下吸取其血液。"
	keybind_signal = COMSIG_KB_HUMAN_BITE_DOWN

/datum/keybinding/human/bite/down(client/user)
	. = ..()
	if(.)
		return

	if(ishuman(user.mob))
		var/mob/living/carbon/human/human_user = user.mob
		human_user.vamp_bite()

	return TRUE
