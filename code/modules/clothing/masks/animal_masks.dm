GLOBAL_LIST_INIT(localized_animal_mask_names, list("pig" = "猪", "horse" = "马", "rat" = "老鼠", "fox" = "狐狸", "bee" = "蜜蜂", "bear" = "熊", "bat" = "蝙蝠", "raven" = "渡鸦", "jackal" = "胡狼", "tribal" = "部落"))
GLOBAL_LIST_INIT(cursed_animal_masks, list(
		/obj/item/clothing/mask/animal/pig/cursed,
		/obj/item/clothing/mask/animal/frog/cursed,
		/obj/item/clothing/mask/animal/cowmask/cursed,
		/obj/item/clothing/mask/animal/horsehead/cursed,
		/obj/item/clothing/mask/animal/small/rat/cursed,
		/obj/item/clothing/mask/animal/small/fox/cursed,
		/obj/item/clothing/mask/animal/small/bee/cursed,
		/obj/item/clothing/mask/animal/small/bear/cursed,
		/obj/item/clothing/mask/animal/small/bat/cursed,
		/obj/item/clothing/mask/animal/small/raven/cursed,
		/obj/item/clothing/mask/animal/small/jackal/cursed
	))

/obj/item/clothing/mask/animal
	abstract_type = /obj/item/clothing/mask
	w_class = WEIGHT_CLASS_SMALL
	clothing_flags = VOICEBOX_TOGGLABLE
	var/modifies_speech = TRUE
	flags_cover = MASKCOVERSMOUTH

	var/animal_type ///what kind of animal the masks represents. used for automatic name and description generation.
	var/list/animal_sounds ///phrases to be said when the player attempts to talk when speech modification / voicebox is enabled.
	var/list/animal_sounds_alt ///lower probability phrases to be said when talking.
	var/animal_sounds_alt_probability ///probability for alternative sounds to play.

	var/cursed ///if it's a cursed mask variant.
	var/curse_spawn_sound ///sound to play when the cursed mask variant is spawned.

/obj/item/clothing/mask/animal/Initialize(mapload)
	. = ..()
	if(cursed)
		make_cursed()

/obj/item/clothing/mask/animal/equipped(mob/M, slot)
	. = ..()
	if ((slot & ITEM_SLOT_MASK) && modifies_speech)
		RegisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/mask/animal/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/mask/animal/vv_edit_var(vname, vval)
	if(vname == NAMEOF(src, cursed))
		if(vval)
			if(!cursed)
				make_cursed()
		else if(cursed)
			clear_curse()
	if(vname == NAMEOF(src, modifies_speech) && ismob(loc))
		var/mob/M = loc
		if(M.get_item_by_slot(ITEM_SLOT_MASK) == src)
			if(vval)
				if(!modifies_speech)
					RegisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
			else if(modifies_speech)
				UnregisterSignal(M, COMSIG_MOB_SAY)
	return ..()

/obj/item/clothing/mask/animal/examine(mob/user)
	. = ..()
	if(clothing_flags & VOICEBOX_TOGGLABLE)
		. += span_notice("变声器目前[clothing_flags & VOICEBOX_DISABLED ? "已关闭" : "已开启"]。<b>按住Alt点击</b>可切换。")

/obj/item/clothing/mask/animal/click_alt(mob/user)
	if(!(clothing_flags & VOICEBOX_TOGGLABLE))
		return NONE
	clothing_flags ^= VOICEBOX_DISABLED
	to_chat(user, span_notice("你[clothing_flags & VOICEBOX_DISABLED ? "关闭" : "开启"]了[src]的变声器。"))
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/animal/proc/make_cursed() //apply cursed effects.
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_MASK_TRAIT)
	clothing_flags = NONE //force animal sounds to always on.
	if(flags_inv == initial(flags_inv))
		flags_inv = HIDEFACIALHAIR
	name = "[GLOB.localized_animal_mask_names[animal_type] || animal_type || "异化"]面孔"
	desc = "看起来像[initial(name)]，但仔细查看才发现，它已经与这个人的脸融为一体！"
	if(curse_spawn_sound)
		playsound(src, curse_spawn_sound, 50, TRUE)
	var/update_speech_mod = !modifies_speech && LAZYLEN(animal_sounds)
	if(update_speech_mod)
		modifies_speech = TRUE
	if(ismob(loc))
		var/mob/M = loc
		if(M.get_item_by_slot(ITEM_SLOT_MASK) == src)
			if(update_speech_mod)
				RegisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
			to_chat(M, span_userdanger("[src]被诅咒了！"))
			M.update_worn_mask()
			M.refresh_obscured()

