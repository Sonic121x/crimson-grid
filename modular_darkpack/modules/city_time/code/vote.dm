#define CHOICE_15 "15分钟"
#define CHOICE_30 "30分钟"
#define CHOICE_60 "1小时"
#define CHOICE_NO "不延长"

/datum/vote/extend_night
	name = "延长黑夜"
	default_choices = list(
		CHOICE_15,
		CHOICE_30,
		CHOICE_60,
		CHOICE_NO
	)
	default_message = "投票决定将黑夜延长多久。"

/datum/vote/extend_night/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return .

	if(forced)
		return VOTE_AVAILABLE

	if(SScity_time.daytime_started)
		return "黑夜已经结束了。"

	return VOTE_AVAILABLE

/datum/vote/extend_night/finalize_vote(winning_option)
	switch(winning_option)
		if(CHOICE_NO)
			return
		if(CHOICE_15)
			SScity_time.extend_round(15 MINUTES)
		if(CHOICE_30)
			SScity_time.extend_round(30 MINUTES)
		if(CHOICE_60)
			SScity_time.extend_round(1 HOURS)

#undef CHOICE_15
#undef CHOICE_30
#undef CHOICE_60
#undef CHOICE_NO
