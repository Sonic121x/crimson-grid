/// A doctor successfuly completed a surgery on someone.
/datum/memory/surgery
	story_value = STORY_VALUE_OKAY
	// Protagonist - The surgeon, completing the surgery
	// Deuteragonist - The mob being operated on
	/// What type of surgery it was
	var/surgery_type

/datum/memory/surgery/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	surgery_type,
)
	src.surgery_type = surgery_type
	return ..()

/datum/memory/surgery/get_names()
	return list("[protagonist_name]为[deuteragonist_name]实施[surgery_type]。")

/datum/memory/surgery/get_starts()
	return list(
		"[protagonist_name]小心地为[deuteragonist_name]实施[surgery_type]",
		"[protagonist_name]对[deuteragonist_name]使用骨锯",
		"[deuteragonist_name]正在接受[protagonist_name]的手术",
	)

/datum/memory/surgery/get_moods()
	return list(
		"完成[surgery_type]后，[protagonist_name][mood_verb]。",
		"鲜血溅到[protagonist_name]的脸上，[protagonist_name][mood_verb]。",
		"[surgery_type]仍在继续，[protagonist_name][mood_verb]。",
		"[protagonist_name]一边解剖[deuteragonist_name]，一边[mood_verb]。",
		"[protagonist_name]一边剖开[deuteragonist_name]的身体，一边[mood_verb]。",
	)

/// Planted a bomb.
/datum/memory/bomb_planted
	story_value = STORY_VALUE_MEH
	// Protagonist - Whoever armed the bomb
	// Antaognist - The bomb that was armed

/datum/memory/bomb_planted/get_names()
	return list("[protagonist_name]启动[antagonist_name]。")

/datum/memory/bomb_planted/get_starts()
	return list(
		"[protagonist_name]按下一个不祥的按钮，[antagonist_name]随即开始鸣响",
		"[protagonist_name]重重放下[antagonist_name]",
		"[protagonist_name]正在启动[antagonist_name]",
	)

/datum/memory/bomb_planted/get_moods()
	return list(
		"[protagonist_name][mood_verb]，开始远离炸弹。",
		"炸弹开始滴答作响，[protagonist_name][mood_verb]。",
		"倒计时逐渐接近零，[protagonist_name][mood_verb]。",
		"哔……哔……[protagonist_name][mood_verb]。"
	)

/datum/memory/bomb_planted/get_happy_moods()
	return list("觉得自己酷到根本不必回头看[antagonist_name]")

/// Planted a SYNDICATE bomb.
/datum/memory/bomb_planted/syndicate
	story_value = STORY_VALUE_AMAZING

/// Planted a NUKE!
/datum/memory/bomb_planted/nuke
	story_value = STORY_VALUE_LEGENDARY

/// Got a sweet high five.
/datum/memory/high_five
	story_value = STORY_VALUE_MEH
	// Protagonist - One of the high-fivers
	// Deuteragonist - The other high fiver
	/// What type of high five it was - A "high five" or a "high ten"
	var/high_five_type

/datum/memory/high_five/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	high_five_type,
	high_ten = FALSE,
)
	src.high_five_type = list("high-five" = "击掌", "high-ten" = "双手击掌")[high_five_type] || high_five_type
	src.story_value = high_ten ? STORY_VALUE_OKAY : STORY_VALUE_MEH
	return ..()

/datum/memory/high_five/get_names()
	return list("[protagonist_name]与[deuteragonist_name][high_five_type]。")

/datum/memory/high_five/get_starts()
	return list(
		"[protagonist_name]与[deuteragonist_name]来了一次堪称传奇的[high_five_type]",
		"[protagonist_name]与[deuteragonist_name][high_five_type]",
		"[protagonist_name]和[deuteragonist_name]互相[high_five_type]",
	)

/datum/memory/high_five/get_moods()
	return list(
		"双方成功[high_five_type]，[protagonist_name][mood_verb]。",
		"感受着这份同伴情谊，[protagonist_name][mood_verb]。",
		"多么精彩的[high_five_type]！[protagonist_name][mood_verb]。",
		"哇！[protagonist_name][mood_verb]！",
	)

/// Was cyborgized.
/datum/memory/was_cyborged
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_FLAG_NOMOOD|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - The mind of who was just cyborgized

/datum/memory/was_cyborged/get_names()
	return list("[protagonist_name]被改造成半机械人。")

/datum/memory/was_cyborged/get_starts()
	return list(
		"[protagonist_name]的大脑被装进机器人",
		"[protagonist_name]被改造成一堆铁疙瘩",
	)