/obj/item/clothing/mask/animal/proc/clear_curse()
	REMOVE_TRAIT(src, TRAIT_NODROP, CURSED_MASK_TRAIT)
	clothing_flags = initial(clothing_flags)
	flags_inv = initial(flags_inv)
	name = initial(name)
	desc = initial(desc)
	var/update_speech_mod = modifies_speech && !initial(modifies_speech)
	if(update_speech_mod)
		modifies_speech = FALSE
	if(ismob(loc))
		var/mob/M = loc
		if(M.get_item_by_slot(ITEM_SLOT_MASK) == src)
			to_chat(M, span_notice("[src]的诅咒已解除！"))
			if(update_speech_mod)
				UnregisterSignal(M, COMSIG_MOB_SAY)
			M.update_worn_mask()

/obj/item/clothing/mask/animal/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	if(clothing_flags & VOICEBOX_DISABLED)
		return
	if(!modifies_speech || !LAZYLEN(animal_sounds))
		return
	speech_args[SPEECH_MESSAGE] = pick((prob(animal_sounds_alt_probability) && LAZYLEN(animal_sounds_alt)) ? animal_sounds_alt : animal_sounds)

/obj/item/clothing/mask/animal/equipped(mob/user, slot)
	if(!iscarbon(user))
		return ..()
	if((slot & ITEM_SLOT_MASK) && HAS_TRAIT_FROM(src, TRAIT_NODROP, CURSED_MASK_TRAIT))
		to_chat(user, span_userdanger("[src]被诅咒了！"))
	return ..()


/obj/item/clothing/mask/animal/pig
	name = "猪面具"
	desc = "一个内置变声器的橡胶猪面具。"
	animal_type = "pig"
	icon_state = "pig"
	inhand_icon_state = null
	animal_sounds = list("哼！","嗷——！","哼哼！")
	curse_spawn_sound = 'sound/effects/magic/pighead_curse.ogg'
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/animal/pig/cursed
	cursed = TRUE

///frog mask - reeee!!
/obj/item/clothing/mask/animal/frog
	name = "青蛙面具"
	desc = "一个雕成青蛙形状的古老面具。<br>理智就像重力，只需轻轻一推。"
	icon_state = "frog"
	inhand_icon_state = null
	animal_sounds = list("咿！！", "咿咿！！","咿——！！","咿————！！")
	animal_sounds_alt_probability = 5
	animal_sounds_alt = list("呼——！！","火辣辣——！！","你好，我的宝贝；你好，我的甜心；你好，我的拉格泰姆姑娘。", "真难受，老兄。", "把这家伙从我身上弄走！！" ,"谁来阻止我！！", "现充滚出去！！")
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/animal/frog/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, cursed ? 4 : -4)

/obj/item/clothing/mask/animal/frog/make_cursed()
	. = ..()
	RemoveElement(/datum/element/adjust_fishing_difficulty, -4)
	AddElement(/datum/element/adjust_fishing_difficulty, 4)

/obj/item/clothing/mask/animal/frog/clear_curse()
	. = ..()
	RemoveElement(/datum/element/adjust_fishing_difficulty, 4)
	AddElement(/datum/element/adjust_fishing_difficulty, -4)

/obj/item/clothing/mask/animal/frog/cursed
	cursed = TRUE

/obj/item/clothing/mask/animal/cowmask
	name = "牛面具"
	icon_state = "cowmask"
	inhand_icon_state = null
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	curse_spawn_sound = 'sound/effects/magic/cowhead_curse.ogg'
	animal_sounds = list("哞————！","哞！","哞——！")

/obj/item/clothing/mask/animal/cowmask/cursed
	cursed = TRUE

/obj/item/clothing/mask/animal/horsehead
	name = "马面具"
	desc = "用柔软的乙烯基塑料和乳胶制成的马头面具。"
	animal_type = "horse"
	icon_state = "horsehead"
	inhand_icon_state = null
	animal_sounds = list("咴咴————！", "咴咴——！", "咴咴！", "嘶————！", "嘶——！")
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEEYES|HIDEEARS|HIDESNOUT
	curse_spawn_sound = 'sound/effects/magic/horsehead_curse.ogg'

/obj/item/clothing/mask/animal/horsehead/cursed
	cursed = TRUE

/obj/item/clothing/mask/animal/small
	name = "小动物面具"
	desc = "If you're seeing this, yell at a coder."
	abstract_type = /obj/item/clothing/mask/animal/small
	flags_inv = HIDEFACE|HIDESNOUT

/obj/item/clothing/mask/animal/small/make_cursed()
	flags_inv = NONE
	return ..()

/obj/item/clothing/mask/animal/small/rat
	name = "老鼠面具"
	desc = "用柔软的乙烯基塑料和乳胶制成的鼠头面具。"
	animal_type = "rat"
	icon_state = "rat"
	inhand_icon_state = null
	animal_sounds = list("吱！","吱——！","吱吱！")

