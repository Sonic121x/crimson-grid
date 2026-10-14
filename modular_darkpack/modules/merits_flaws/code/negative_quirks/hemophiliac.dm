// VTM Ghouls and Revenants pg. 136
/datum/quirk/darkpack/hemophiliac
	name = "Hemophiliac"
	desc = {"你患有血友病。
皮肤一旦被割破，没有医疗救助就无法止血。"}
	icon = FA_ICON_DROPLET
	value = -3
	gain_text = span_notice("你觉得流血变得危险多了。")
	lose_text = span_notice("你觉得流血没那么危险了。呼！")
	failure_message = span_notice("你觉得流血没那么危险了。呼！")
	forbidden_splats = list(SPLAT_KINDRED, SPLAT_SHIFTERS) // Kinfolk, humans, and ghouls can take this. Debate adding Garou/Corax to it?

/*Your character suffers from hemophilia. If your ghoul’s
skin is cut, you will not stop bleeding without medical
assistance. The Blood does not have any effect on a ghoul
or revenant Hemophiliac.
If your character suffers lethal or aggravated damage,
he suffers an additional level of bashing damage every
five minutes until his wound has been dressed to stop
the bleeding. Any vampire who bites a Hemophiliac may
“dress” such wounds. By licking the injury after biting the
ghoul, the vampire will put a stop to any future bashing
damage.*/

/datum/quirk/darkpack/hemophiliac/add(client/client_source)
	. = ..()
	ADD_TRAIT(quirk_holder, TRAIT_EASYBLEED, QUIRK_TRAIT) // Easier to make bleed
	ADD_TRAIT(quirk_holder, TRAIT_BLOOD_FOUNTAIN, QUIRK_TRAIT) // worse bleeding when they do

/datum/quirk/darkpack/hemophiliac/remove()
	. = ..()
	REMOVE_TRAIT(quirk_holder, TRAIT_EASYBLEED, QUIRK_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_BLOOD_FOUNTAIN, QUIRK_TRAIT)
