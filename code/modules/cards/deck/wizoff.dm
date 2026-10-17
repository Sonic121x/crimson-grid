//It's Wiz-Off, the wizard themed card game! It's modular too, in case you might want to make it Syndie, Sec and Clown themed or something stupid like that.
/obj/item/toy/cards/deck/wizoff
	name = "\improper 巫师对决牌组"
	desc = "一副巫师对决牌。为宇宙命运展开奥术大战：抽五张！出五张！五局三胜！附有规则卡。"
	cardgame_desc = "巫师对决游戏"
	icon_state = "deck_wizoff_full"
	deckstyle = "wizoff"

/obj/item/toy/cards/deck/wizoff/initialize_cards()
	var/card_list = strings("wizoff.json", "wizard")
	initial_cards += new /datum/deck_card/of_type(/obj/item/toy/singlecard/wizoff_ruleset) // ruleset should be the top card
	for(var/card in card_list)
		initial_cards += card

/obj/item/toy/singlecard/wizoff_ruleset
	desc = "纸牌游戏巫师对决的规则。"
	cardname = "巫师对决规则"
	deckstyle = "black"
	has_unique_card_icons = FALSE
	icon_state = "singlecard_down_black"

/obj/item/toy/singlecard/wizoff_ruleset/examine(mob/living/carbon/human/user)
	. = ..()
	. += span_notice("记住巫师对决的规则！")
	. += span_info("每位玩家抽取5张牌。")
	. += span_info("游戏共五轮。每轮各选一张牌打出，并按以下规则决出胜负：")
	. += span_info("防御克制进攻！")
	. += span_info("进攻克制辅助！")
	. += span_info("辅助克制防御！")
	. += span_info("双方打出相同类型的法术时，点数更高者获胜！")
	. += span_info("五轮中获胜次数最多的玩家赢得游戏！")
	. += span_notice("准备为宇宙的命运而战：巫师对决！")