/// Witnessed someone die nearby.
/datum/memory/witnessed_death
	story_value = STORY_VALUE_MEH // this is pretty common on this hellhole
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS|MEMORY_FLAG_NOMOOD
	// Protagonist - Who died

/datum/memory/witnessed_death/get_names()
	return list("[protagonist_name]的死亡。")

/datum/memory/witnessed_death/get_starts()
	return list(
		"[protagonist_name]已经死去",
		"[protagonist_name]抽搐后瘫软倒下，双眼死气沉沉",
		"[protagonist_name]的心脏停止跳动",
		"[protagonist_name]的死亡",
	)

/// Witnessed someone get creampied nearby.
/datum/memory/witnessed_creampie
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The mob that got pied

/datum/memory/witnessed_creampie/get_names()
	return list("[protagonist_name]被奶油派糊了一脸。")

/datum/memory/witnessed_creampie/get_starts()
	return list(
		"[protagonist_name]满脸都是奶油",
		"[protagonist_name]被奶油派砸中",
	)

/datum/memory/witnessed_creampie/get_moods()
	return list(
		"奶油从脸上滴落，[protagonist_name][mood_verb]。",
		"想到又多了一堆要洗的衣物，[protagonist_name][mood_verb]。",
		"[protagonist_name]舔掉一些奶油派，[mood_verb]。",
	)

/// Witnessed someone get splashed with squid ink.
/datum/memory/witnessed_inking
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The mob that got pied

/datum/memory/witnessed_inking/get_names()
	return list("[protagonist_name]被喷了一身鱿鱼墨汁。")

/datum/memory/witnessed_inking/get_starts()
	return list(
		"[protagonist_name]满脸都是鱿鱼墨汁",
		"[protagonist_name]被喷上鱿鱼墨汁",
	)

/datum/memory/witnessed_inking/get_moods()
	return list(
		"墨汁从脸上滴落，[protagonist_name][mood_verb]。",
		"想到又多了一堆要洗的衣物，[protagonist_name][mood_verb]。",
		"[protagonist_name]一边擦掉脸上的墨汁，一边[mood_verb]。",
	)

/// Got slipped by something.
/datum/memory/was_slipped
	story_value = STORY_VALUE_MEH
	// Protagonist - The mob that got slipped
	// Antagonist - The thing that did the slipping (banana peel, etc)

/datum/memory/was_slipped/get_names()
	return list("[protagonist_name]滑倒了。")

/datum/memory/was_slipped/get_starts()
	return list(
		"[protagonist_name]遇到[antagonist_name]后站立不稳",
		"[protagonist_name]被[antagonist_name]绊得摔了个跟头",
		"[antagonist_name]让[protagonist_name]摔了个狼狈",
	)

/datum/memory/was_slipped/get_moods()
	return list(
		"[protagonist_name]从地上爬起来，[mood_verb]。",
		"[protagonist_name]躺在地上，[mood_verb]。",
	)

/datum/memory/was_slipped/get_sad_moods()
	return list("沮丧得连爬起来都不想")

/datum/memory/was_slipped/build_story_character(character)
	// We can slip on turfs, so we should account for it
	if(isturf(character))
		var/turf/place = character
		return "[prob(50) ? "危险的" : ""][pick("湿漉漉的", "涂满润滑剂的", "湿滑的", "冰冷的")][place.name]"

	return ..()

/// Had spaghetti fall from their pockets.
/datum/memory/lost_spaghetti
	story_value = STORY_VALUE_AMAZING // This doesn't happen very often
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The mob losing their spaghet

/datum/memory/lost_spaghetti/get_names()
	return list("[protagonist_name]掉出意大利面的糗事。")

/datum/memory/lost_spaghetti/get_starts()
	return list(
		"意大利面从[protagonist_name]的口袋里倾泻而出",
		"[protagonist_name]的口袋装不下那些意大利面",
	)

/datum/memory/lost_spaghetti/get_moods()
	return list(
		"意大利面倾泻而出，[protagonist_name][mood_verb]。",
		"[protagonist_name]试图捡起散落的残渣，[mood_verb]。",
	)

/// Got kissed! AHHHHH!
/datum/memory/kissed
	story_value = STORY_VALUE_MEH
	// Sorry but blind people can't feel kisses...
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The mob being kissed
	// Deuteragonist - The mob doing the kissing

/datum/memory/kissed/get_names()
	return list("送给[protagonist_name]的飞吻。")

/datum/memory/kissed/get_starts()
	return list(
		"[protagonist_name]收到了[deuteragonist_name]的飞吻",
		"[deuteragonist_name]向[protagonist_name]送出飞吻",
	)

