//Contains generic skillchips that are fairly short and simple

/obj/item/skillchip/wine_taster
	name = "酒酒不同技能芯片"
	desc = "酒酒不同，第5版。"
	auto_traits = list(TRAIT_WINE_TASTER)
	skill_name = "品酒"
	skill_description = "仅凭味道辨认葡萄酒年份。面对陌生饮品，也能说得头头是道。"
	skill_icon = "wine-bottle"
	activate_message = span_notice("你回想起了葡萄酒的滋味。")
	deactivate_message = span_notice("你对葡萄酒的记忆消散了。")

/obj/item/skillchip/bonsai
	name = "绿篱3技能芯片"
	desc = "\"学习把绿篱和盆栽修剪成新造型。第三版。\""
	auto_traits = list(TRAIT_BONSAI)
	skill_name = "绿篱修剪"
	skill_description = "随便一把刀，就能把绿篱和盆栽修剪成奇妙的新造型。不适用于塑料植物。"
	skill_icon = "spa"
	activate_message = span_notice("你的脑海中充满了植物造景。")
	deactivate_message = span_notice("你再也想不起绿篱长什么样了。")

/obj/item/skillchip/useless_adapter
	name = "技能芯片适配器"
	desc = "嘿，兄弟，听说你喜欢技能芯片，所以我们给你的技能芯片里又装了个技能芯片，让你可以……呃……"
	skill_name = "无用适配器"
	skill_description = "将适配器植入大脑后，可以再往里面插入另一枚技能芯片……"
	skill_icon = "plug"
	activate_message = span_notice("你现在可以通过适配器启用另一枚芯片，但你不确定自己为什么要这么做……")
	deactivate_message = span_notice("你不再拥有这个无用的技能芯片适配器。")
	skillchip_flags = SKILLCHIP_ALLOWS_MULTIPLE
	// Literally does nothing.
	complexity = 0
	slot_use = 0

/obj/item/skillchip/light_remover
	name = "噩梦技能芯片"
	desc = "一枚传授安全拆卸灯泡知识的技能芯片。想出这个烂名字的人该被开除。"
	auto_traits = list(TRAIT_LIGHTBULB_REMOVER)
	skill_name = "拆卸灯泡"
	skill_description = "从今天起，拆灯泡再不失手，连手套都不需要！"
	skill_icon = "lightbulb"
	activate_message = span_notice("你感觉自己的痛觉感受器对高温物体没那么敏感了。")
	deactivate_message = span_notice("你感觉高温物体又能让你望而却步了……")

/obj/item/skillchip/disk_verifier
	name = "K33P-TH4T-D15K skillchip"
	desc = "A skillchip with a tiny print of a nuclear authentification disk stamped onto it."
	auto_traits = list(TRAIT_DISK_VERIFIER)
	skill_name = "Nuclear Disk Verification"
	skill_description = "Nuclear authentication disks have an extremely long serial number for verification. This skillchip stores that number, which allows the user to automatically spot forgeries."
	skill_icon = "save"
	activate_message = span_notice("You feel your mind automatically verifying long serial numbers on disk shaped objects.")
	deactivate_message = span_notice("The innate recognition of absurdly long disk-related serial numbers fades from your mind.")

/obj/item/skillchip/entrails_reader
	name = "3NTR41LS skillchip"
	auto_traits = list(TRAIT_ENTRAILS_READER)
	skill_name = "Entrails Reader"
	skill_description = "Be able to learn about a person's life, by looking at their internal organs. Not to be confused with looking into the future."
	skill_icon = "lungs"
	activate_message = span_notice("You feel that you know a lot about interpreting organs.")
	deactivate_message = span_notice("Knowledge of liver damage, heart strain and lung scars fades from your mind.")

/obj/item/skillchip/appraiser
	name = "即刻鉴定真身份卡！技能芯片"
	desc = "按技能芯片的命名标准，这名字已经不能更急切、更直白了。"
	auto_traits = list(TRAIT_ID_APPRAISER)
	skill_name = "身份卡鉴定"
	skill_description = "鉴定身份卡，辨别它是中央指挥部签发的，还是站内粗制滥造的打印品。"
	skill_icon = "magnifying-glass"
	activate_message = span_notice("你感觉自己能辨认身份卡上独特的微小细节了。")
	deactivate_message = span_notice("某些身份卡有什么特别之处来着？")

/obj/item/skillchip/sabrage
	name = "刀开香槟技能芯片"
	desc = "一枚散发淡淡酒味的技能芯片。最好配合军刀或其他锋利刀刃使用。"
	auto_traits = list(TRAIT_SABRAGE_PRO)
	skill_name = "刀开香槟技艺"
	skill_description = "让使用者了解香槟瓶颈薄弱处的精细结构，\
	提高其在军官聚会上卖弄的本领。"
	skill_icon = "bottle-droplet"
	activate_message = span_notice("你对香槟瓶以及开瓶方法有了新的理解。")
	deactivate_message = span_notice("香槟瓶中微妙的物理学知识从你的脑海中消退了。")

