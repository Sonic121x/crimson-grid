/datum/quirk/darkpack/huge_size
	name = "Huge size"
	desc = {"你的体型异常庞大，身高至少 6 英尺 10 英寸，
体重至少 300 磅（身高远超两米，
体重超过 130 千克）。这不仅使你在人群中
格外显眼，也让你额外获得
20 点生命值。拥有此优势的角色在
撞破门扉时也可能获得加成。"}
/* Characters with this Merit may
also gain bonuses to push objects, open barred doors,
avoid being knocked down, etc*/
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	mob_trait = TRAIT_HUGE_SIZE
	icon = FA_ICON_ARROW_UP
	value = 4
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	gain_text = span_notice("你觉得自己的体型比常人更大。")
	lose_text = span_notice("你觉得自己没那么高大了。")
	failure_message = span_notice("你觉得自己没那么高大了。")


/datum/quirk/darkpack/huge_size/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.maxHealth += 20
	human_holder.health += 20
	human_holder.update_transform(1.25) //Same as TRAIT_GIANT. Maybe a bit excessive.

/datum/quirk/darkpack/huge_size/remove()
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.maxHealth -= 20
	human_holder.health -= 20
	human_holder.update_transform(1)