/datum/memory/kissed/get_moods()
	return list(
		"飞吻落在脸颊上，[protagonist_name][mood_verb]。",
		"这一刻，[protagonist_name][mood_verb]。",
	)

/// Had some good food.
/datum/memory/good_food
	story_value = STORY_VALUE_MEH
	// Protagonist - The mob consuming the food
	/// The name of the food item being consumed
	var/food

/datum/memory/good_food/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	obj/item/food,
)
	src.food = food.name
	return ..()

/datum/memory/good_food/get_names()
	return list("[protagonist_name]吃过的美味[food]。")

/datum/memory/good_food/get_starts()
	return list(
		"[food]改变了[protagonist_name]对美食的看法",
		"[food]让[protagonist_name]吃得肚皮滚圆、心满意足",
		"[food]给[protagonist_name]留下了长久的印象",
		"[protagonist_name]享用着极其美味的[food]",
		"[protagonist_name]吃下[food]，露出日常动画里才有的夸张反应",
	)

/datum/memory/good_food/get_moods()
	return list("[protagonist_name]又吃了一口，[mood_verb]。")

/// Had a good drink.
/datum/memory/good_drink
	story_value = STORY_VALUE_MEH
	// Protagonist - The mob consuming the drink
	/// The name of the nice drink reagent
	var/drink

/datum/memory/good_drink/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	datum/reagent/drink,
)
	src.drink = drink.name
	return ..()

/datum/memory/good_drink/get_names()
	return list("[protagonist_name]喝过的美味[drink]。")

/datum/memory/good_drink/get_starts()
	return list(
		"[drink]改变了[protagonist_name]对高雅饮酒的看法",
		"[drink]给[protagonist_name]留下了长久的印象",
		"[protagonist_name]享用着极其美味的[drink]",
		"[protagonist_name]啜饮着可口的[drink]",
	)

/datum/memory/good_drink/get_moods()
	return list("[protagonist_name]又喝了一口，[mood_verb]。")

/// Was set on fire and started to burn.
/datum/memory/was_burning
	story_value = STORY_VALUE_MEH
	// Protagonist - The mob burning

/datum/memory/was_burning/get_names()
	return list("[protagonist_name]浑身着火。")

/datum/memory/was_burning/get_starts()
	return list(
		"[protagonist_name]突然燃起火焰",
		"[protagonist_name]变成一支人形火炬",
		"烈火吞没了[protagonist_name]",
	)

/datum/memory/was_burning/get_moods()
	return list("皮肤正在熔化，[protagonist_name][mood_verb]。")

/// Got a limb removed by force.
/datum/memory/was_dismembered
	story_value = STORY_VALUE_AMAZING
	// Protagonist - The mob who lost a limb
	/// The limb (in plaintext) that got lost (ends up being "left arm" or "right leg")
	var/lost_limb

/datum/memory/was_dismembered/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	obj/item/bodypart/lost_limb,
)
	src.lost_limb = lost_limb.plaintext_zone
	return ..()

/datum/memory/was_dismembered/get_names()
	return list("[protagonist_name]失去了[lost_limb]。")

/datum/memory/was_dismembered/get_starts()
	return list(
		"[protagonist_name]获得了使用残障人士停车位的资格",
		"[protagonist_name]的[lost_limb]被轰向深渊",
		"[protagonist_name]的[lost_limb]飞了出去",
	)

/datum/memory/was_dismembered/get_moods()
	return list(
		"失去[lost_limb]后，[protagonist_name][mood_verb]。",
		"没有了[lost_limb]，[protagonist_name][mood_verb]。",
	)

/// Our pet died...
/datum/memory/pet_died
	story_value = STORY_VALUE_AMAZING
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist - The mob who saw the pet die
	// Deuteragonist - The pet which died

/datum/memory/pet_died/get_names()
	return list("[deuteragonist_name]的死亡。")

/datum/memory/pet_died/get_starts()
	return list(
		"人们悼念着空间站的宠物[deuteragonist_name]",
		"一群船员参加了[deuteragonist_name]的葬礼",
		"[deuteragonist_name]躺在一个浅坑中",
	)

/datum/memory/pet_died/get_moods()
	return list(
		"失去[deuteragonist_name]的陪伴，[protagonist_name][mood_verb]。",
		"[deuteragonist_name]已经不在了，[protagonist_name][mood_verb]。",
	)

/// The revolution was triumphant!
/// Given to head revs and those nearby when the revs win a revolution.
/datum/memory/revolution_rev_victory
	story_value = STORY_VALUE_LEGENDARY
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist - The head revolutionary that won the revolution

