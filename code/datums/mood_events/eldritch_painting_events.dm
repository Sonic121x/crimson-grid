// These mood events are related to /obj/structure/sign/painting/eldritch
// Names are based on the subtype of painting they belong to

// Mood applied for ripping the painting
/datum/mood_event/eldritch_painting
	description = "自从割下那幅画，我就一直听见古怪的笑声……"
	mood_change = -6
	timeout = 3 MINUTES

/datum/mood_event/eldritch_painting/weeping
	description = "祂就在这里！"
	mood_change = -3
	timeout = 11 SECONDS

/datum/mood_event/eldritch_painting/weeping_heretic
	description = "祂的苦难赋予我灵感！"
	mood_change = 5
	timeout = 3 MINUTES

/datum/mood_event/eldritch_painting/weeping_withdrawal
	description = "我的头脑清醒了。祂不在这里。"
	mood_change = 1
	timeout = 3 MINUTES

/datum/mood_event/eldritch_painting/desire_heretic
	description = "虚空在尖叫。"
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/eldritch_painting/desire_examine
	description = "饥渴暂时得到了满足……"
	mood_change = 3
	timeout = 3 MINUTES

/datum/mood_event/eldritch_painting/heretic_vines
	description = "多么可爱的花啊！"
	mood_change = 3
	timeout = 3 MINUTES

/datum/mood_event/eldritch_painting/rust_examine
	description = "那幅画真让我毛骨悚然。"
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/eldritch_painting/rust_heretic_examine
	description = "攀爬。腐朽。锈蚀。"
	mood_change = 6
	timeout = 3 MINUTES