/obj/item/clothing/mask/animal/small/rat/cursed
	cursed = TRUE

/obj/item/clothing/mask/animal/small/fox
	name = "狐狸面具"
	desc = "用柔软的乙烯基塑料和乳胶制成的狐狸头面具。"
	animal_type = "fox"
	icon_state = "fox"
	inhand_icon_state = null
	animal_sounds = list("嗷嗷！","嗷嗷嗷嗷呜——！","咯咯！","嗷呜！","呼哧！")

/obj/item/clothing/mask/animal/small/fox/cursed
	cursed = TRUE

/obj/item/clothing/mask/animal/small/bee
	name = "蜜蜂面具"
	desc = "用柔软的乙烯基塑料和乳胶制成的蜜蜂头面具。"
	animal_type = "bee"
	icon_state = "bee"
	inhand_icon_state = null
	animal_sounds = list("嗡！", "嗡嗡！", "嗡——！", "嗡嗡嗡——！")

/obj/item/clothing/mask/animal/small/bee/cursed
	cursed = TRUE

/obj/item/clothing/mask/animal/small/bear
	name = "熊面具"
	desc = "用柔软的乙烯基塑料和乳胶制成的熊头面具。"
	animal_type = "bear"
	icon_state = "bear"
	inhand_icon_state = null
	animal_sounds = list("嗷吼！","吼！","呜！","呜吼！")

/obj/item/clothing/mask/animal/small/bear/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, cursed ? 4 : -4)

/obj/item/clothing/mask/animal/small/bear/make_cursed()
	. = ..()
	RemoveElement(/datum/element/adjust_fishing_difficulty, -4)
	AddElement(/datum/element/adjust_fishing_difficulty, 4)

/obj/item/clothing/mask/animal/small/bear/clear_curse()
	. = ..()
	RemoveElement(/datum/element/adjust_fishing_difficulty, 4)
	AddElement(/datum/element/adjust_fishing_difficulty, -4)

/obj/item/clothing/mask/animal/small/bear/cursed
	cursed = TRUE

/obj/item/clothing/mask/animal/small/bat
	name = "蝙蝠面具"
	desc = "用柔软的乙烯基塑料和乳胶制成的蝙蝠头面具。"
	animal_type = "bat"
	icon_state = "bat"
	inhand_icon_state = null

/obj/item/clothing/mask/animal/small/bat/cursed
	cursed = TRUE


/obj/item/clothing/mask/animal/small/raven
	name = "渡鸦面具"
	desc = "用柔软的乙烯基塑料和乳胶制成的渡鸦头面具。"
	icon_state = "raven"
	inhand_icon_state = null
	animal_type = "raven"
	animal_sounds = list("嘎！", "嘎、嘎！", "嘎嘎！")
	animal_sounds_alt = list("永不复还……")
	animal_sounds_alt_probability = 1

/obj/item/clothing/mask/animal/small/raven/cursed
	cursed = TRUE

/obj/item/clothing/mask/animal/small/jackal
	name = "胡狼面具"
	desc = "用柔软的乙烯基塑料和乳胶制成的胡狼头面具。"
	animal_type = "jackal"
	icon_state = "jackal"
	inhand_icon_state = null
	animal_sounds = list("汪！", "汪呜！", "汪汪！", "嗷呜——！")

/obj/item/clothing/mask/animal/small/jackal/cursed
	cursed = TRUE

/obj/item/clothing/mask/animal/small/tribal
	name = "部落面具"
	desc = "一个木雕面具，细节经过手工精心雕琢。"
	animal_type = "tribal" //honk.
	icon_state = "bumba"
	inhand_icon_state = null
	animal_sounds = list("邪门的巫术啊，老兄！", "赞美洛阿神灵！", "那是邪恶的魔法！", "玩你的伏都巫术吧，老兄！")
	animal_sounds_alt = list("伊库姆·博库姆！", "乌梅纳卡！", "在我脑海里……僵尸……僵尸！")
	animal_sounds_alt_probability = 5

/obj/item/clothing/mask/animal/small/tribal/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, cursed ? 5 : -5)

/obj/item/clothing/mask/animal/small/tribal/make_cursed()
	. = ..()
	RemoveElement(/datum/element/adjust_fishing_difficulty, -5)
	AddElement(/datum/element/adjust_fishing_difficulty, 5)

/obj/item/clothing/mask/animal/small/tribal/clear_curse()
	. = ..()
	RemoveElement(/datum/element/adjust_fishing_difficulty, 5)
	AddElement(/datum/element/adjust_fishing_difficulty, -5)

/obj/item/clothing/mask/animal/small/tribal/cursed //adminspawn only.
	cursed = TRUE