/datum/memory/revolution_rev_victory/get_names()
	return list("[protagonist_name]在[station_name()]发起的革命。")

/datum/memory/revolution_rev_victory/get_starts()
	return list(
		"[protagonist_name]在旧日独裁者的尸体上升起革命的旗帜",
		"一面旗帜在尸堆上方飘扬，[protagonist_name]站在其旁",
		"一张海报上的[station_name()]被打了个叉，宣告新时代到来",
		"前任舰长的雕像被推倒，[protagonist_name]站在旁边",
	)

/datum/memory/revolution_rev_victory/get_moods()
	return list(
		"面对[station_name()]的陷落，[protagonist_name][mood_verb]。",
		"想到即将到来的新时代，[protagonist_name][mood_verb]。",
	)

/// Given to heads of staff if they lose a revolution and are alive still.
/datum/memory/revolution_heads_defeated
	story_value = STORY_VALUE_NONE
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - The head of staff that lost the revolution

/datum/memory/revolution_heads_defeated/get_names()
	return list("[protagonist_name]被革命者击败。")

/datum/memory/revolution_heads_defeated/get_starts()
	return list(
		"[protagonist_name]因革命成功而羞愧地逃离[station_name()]",
		"[protagonist_name]看着监控中横冲直撞的革命者",
		"一张海报上，[protagonist_name]的脸被划花了",
	)

/datum/memory/revolution_heads_defeated/get_moods()
	return list(
		"面对[station_name()]的陷落，[protagonist_name][mood_verb]。",
		"面对失败，[protagonist_name][mood_verb]。",
	)

/// Given to head revs for failing the revolution!
/datum/memory/revolution_rev_defeat
	story_value = STORY_VALUE_NONE
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - The head revolutionary that lost the revolution

/datum/memory/revolution_rev_defeat/get_names()
	return list(
		"[protagonist_name]被纳诺传讯击败。",
		"[protagonist_name]的光荣革命宣告终结。",
	)

/datum/memory/revolution_rev_defeat/get_starts()
	return list("[protagonist_name]因革命失败而羞愧地逃离[station_name()]")

/datum/memory/revolution_rev_defeat/get_moods()
	return list("面对失败，[protagonist_name][mood_verb]。")

/// Given to heads of staff, and those around them, upon defeating the revolutionaries.
/datum/memory/revolution_heads_victory
	story_value = STORY_VALUE_AMAZING // Not as cool as a rev victory. Everyone loves underdog stories
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - The head of staff that won the revolution

/datum/memory/revolution_heads_victory/get_names()
	return list("[protagonist_name]和纳诺传讯粉碎了可恨的革命。")

/datum/memory/revolution_heads_victory/get_starts()
	return list(
		"击败革命者后，[protagonist_name]拍掉手上的灰尘",
		"纳诺传讯的旗帜在[station_name()]的舰桥上飘扬，[protagonist_name]骄傲地站在旁边",
	)

/datum/memory/revolution_rev_defeat/get_moods()
	return list("纳诺传讯粉碎了革命，[protagonist_name][mood_verb]。")

/// Watched someone receive a commendation medal
/datum/memory/received_medal
	story_value = STORY_VALUE_AMAZING
	memory_flags = MEMORY_FLAG_NOSTATIONNAME|MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist - The person being given a medal
	// Deuteragonist - The mob awarding a medal
	/// The name of the medal being rewarded
	var/medal_type
	/// The text on the medal / the commendation / the input
	var/medal_text

/datum/memory/received_medal/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	obj/item/medal_type,
	medal_text,
)
	src.medal_type = medal_type.name
	src.medal_text = medal_text
	return ..()

/datum/memory/received_medal/get_names()
	return list("向[protagonist_name]颁发[medal_type]的仪式。")

/datum/memory/received_medal/get_starts()
	return list(
		"[protagonist_name]从[deuteragonist_name]手中接过刻有“[medal_text]”的[medal_type]",
		"[protagonist_name]获颁刻有“[medal_text]”的[medal_type]",
		"[deuteragonist_name]将刻有“[medal_text]”的[medal_type]颁给[protagonist_name]",
	)

/datum/memory/received_medal/get_moods()
	return list(
		"接过勋章时，[protagonist_name][mood_verb]。",
		"拿着刚获得的奖章，[protagonist_name][mood_verb]。",
	)

/// Killed a Megafauna
/datum/memory/megafauna_slayer
	story_value = STORY_VALUE_LEGENDARY
	// Protagonist - The person who killed the megafauna
	// Antagonist - The megafauna

