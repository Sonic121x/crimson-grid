
/datum/emote/living/custom
	stat_allowed = SOFT_CRIT

/datum/emote/living/nodnod
	key = "nod2"
	key_third_person = "nod2s"
	message = "点了两下头。"
	message_param = "朝%t点了两下头。"

/datum/emote/living/blush
	sound = 'modular_darkpack/modules/emotes/sound/blush.ogg'

/datum/emote/living/snap2
	key = "snap2"
	key_third_person = "snaps twice"
	message = "打了两下响指。"
	message_param = "朝%t打了两下响指。"
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'modular_darkpack/modules/emotes/sound/snap2.ogg'

/datum/emote/living/snap3
	key = "snap3"
	key_third_person = "snaps thrice"
	message = "打了三下响指。"
	message_param = "朝%t打了三下响指。"
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'modular_darkpack/modules/emotes/sound/snap3.ogg'

/datum/emote/living/mousesqueak
	key = "squeak"
	key_third_person = "squeaks"
	message = "吱吱叫了起来！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/mobs/non-humanoids/mouse/mousesqueek.ogg'

/datum/emote/living/pop
	key = "pop"
	key_third_person = "pops"
	message = "发出了啵的一声。"
	message_param = "朝%t发出了啵的一声。"
	message_mime = "无声地做出啵的动作。"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_darkpack/modules/emotes/sound/slime_pop.ogg'

/datum/emote/living/meow
	key = "meow"
	key_third_person = "meows"
	message = "喵喵叫了起来！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = SFX_CAT_MEOW

/datum/emote/living/headtilt
	key = "tilt"
	key_third_person = "tilts"
	message = "歪了歪头。"
	message_AI = "把显示屏上的图像倾斜了一下。"
	emote_type = EMOTE_VISIBLE

/datum/emote/living/blink2
	key = "blink2"
	key_third_person = "blinks twice"
	message = "眨了两下眼。"
	message_AI = "让显示屏闪烁了两下。"

/datum/emote/living/rblink
	key = "rblink"
	key_third_person = "rapidly blinks"
	message = "飞快地眨着眼！"
	message_AI = "让显示面板飞快地闪烁！"
	sound = 'modular_darkpack/modules/emotes/sound/blinkrapid.ogg'

/datum/emote/living/smirk
	key = "smirk"
	key_third_person = "smirks"
	message = "露出一丝得意的笑。"

/datum/emote/living/eyeroll
	key = "eyeroll"
	key_third_person = "rolls their eyes"
	message = "翻了个白眼。"

/datum/emote/living/huff
	key = "huff"
	key_third_person = "huffs"
	message = "气呼呼地哼了一声！"

/datum/emote/living/etwitch
	key = "etwitch"
	key_third_person = "twitches their ears"
	message = "抖了抖耳朵"

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "像乌鸦一样嘎地叫了一声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_darkpack/modules/emotes/sound/caw.ogg'

/datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "像乌鸦一样嘎嘎叫了两声！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_darkpack/modules/emotes/sound/caw2.ogg'

/datum/emote/living/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "歇斯底里地狂笑起来！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_darkpack/modules/emotes/sound/cackle_yeen.ogg'

/datum/emote/living/mggaow
	key = "mggaow"
	key_third_person = "meows loudly"
	message = "大声喵喵叫了起来！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_darkpack/modules/emotes/sound/mggaow.ogg'

/datum/emote/living/thump
	key = "thump"
	key_third_person = "thumps"
	message = "重重地跺了跺脚！"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/effects/glass/glassbash.ogg'

/datum/emote/living/gulp
	key = "gulp"
	key_third_person = "gulps"
	message = "紧张地咽了口唾沫。"
	message_mime = "无声地咽了口唾沫！"
	vary = TRUE
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/gulp/get_sound(mob/living/user)
	return pick(
		'modular_darkpack/modules/emotes/sound/gulp1.ogg',
		'modular_darkpack/modules/emotes/sound/gulp2.ogg',
	)

/datum/emote/living/carbon/wink
	sound = 'modular_darkpack/modules/emotes/sound/wink.ogg'

/datum/emote/living/carbon/human/blink
	sound = 'modular_darkpack/modules/emotes/sound/blink.ogg'

/datum/emote/living/giggle/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(user.physique == FEMALE)
		return pick(
			'modular_darkpack/modules/emotes/sound/female/female_giggle_1.ogg',
			'modular_darkpack/modules/emotes/sound/female/female_giggle_2.ogg',
			'modular_darkpack/modules/emotes/sound/female/female_giggle_3.ogg',
			'modular_darkpack/modules/emotes/sound/female/female_giggle_4.ogg',
		)
	return pick(
		'modular_darkpack/modules/emotes/sound/male/male_giggle_1.ogg',
		'modular_darkpack/modules/emotes/sound/male/male_giggle_1.ogg',
		'modular_darkpack/modules/emotes/sound/male/male_giggle_1.ogg',
	)
