/datum/round_event_control/darkpack/financial_crisis
	name = "Financial Crisis"
	typepath = /datum/round_event/financial_crisis
	weight = 2
	min_players = 5
	max_occurrences = 1
	earliest_start = 50 MINUTES
	category = EVENT_CATEGORY_BUREAUCRATIC
	description = "Wall Street has crashed catastrophically causing all of Bianchi Bank's accounts to tank as people lose their savings."
	darkpack_allowed = TRUE

/datum/round_event/financial_crisis
	start_when = 1
	announce_when = 3
	var/static/list/announcement_messages = list(
		"由于近期电力波动，部分比安基银行客户可能会发现账户余额显示有误。",
		"很遗憾，近期的一次银行业务差错影响了湾区少数比安基银行客户。",
		"比安基银行服务器崩溃，导致银行账户余额显示错误。",
		"比安基银行遗憾地宣布，前沿金融产品被揭露为骗局，数万名储户的积蓄在几秒内化为乌有。",
	)

/datum/round_event/financial_crisis/announce(fake)
	var/chosen_announcement = "[pick(announcement_messages)] 请客户于周一至周五上午8:00至下午5:00的正常营业时间联系分行。"
	endpost_announce("[chosen_announcement]", "比安基银行")

/datum/round_event/financial_crisis/start()
	for(var/account_id in SSeconomy.bank_accounts_by_id)
		var/datum/bank_account/bank = SSeconomy.bank_accounts_by_id[account_id]
		if(!istype(bank, /datum/bank_account))
			continue
		bank.adjust_money(-(round(bank.account_balance * (rand(85, 95) / 100))), "金融危机") // leaves them with 5-15% of their savings

