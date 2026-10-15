/datum/socialrole/bouncer
	is_criminal = TRUE

	//Appearence
	s_tones = list(
		"albino",
		"caucasian1",
		"caucasian2",
		"caucasian3",
		"latino",
		"mediterranean",
		"asian1",
		"asian2",
		"arab",
		"indian",
		"african1",
		"african2"
	)

	min_age = 18
	max_age = 85
	male_names = null
	surnames = null

	hair_colors = list(
		"#040404",	//Black
		"#120b05",	//Dark Brown
		"#342414",	//Brown
		"#554433",	//Light Brown
		"#695c3b",	//Dark Blond
		"#ad924e",	//Blond
		"#dac07f",	//Light Blond
		"#802400",	//Ginger
		"#a5380e",	//Ginger alt
		"#ffeace",	//Albino
		"#650b0b",	//Punk Red
		"#14350e",	//Punk Green
		"#080918"	//Punk Blue
	)
	male_hair = list(
		"Balding Hair",
		"Bedhead",
		"Bedhead 2",
		"Bedhead 3",
		"Boddicker",
		"Business Hair",
		"Business Hair 2",
		"Business Hair 3",
		"Business Hair 4",
		"Coffee House",
		"Combover",
		"Crewcut",
		"Father",
		"Flat Top",
		"Gelled Back",
		"Joestar",
		"Keanu Hair",
		"Oxton",
		"Volaju"
	)
	male_facial = list(
		"Beard (Abraham Lincoln)",
		"Beard (Chinstrap)",
		"Beard (Full)",
		"Beard (Cropped Fullbeard)",
		"Beard (Hipster)",
		"Beard (Neckbeard)",
		"Beard (Three o Clock Shadow)",
		"Beard (Five o Clock Shadow)",
		"Beard (Seven o Clock Shadow)",
		"Moustache (Hulk Hogan)",
		"Moustache (Watson)",
		"Sideburns (Elvis)",
		"Sideburns",
		"Shaved"
	)

	female_hair = list("Ahoge",
		"Long Bedhead",
		"Beehive",
		"Beehive 2",
		"Bob Hair",
		"Bob Hair 2",
		"Bob Hair 3",
		"Bob Hair 4",
		"Bobcurl",
		"Braided",
		"Braided Front",
		"Braid (Short)",
		"Braid (Low)",
		"Bun Head",
		"Bun Head 2",
		"Bun Head 3",
		"Bun (Large)",
		"Bun (Tight)",
		"Double Bun",
		"Emo",
		"Emo Fringe",
		"Feather",
		"Gentle",
		"Long Hair 1",
		"Long Hair 2",
		"Long Hair 3",
		"Long Over Eye",
		"Long Emo",
		"Long Fringe",
		"Ponytail",
		"Ponytail 2",
		"Ponytail 3",
		"Ponytail 4",
		"Ponytail 5",
		"Ponytail 6",
		"Ponytail 7",
		"Ponytail (High)",
		"Ponytail (Short)",
		"Ponytail (Long)",
		"Ponytail (Country)",
		"Ponytail (Fringe)",
		"Poofy",
		"Short Hair Rosa",
		"Shoulder-length Hair",
		"Volaju")

	shoes = list(/obj/item/clothing/shoes/vampire/jackboots)
	uniforms = list(/obj/item/clothing/under/vampire/guard)
	pockets = list(/obj/item/vamp/keys/npc, /obj/item/stack/dollar/rand)
	backpacks = list()

	//Voice Lines
	neutral_phrases = list(
		"伙计，你最好退后点。",
		"只有贵宾才能进去。",
		"注意你的礼貌。"
	)
	random_phrases = list(
		"今晚真安静。"
	)

	answer_phrases = list("操，伙计。")
	help_phrases = list(
		"你该走人了。",
		"让我送你出去吧。",
		"本来好好的一晚上，全让你搅和了。",
		"打你这一顿，我比你还难受。"
	)


	//Phrase said when someone is denied entry
	var/denial_phrases = list(
		"名单上没有你。",
		"不准进。说的就是你。",
		"里面是私人聚会。"
	)


	var/entry_phrases = list(
		"很高兴又见到你。",
		"欢迎来到黑暗的一侧。",
		"我们恭候多时了。",
		"见到你总是很愉快。"
	)

	var/police_block_phrases = list(
		"条子去死。",
		"哦，是吗？带着搜查令再来怎么样？",
		"没搜查令，你就别想进去。",
		"我知道自己的权利。你他妈给我待在外面。"
	)

	var/block_phrases = list(
		"我们不是叫你滚了吗？",
		"最后说一次，你别想进去。",
		"故事编得不错，伙计。现在滚吧。"
	)

	var/bouncer_weapon_type = /obj/item/gun/ballistic/shotgun/vampire
	var/bouncer_backup_weapon_type = /obj/item/claymore/machete