/obj/item/skillchip/brainwashing
	name = "suspicious skillchip"
	auto_traits = list(TRAIT_BRAINWASHING)
	skill_name = "Brainwashing"
	skill_description = "WARNING: The integrity of this chip is compromised. Please discard this skillchip."
	skill_icon = "soap"
	activate_message = span_notice("...But all at once it comes to you... something involving putting a brain in a washing machine?")
	deactivate_message = span_warning("All knowledge of the secret brainwashing technique is GONE.")

/obj/item/skillchip/brainwashing/examine(mob/user)
	. = ..()
	. += span_warning("It seems to have been corroded over time, putting this in your head may not be the best idea...")

/obj/item/skillchip/brainwashing/on_activate(mob/living/carbon/user, silent = FALSE)
	to_chat(user, span_danger("You get a pounding headache as the chip sends corrupt memories into your head!"))
	user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20)
	. = ..()

/obj/item/skillchip/chefs_kiss
	name = "爱之吻技能芯片"
	desc = "这枚技能芯片散发着淡淡的苹果派香气，真美好。使用前请咨询营养师。"
	auto_traits = list(TRAIT_CHEF_KISS)
	skill_name = "大厨之吻"
	skill_description = "亲吻自己制作的食物，让它们充满爱。"
	skill_icon = "cookie"
	activate_message = span_notice("你回想起祖母教你满怀爱意烘焙饼干的往事。")
	deactivate_message = span_notice("祖母传授给你的记忆全都消失了。那真的是你的祖母吗？")

/obj/item/skillchip/intj
	name = "综合直觉思考与判断技能芯片"
	auto_traits = list(TRAIT_REMOTE_TASTING)
	skill_name = "脑内风味演算"
	skill_description = "查看食物时，无须入口，就能体验它的滋味。"
	skill_icon = FA_ICON_DRUMSTICK_BITE
	activate_message = span_notice("你想起最爱的食物，发现自己能在脑海中翻转它的风味。")
	deactivate_message = span_notice("你感觉由食物构成的思维宫殿正在崩塌……")

/obj/item/skillchip/drunken_brawler
	name = "F0RC3 4DD1CT10N skillchip"
	desc = "A skillchip reeking of alcohol, said to improve one's fighting prowess while inebriated, as if that will save you from liver cirrhosis."
	auto_traits = list(TRAIT_DRUNKEN_BRAWLER)
	skill_name = "Drunken Unarmed Proficiency"
	skill_description = "When intoxicated, you gain increased unarmed effectiveness."
	skill_icon = "wine-bottle"
	activate_message = span_notice("You honestly could do with a drink. Never know when someone might try and jump you around here.")
	deactivate_message = span_notice("You suddenly feel a lot safer going around the station sober... ")

/obj/item/skillchip/master_angler
	name = "钓鱼大师技能芯片"
	desc = "一枚装满钓鱼与鱼类百科摘录和趣闻的技能芯片。"
	auto_traits = list(TRAIT_REVEAL_FISH, TRAIT_EXAMINE_FISHING_SPOT, TRAIT_EXAMINE_FISH, TRAIT_EXAMINE_DEEPER_FISH)
	skill_name = "渔夫慧眼"
	skill_description = "查看钓点时列出鱼类，提示正在咬钩的东西，还能提供更多信息。"
	skill_icon = "fish"
	activate_message = span_notice("你感觉几位饱经日晒的老渔夫的知识与热情在体内燃烧。")
	deactivate_message = span_notice("你不再想在阳光明媚的河畔甩竿垂钓了。")

	actions_types = list(/datum/action/cooldown/fishing_tip)

/datum/action/cooldown/fishing_tip
	name = "Dispense Fishing Tip"
	desc = "回想一条钓鱼的至理名言。"
	button_icon = 'icons/hud/radial_fishing.dmi'
	button_icon_state = "river"
	background_icon_state = "bg_default"
	overlay_icon_state = "bg_default_border"
	cooldown_time = 2.5 SECONDS //enough time to skim through tips.

/datum/action/cooldown/fishing_tip/Activate(atom/target_atom)
	. = ..()
	send_tip_of_the_round(owner, pick(GLOB.fishing_tips), source = "古老的钓鱼智慧")

/obj/item/skillchip/disposals
	name = "T4RG3T.bin skillchip"
	desc = "Become a dauntless disposaler, target trash right where it belongs."
	auto_traits = list(TRAIT_THROWINGARM)
	skill_name = "Dauntless Disposaler"
	skill_description = "You have an uncanny ability to perfectly land every toss into disposal units."
	skill_icon = "trash-can"
	activate_message = span_notice("You seem laser focused on the nearby disposal unit.")
	deactivate_message = span_notice("The nearby disposal unit fades into the background of your vision.")
