
/datum/socialrole/bandit
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
	is_criminal = TRUE

	hair_colors = list(
		"#040404",	//Black
		"#120b05",	//Dark Brown
		"#342414",	//Brown
		"#554433"	//Light Brown
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
		/obj/item/clothing/shoes/vampire/sneakers/red,
		/obj/item/clothing/shoes/vampire/jackboots
	)
	uniforms = list(
		/obj/item/clothing/under/vampire/larry,
		/obj/item/clothing/under/vampire/bandit,
		/obj/item/clothing/under/vampire/biker
	)
	hats = list(
		/obj/item/clothing/head/vampire/bandana,
		/obj/item/clothing/head/vampire/bandana/red,
		/obj/item/clothing/head/vampire/bandana/black,
		/obj/item/clothing/head/vampire/beanie,
		/obj/item/clothing/head/vampire/beanie/black
	)
	pockets = list(
		// /obj/item/stack/dollar/rand,
		/obj/item/vamp/keys/hack
	)

	//[Lucia] - this has been edited to have better English because it included slurs, but none of the others have yet
	male_phrases = list(
		"瞅什么瞅？",
		"想吓唬我还是怎么着？",
		"有事？",
		"你小子还真有种。",
		"知道我是跟谁混的吗？",
		"赶紧滚，别逼我叫兄弟们来收拾你。",
		"小混蛋，有事吗？",
		"滚远点，自由派。",
		"滚出这片街区。",
		"以为能吓到我？知道我是跟谁混的吗？",
		"以为自己很牛逼？"
	)
	neutral_phrases = list(
		"干吗这么盯着我？",
		"又来个装凶吓人的傻逼。",
		"万圣节早过了，穿这身干吗。",
		"我怀疑那婊子把淋病传给我了。",
		"得早点回家了，还得养家糊口呢。",
		"滚远点，自由派。",
		"我想……我有点想我老婆了。",
		"干吗？你有事？",
		"别挡道。",
		"滚蛋，混球，没心情搭理你。",
		"滚开。"
	)
	random_phrases = list(
		"傻逼。",
		"我想我女朋友了……",
		"怎么了，兄弟？",
		"晚上。他妈的。好。",
		"晚上好。",
		"我看见你卖毒品了，知道吧？",
		"咱们他妈的完蛋了……",
		"完了……",
		"呃……"
	)
	answer_phrases = list(
		"我明白了……",
		"这整座城就是个他妈的鬼地方。",
		"操，兄弟。",
		"你看着挺面生的……我认识你吗？",
		"对。",
		"呃……算是不错吧。",
		"在咕玛肚吃了顿好的，不过现在肚子疼……"
	)
	help_phrases = list(
		"老天，别再来了！",
		"他妈的怪胎！",
		"你他妈的在干什么！？",
		"你摊上事了！",
		"放老实点，蠢货！",
		"我们有家伙，能让你永远闭嘴的家伙！"
	)
