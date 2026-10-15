GLOBAL_LIST_INIT(sarcophagus_passwords, list(
	"AMARANTH",
	"ANTEDILUVIAN",
	"PROMETHEAN",
	"NEMESIS",
	"GEHENNA",
	"JYHAD",
	"CARTHAGOS",
	"ENOCH",
	"IRAD",
	"ZILLAH",
	"CAPPADOCIAN",
	"NODDIST",
	"USURPERS",
	"DELUGE",
	"SHADOWLANDS",
	"LILITH",
	"FORGIVENESS",
	"DARKFATHER"
))
GLOBAL_LIST_INIT(caesar_cipher, list(
	"A" = 1,
	"B" = 2,
	"C" = 3,
	"D" = 4,
	"E" = 5,
	"F" = 6,
	"G" = 7,
	"H" = 8,
	"I" = 9,
	"J" = 10,
	"K" = 11,
	"L" = 12,
	"M" = 13,
	"N" = 14,
	"O" = 15,
	"P" = 16,
	"Q" = 17,
	"R" = 18,
	"S" = 19,
	"T" = 20,
	"U" = 21,
	"V" = 22,
	"W" = 23,
	"X" = 24,
	"Y" = 25,
	"Z" = 26
))

/proc/get_encipher_num(letter, password)
	var/num = GLOB.caesar_cipher[letter]
	var/enciphed = num+password
	if(num+password > 26)
		enciphed = (num+password)-26
	return GLOB.caesar_cipher[enciphed]

/proc/get_uncipher_num(letter, password)
	var/num = GLOB.caesar_cipher[letter]
	var/unciphed = num-password
	if(num-password < 0)
		unciphed = (num-password)+26
	return GLOB.caesar_cipher[unciphed]

/proc/encipher(message, password)
	if(message)
		message = uppertext(message)
		var/final_message = ""
		for(var/i in 1 to length_char(message))
			var/letter = message[i]
			final_message += "[get_encipher_num(letter, password)]"
		return final_message

/proc/uncipher(message, password)
	if(message)
		message = uppertext(message)
		var/final_message = ""
		for(var/i in 1 to length_char(message))
			var/letter = message[i]
			final_message += "[get_uncipher_num(letter, password)]"
		return final_message


/datum/storyteller_roll/sarcophagus_cipher
	bumper_text = "查看"
	difficulty = 10
	applicable_stats = list(STAT_INTELLIGENCE, STAT_OCCULT)
	reroll_cooldown = 1 SCENES

/obj/sarcophagus
	name = "神秘石棺"
	desc = "光是看着它，就让你脊背发凉……"
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/sarcophagus.dmi'
	icon_state = "b_sarcophagus"
	// layer = CAR_LAYER
	density = TRUE
	anchored = FALSE
	pixel_w = -8
	var/password = "Brongus"
	var/passkey = 5
	var/datum/storyteller_roll/sarcophagus_cipher/cipher_roll

/obj/sarcophagus/Initialize(mapload)
	. = ..()
	password = pick(GLOB.sarcophagus_passwords)
	passkey = rand(5, 15)

	//to_chat(world, span_userdanger("<b>UNKNOWN SARCOPHAGUS POSITION HAS BEEN LEAKED</b>"))
	//if(!mapload)
	//	SEND_SOUND(world, sound('modular_darkpack/master_files/sounds/announce.ogg'))

/obj/sarcophagus/examine(mob/user)
	. = ..()
	var/message = "你看到上面刻着一段文字：<b>[encipher(password, passkey)]</b>。"
	if(isliving(user))
		if(!cipher_roll)
			cipher_roll = new()
		var/roll_result = cipher_roll.st_roll(user, src)
		if(roll_result == ROLL_SUCCESS)
			message += " 这是一种古老的密码。你在脑中逐一移动字母，最终得到了[uppertext(password)]。"
		else
			message += " 你完全不知道这是什么意思……"
	. += message

#define OPEN_SOUND 'modular_darkpack/modules/antediluvian_sarcophagus/sounds/mp_hello.ogg'
/obj/sarcophagus/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/sarcophagus_key))
		var/pass = tgui_input_text(user, "???", "???")
		if(!pass)
			return ITEM_INTERACT_BLOCKING
		if(password == uppertext(pass))
			open_the_sarcophagus()
			return ITEM_INTERACT_SUCCESS

/obj/sarcophagus/proc/open_the_sarcophagus()
	icon_state = "b_sarcophagus-open1"
	to_chat(world, span_userdanger("<b>神秘石棺已被打开</b>"))
	SEND_SOUND(world, sound('modular_darkpack/master_files/sounds/announce.ogg'))
	var/sound_length = SSsounds.get_sound_length(OPEN_SOUND)
	playsound(src, OPEN_SOUND, 100, FALSE)
	spawn(sound_length)
		icon_state = "b_sarcophagus-open0"
		if(prob(50))
			new /mob/living/simple_animal/hostile/megafauna/wendigo/antediluvian(loc)
		else
			new /mob/living/simple_animal/hostile/megafauna/colossus/antediluvian(loc)
#undef OPEN_SOUND

/obj/sarcophagus/bomb

/obj/sarcophagus/bomb/open_the_sarcophagus()
	icon_state = "b_sarcophagus-open2"
	to_chat(world, span_userdanger("<b>神秘石棺已被打开</b>"))
	SEND_SOUND(world, sound('modular_darkpack/master_files/sounds/announce.ogg'))
	playsound(src, 'sound/items/weapons/armbomb.ogg', 100, FALSE)
	anchored = TRUE
	addtimer(CALLBACK(src, PROC_REF(explode)), 6 SECONDS)

/obj/sarcophagus/bomb/proc/explode()
	explosion(src, devastation_range = 2, heavy_impact_range = 7, light_impact_range = 11)
	qdel(src)
	priority_announce(
		"突发新闻！！！据报道，本地区发生大规模爆炸。请应急救援人员尽快赶赴现场，营救幸存者。全体市民即刻实行宵禁，直至城市恢复安全。",
		"紧急突发新闻",
		'modular_darkpack/modules/events/sounds/news_notification.ogg',
		ANNOUNCEMENT_TYPE_PRIORITY,
		color_override = "red",
	)

/obj/sarcophagus/empty

/obj/sarcophagus/empty/open_the_sarcophagus()
	icon_state = "b_sarcophagus-open0"
	to_chat(world, span_userdanger("<b>神秘石棺已被打开</b>"))
	SEND_SOUND(world, sound('modular_darkpack/master_files/sounds/announce.ogg'))

/obj/fake_sarcophagus
	name = "神秘石棺"
	desc = "光是看着它，就让你脊背发凉……"
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/sarcophagus.dmi'
	icon_state = "b_sarcophagus"
	density = TRUE
	anchored = TRUE
	pixel_w = -8

/obj/fake_sarcophagus/voivode
	name = "\improper 沉眠领主的石棺"
	desc = "沉眠领主长眠于此。"

/obj/item/sarcophagus_key
	name = "石棺钥匙"
	desc = "一件古老而奇异的东西……"
	icon_state = "sarcophagus_key"
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/key.dmi'
	w_class = WEIGHT_CLASS_SMALL
