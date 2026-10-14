/datum/quirk/darkpack/metamorph
	name = "Metamorph"
	desc = {"变形对你而言如同呼吸一般轻松。
		你改变形态无需掷骰，瞬间变形也不必消耗怒火点数。
		你的变形效果等同于变形检定取得五个成功。
		若因受伤或其他原因失去意识，你可以进行机敏＋原始冲动检定（难度 8），选择要保持的形态，而非恢复出身形态。"}
	ttrpg_sources = list(/datum/source_book/wta20 = 473)
	value = 7
	mob_trait = TRAIT_METAMORPH
	// I love the greg sam. sa
	icon = FA_ICON_BUG
	allowed_splats = SPLAT_SHIFTERS

/datum/storyteller_roll/metamorph
	bumper_text = "变形精通"
	applicable_stats = list(STAT_WITS) // + PRIMAL_URGE
	difficulty = 8
	roll_output_type = ROLL_FLAG_ROLLER