/datum/memory/megafauna_slayer/get_names()
	return list("[antagonist_name]被斩杀。")

/datum/memory/megafauna_slayer/get_starts()
	return list(
		"[protagonist_name]使出最后一击，击倒了[antagonist_name]",
		"[protagonist_name]手提[antagonist_name]的头颅站立着",
		"[protagonist_name]杀死了危险的巨型生物[antagonist_name]",
	)

/datum/memory/megafauna_slayer/get_moods()
	return list(
		"眼中的杀意逐渐消退，[protagonist_name][mood_verb]。",
		"[protagonist_name]搜寻尸体上的财物，[mood_verb]。",
	)

/// Got held at gunpoint by someone!
/datum/memory/held_at_gunpoint
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - Who was held at gunpoint
	// Deuteragonist - Who held them at gunpoint
	// Antagonist - The gun

/datum/memory/held_at_gunpoint/get_names()
	return list("[protagonist_name]被枪口指着。")

/datum/memory/held_at_gunpoint/get_starts()
	return list(
		"[deuteragonist_name]将[antagonist_name]抵住[protagonist_name]的脑袋",
		"[deuteragonist_name]猛地掏出[antagonist_name]，指向[protagonist_name]",
	)

/datum/memory/held_at_gunpoint/get_moods()
	return list(
		"面对这一局面，[protagonist_name][mood_verb]。",
		"[protagonist_name]盯着[antagonist_name]的枪口，[mood_verb]。",
	)


/datum/memory/won_jackpot
	story_value = STORY_VALUE_AMAZING

/datum/memory/won_jackpot/get_names()
	return list("[protagonist_name]赢得大奖。")

/datum/memory/won_jackpot/get_starts()
	return list(
		"[protagonist_name]双眼冒着金钱符号，扳动[deuteragonist_name]的拉杆。",
		"[protagonist_name]拉下拉杆，[deuteragonist_name]奏响一段小曲。",
	)

/datum/memory/won_jackpot/get_moods()
	return list(
		"[protagonist_name]收起[deuteragonist_name]吐出的钱，[mood_verb]。",
		"[deuteragonist_name]鸣响着吐出金钱，[protagonist_name][mood_verb]。",
	)

/// Saw someone get gibbed.
/datum/memory/witness_gib
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_FLAG_NOMOOD
	// Protagonist - Who got gibbed

/datum/memory/witness_gib/get_names()
	return list("[protagonist_name]炸成了碎片。")

/datum/memory/witness_gib/get_starts()
	return list(
		"[protagonist_name]炸成细碎的肉块",
		"[protagonist_name]转眼间化为一摊肉泥",
	)

/// Saw someone get crushed by a vending machine.
/datum/memory/witness_vendor_crush
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_SKIP_UNCONSCIOUS
	// Protagonist - Who got crushed
	// Antagonist - The vendor that crushed them

/datum/memory/witness_vendor_crush/get_names()
	return list("[protagonist_name]被[antagonist_name]压住。")

/datum/memory/witness_vendor_crush/get_starts()
	return list(
		"[protagonist_name]被[antagonist_name]压在下面",
		"[antagonist_name]轰然倒在[protagonist_name]身上",
		"[antagonist_name]倒下，压住了[protagonist_name]",
	)

/datum/memory/witness_vendor_crush/get_moods()
	return list(
		"[protagonist_name]躺在机器下面，[mood_verb]。",
		"一件商品从[antagonist_name]中掉出，[protagonist_name][mood_verb]。"
	)

/// Saw someone get dusted by the supermatter.
/datum/memory/witness_supermatter_dusting
	story_value = STORY_VALUE_AMAZING
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - Who got dusted
	// Antagonist - The supermatter

/datum/memory/witness_supermatter_dusting/get_names()
	return list("[antagonist_name]使[protagonist_name]化为灰烬。")

/datum/memory/witness_supermatter_dusting/get_starts()
	return list(
		"[protagonist_name]触碰[antagonist_name]后变成了一堆白骨",
		"[antagonist_name]使[protagonist_name]化为灰烬",
		"[protagonist_name]因过于靠近[antagonist_name]而灰飞烟灭",
	)

/datum/memory/witness_supermatter_dusting/get_moods()
	return list(
		"身体逐渐消散，[protagonist_name][mood_verb]。",
		"身体分解为原子，[protagonist_name][mood_verb]。",
	)

