// W20 p. 476
/datum/quirk/darkpack/untamable
	name = "Untamable"
	desc = {"你的灵魂狂放不羁，从不向束缚屈服。
		你免疫吸血鬼的支配术，但不免疫威仪术施加的情绪操控。"}
		// Change this line when we add these gifts.
		// You are immune to vampiric Domination (but not emotional manipulations via Presence) and these Gifts will not work on you: Roll Over, Obedience, and Mastery."}
	ttrpg_sources = list(/datum/source_book/wta20 = 476)
	value = 5
	mob_trait = TRAIT_MERIT_UNTAMABLE
	icon = FA_ICON_SHIELD_DOG
	allowed_splats = SPLAT_SHIFTERS
