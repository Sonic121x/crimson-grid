/datum/socialrole/shop
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
	max_age = 45
	preferred_gender = MALE
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

	shoes = list(
		/obj/item/clothing/shoes/vampire/sneakers,
		/obj/item/clothing/shoes/vampire,
		/obj/item/clothing/shoes/vampire/brown
	)
	uniforms = list(
		/obj/item/clothing/under/vampire/mechanic,
		/obj/item/clothing/under/vampire/brujah,
		/obj/item/clothing/under/vampire/emo,
		/obj/item/clothing/under/vampire/suit,
		/obj/item/clothing/under/vampire/turtleneck_black,
		/obj/item/clothing/under/vampire/office,
		/obj/item/clothing/under/vampire/gangrel,
		/obj/item/clothing/under/vampire/tremere,
		/obj/item/clothing/under/vampire/supply,
	)
	pockets = list(
		/obj/item/vamp/keys/npc,
		// /obj/item/stack/dollar/rand
	)

	male_phrases = list(
		"想买点什么吗？",
		"需要帮忙吗？",
		"嘿，想买这个吗？"
	)
	neutral_phrases = list(
		"想买点什么吗？",
		"需要帮忙吗？",
		"嘿，想买这个吗？"
	)
	random_phrases = list(
		"想找什么？我帮你看看？",
		"需要什么就告诉我。",
		"慢慢挑。",
		"好眼光，那款很受欢迎。",
		"现金还是刷卡，对我都一样。",
		"我们刚进了一批新货。",
		"看起来你很清楚自己想买什么。",
		"那件在打折，别问为什么。",
		"今天生意冷清，真高兴你进来了。",
		"我在这儿干了十二年，感觉像三十年。",
		"上个员工不打招呼就辞职了，所以……就这样了。",
		"东西定价都很公道。大部分吧。",
		"随便看看，不买也没关系。",
		"老板从来不在，这家店基本都是我在管。",
		"本店不退款。",
		"要袋子吗？一个五美分。市里规定的，别怪我！",
		"有事喊我，我去假装盘点一下库存。",
	)
	answer_phrases = list("我只是个打工的……")
	help_phrases = list(
		"这他妈的怎么回事？！",
		"走开，不然我就报警了！！",
		"发生什么事了？！",
		"快住手！",
		"来人啊，叫救护车！"
	)
	var/masquerade_item_phrases = list(
		"嗯？这是你从旧货摊淘来的？",
		"看着挺有意思，送给我叔叔当生日礼物好了。",
		"拿钱走人，我不跟撒旦教徒做生意。"
	)
	var/masquerade_item_failure_phrases = list(
		"搞什么鬼？伙计，你让我毛骨悚然。",
		"你从哪儿弄来的这东西？！",
		"好吧，我买，但请你赶紧离开……"
	)