/// Played cards with another person.
/datum/memory/playing_cards
	story_value = STORY_VALUE_MEH
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The player
	// Deuteragonist - The game dealer (which may be a player OR in the players list)
	/// What card game is being played
	var/game
	/// The card the protagonist is holding
	var/protagonist_held_card
	/// A string (english list) of all the mobs playing the game
	var/formatted_players_list

/datum/memory/playing_cards/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	game,
	obj/item/protagonist_held_card,
	list/mob/living/other_players,
)
	src.game = game
	src.protagonist_held_card = protagonist_held_card.name

	var/list/story_players = list()
	for(var/mob/living/player as anything in other_players)
		// This will result in some strange structure sometimes -
		// "The assistant, the assistant, and the assistant playing a game",
		// but meh. Someone can improve upon it in the future
		story_players += build_story_character(player)

	src.formatted_players_list = english_list(story_players, nothing_text = "无人", comma_text = "、", and_text = "和", final_comma_text = "")
	return ..()

/datum/memory/playing_cards/get_names()
	return list("[protagonist_name]与[formatted_players_list]玩[game]。")

/datum/memory/playing_cards/get_starts()
	return list(
		"[formatted_players_list]等待[protagonist_name]开始[game]",
		"[deuteragonist_name]已经布置好[game]",
		"[deuteragonist_name]开始洗牌，准备玩[game]",
	)

/datum/memory/playing_cards/get_moods()
	return list(
		"[protagonist_name]拿着[protagonist_held_card]准备玩[game]，[mood_verb]。",
		"[protagonist_name]拿起[protagonist_held_card]，[mood_verb]。",
		"[protagonist_name]放下[protagonist_held_card]，[mood_verb]。",
	)

/// Played 52 card pickup with another person.
/datum/memory/playing_card_pickup
	story_value = STORY_VALUE_OKAY
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist - The guy who initiated the game
	// Deuteragonist - The guy who got the cards thrown in their face
	// Antagonist - The deck of cards

/datum/memory/playing_card_pickup/get_names()
	return list("[protagonist_name]用[antagonist_name]骗[deuteragonist_name]玩“捡起52张牌”的恶作剧。")

/datum/memory/playing_card_pickup/get_starts()
	return list(
		"[protagonist_name]把[antagonist_name]扔向[deuteragonist_name]，纸牌撒了一地",
		"[protagonist_name]扔出的[antagonist_name]散开，糊在[deuteragonist_name]脸上",
	)

/datum/memory/playing_card_pickup/get_moods()
	return list(
		"[protagonist_name]戏弄着[deuteragonist_name]，[mood_verb]。",
		"[deuteragonist_name]羞愧地捡起纸牌，[mood_verb]。",
	)

/// Saw someone play Russian Roulette.
/datum/memory/witnessed_russian_roulette
	memory_flags = MEMORY_CHECK_BLINDNESS
	// Protagonist = The guy who played roulette
	// Antagonist = The revolver
	/// The bodypart the protagonist was aiming at
	var/aimed_at
	/// How many rounds were loaded in the revolver
	var/rounds_loaded
	/// The result of the game ("won"(survived) or "lost"(shot themselves))
	var/result

/datum/memory/witnessed_russian_roulette/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	aimed_at,
	rounds_loaded = 0,
	result,
)
	src.aimed_at = aimed_at
	src.rounds_loaded = rounds_loaded
	src.result = result

	if(result == "won")
		// The more bullets, the better the story.
		story_value = max(STORY_VALUE_NONE, rounds_loaded)
	else
		story_value = STORY_VALUE_SHIT

	return ..()

/datum/memory/witnessed_russian_roulette/get_names()
	return list("[protagonist_name]玩俄罗斯轮盘赌。")

/datum/memory/witnessed_russian_roulette/get_starts()
	return list(
		"[protagonist_name]将枪口对准自己的[aimed_at]，即将扣下扳机。",
		"左轮手枪的弹巢中装着[rounds_loaded]发子弹。",
		"[protagonist_name]转动左轮手枪的弹巢，拿生命下注。",
	)

/datum/memory/witnessed_russian_roulette/get_moods()
	return list("在这场致命的轮盘赌中[result == "won" ? "获胜" : "落败"]时，[protagonist_name][mood_verb]。")

/// When a heretic finishes their ritual of knowledge
/datum/memory/heretic_knowledge_ritual
	story_value = STORY_VALUE_AMAZING
	// Protagonist = heretic

/datum/memory/heretic_knowledge_ritual/get_names()
	return list("[protagonist_name]通过诡秘研究汲取无尽知识。")

/datum/memory/heretic_knowledge_ritual/get_starts()
	return list(
		"[protagonist_name]用绿色焦油和蜡烛布置出一个圆环",
		"[protagonist_name]周围的数本书自行翻开",
		"绿色与紫色的能量围绕着[protagonist_name]",
		"[protagonist_name]瞪大眼睛，一眨不眨地读着一本怪书",
		"一堆血肉与内脏摆在复杂的符文上",
		"[protagonist_name]勾画着一个巨大而怪异的圆环"
	)

/datum/memory/heretic_knowledge_ritual/get_moods()
	return list("手中力量的光芒闪耀，[protagonist_name][mood_verb]。")

/datum/memory/heretic_knowledge_ritual/get_happy_moods()
	return list("疯狂地咯咯大笑")

/datum/memory/heretic_knowledge_ritual/get_neutral_moods()
	return list("咧嘴大笑，目光却一片空白")

/datum/memory/heretic_knowledge_ritual/get_sad_moods()
	return list("歇斯底里地咯咯大笑")

/// Failed to defuse a bomb, by triggering it early.
/datum/memory/bomb_defuse_failure
	story_value = STORY_VALUE_NONE // Anyone who gets this is probably dead
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist = (failed) defuser
	// Antagonist = bomb

/datum/memory/bomb_defuse_failure/get_names()
	return list("[protagonist_name]未能拆除[antagonist_name]。")

/datum/memory/bomb_defuse_failure/get_starts()
	return list(
		"[protagonist_name]剪错了[antagonist_name]上的电线",
		"[antagonist_name]发出巨响，[protagonist_name]紧张得汗流不止，抬手护住脸",
		"[antagonist_name]上的计时器突然跳到0秒"
	)

/datum/memory/bomb_defuse_failure/get_moods()
	return list("[protagonist_name]剪断[antagonist_name]上的电线，[mood_verb]。")

/// Succeeded in defusing a bomb!
/datum/memory/bomb_defuse_success
	story_value = STORY_VALUE_LEGENDARY // Very sick, and can't be gotten from training bombs
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_CHECK_DEAFNESS
	// Protagonist = defuser
	// Antagonist = bomb
	/// This is the time left (in seconds) of the bomb at defusal
	var/bomb_time_left

/datum/memory/bomb_defuse_success/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	bomb_time_left = -1,
)
	src.bomb_time_left = bomb_time_left
	return ..()

/datum/memory/bomb_defuse_success/get_names()
	return list("[protagonist_name]成功拆除了[antagonist_name]。")

/datum/memory/bomb_defuse_success/get_starts()
	return list(
		"[protagonist_name]剪断了[antagonist_name]上的正确电线",
		"[antagonist_name]发出刺耳的哔声，[protagonist_name]紧张得汗流不止，抬手护住脸",
		"[antagonist_name]上的计时器停在[bomb_time_left]"
	)

/datum/memory/bomb_defuse_success/get_moods()
	return list("[protagonist_name]剪断[antagonist_name]上的电线，[mood_verb]。")


/datum/memory/helped_up
	story_value = STORY_VALUE_OKAY

/datum/memory/helped_up/get_names()
	return list("[protagonist_name]彬彬有礼地扶起[deuteragonist_name]。")

/datum/memory/helped_up/get_starts()
	return list(
		"[protagonist_name]扶起[deuteragonist_name]",
		"[deuteragonist_name]握住[protagonist_name]友善伸出的手，站起身来",
	)

/// Catching a fish
/datum/memory/caught_fish
	story_value = STORY_VALUE_OKAY

/datum/memory/caught_fish/get_names()
	return list(
		"[protagonist_name]钓上了一条大得惊人的鱼。",
		"[protagonist_name]钓上了[deuteragonist_name]。",
	)

/datum/memory/caught_fish/get_starts()
	return list(
		"[protagonist_name]收起鱼线",
		"[protagonist_name]眼中闪过一道光，开始收线",
		"[protagonist_name]沉浸在垂钓中，钓到了什么",
		"[protagonist_name]开始与一条鱼较量",
		"一场热火朝天的垂钓正在进行",
	)

/datum/memory/caught_fish/get_moods()
	return list(
		"[deuteragonist_name]跃出水面，[protagonist_name][mood_verb]！",
		"钓到[deuteragonist_name]时，[protagonist_name][mood_verb]！",
		"[protagonist_name]捧着[deuteragonist_name]摆姿势，[mood_verb]！",
	)

/datum/memory/caught_fish/get_sad_moods()
	return list("借垂钓疗愈心情")

/// Becoming a mutant via infusion
/datum/memory/dna_infusion
	story_value = STORY_VALUE_MEH
	///describing what they turn into, "skittish", "nomadic", etc
	var/mutantlike

/datum/memory/dna_infusion/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	mutantlike,
)
	src.mutantlike = mutantlike
	return ..()

/datum/memory/dna_infusion/get_names()
	return list(
		"[protagonist_name]与[deuteragonist_name]进行DNA融合。",
		"[protagonist_name]将[deuteragonist_name]的DNA融入自身。",
	)

/datum/memory/dna_infusion/get_starts()
	return list(
		"[protagonist_name]走进一台令人毛骨悚然的DNA机器",
		"[protagonist_name]参与了一场疯狂的科学实验",
		"DNA融合器关上舱门，将[protagonist_name]留在里面",
		"[deuteragonist_name]位于融合槽中"
	)

/datum/memory/dna_infusion/get_moods()
	return list(
		"与[deuteragonist_name]进行DNA融合时，[protagonist_name][mood_verb]！",
		"与[deuteragonist_name]融为一体时，[protagonist_name][mood_verb]。",
		"[deuteragonist_name]的DNA融入自身时，[protagonist_name][mood_verb]。",
		"与[deuteragonist_name]融合后，[protagonist_name]变得更加[mutantlike]！",
		"与[deuteragonist_name]融为一体后，[protagonist_name]变得更加[mutantlike]。",
		"[deuteragonist_name]的DNA融入自身后，[protagonist_name]变得更加[mutantlike]。",
	)

/datum/memory/dna_infusion/get_happy_moods()
	return list(
		"为了科学忍受着痛苦",
		"痛得龇牙咧嘴，却仍信心十足"
	)

/datum/memory/dna_infusion/get_neutral_moods()
	return list(
		"痛苦地尖叫",
		"开始后悔自己的决定"
	)

/datum/memory/dna_infusion/get_sad_moods()
	return list("痛苦地抛弃了自己的人类身份")

/// Who rev'd me, so if a mindreader reads a rev, they have a clue on who to hunt down
/datum/memory/recruited_by_headrev

/datum/memory/recruited_by_headrev/get_names()
	return list("[protagonist_name]被[antagonist_name]转化为革命者。")

/datum/memory/recruited_by_headrev/get_starts()
	return list(
		"[antagonist_name]发出的闪光让[protagonist_name]心中只剩一个暴力目标：杀死各部门主管。",
		"[antagonist_name]将奇怪的装置举到[protagonist_name]眼前，闪光将杀戮指令烙入脑海。",
	)

/// Who converted into a blood brother
/datum/memory/recruited_by_blood_brother

/datum/memory/recruited_by_blood_brother/get_names()
	return list("[protagonist_name]被[antagonist_name]招募为歃血兄弟。")

/datum/memory/recruited_by_blood_brother/get_starts()
	return list(
		"[antagonist_name]对[protagonist_name]显得过分友善，即将招募其成为歃血兄弟。",
		"[protagonist_name]被带入[antagonist_name]充斥着犯罪与间谍活动的生活。",
	)

/// Saw someone play Russian Roulette.
/datum/memory/witnessed_gods_wrath
	memory_flags = MEMORY_CHECK_BLINDNESS|MEMORY_SKIP_UNCONSCIOUS
	story_value = STORY_VALUE_AMAZING

/datum/memory/witnessed_gods_wrath/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
)

/datum/memory/witnessed_gods_wrath/get_names()
	return list("[protagonist_name]承受[antagonist_name]的怒火。")

/datum/memory/witnessed_gods_wrath/get_starts()
	return list(
		"[protagonist_name]焚烧[deuteragonist_name]，于是[antagonist_name]将[protagonist_name]化为一片血雾。",
		"[protagonist_name]亵渎了[deuteragonist_name]，被[antagonist_name]炸成无数碎片。",
		"[protagonist_name]因亵渎[deuteragonist_name]而激怒[antagonist_name]，随即灰飞烟灭。",
	)

/datum/memory/witnessed_gods_wrath/get_moods()
	return list("被[antagonist_name]彻底毁灭时，[protagonist_name][mood_verb]。")

/datum/memory/witnessed_gods_wrath/get_happy_moods()
	return list(
		"歇斯底里地咯咯大笑",
		"疯狂地大笑",
		"咧嘴大笑",
	)

/datum/memory/witnessed_gods_wrath/get_neutral_moods()
	return list(
		"显得忧心忡忡",
		"重新思考自己的人生选择",
		"面无表情",
	)

/datum/memory/witnessed_gods_wrath/get_sad_moods()
	return list(
		"显得垂头丧气",
		"满心懊悔",
		"绝望地龇牙咧嘴"
	)
