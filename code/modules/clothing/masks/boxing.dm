/obj/item/clothing/mask/balaclava
	name = "巴拉克拉瓦头套"
	desc = "大把钞票！"
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	alternate_worn_layer = LOW_FACEMASK_LAYER //This lets it layer below glasses and headsets; yes, that's below hair, but it already has HIDEHAIR
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/balaclava/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/floortilebalaclava
	name = "地砖迷彩巴拉克拉瓦头套"
	desc = "专为走廊作战设计的最新地砖迷彩巴拉克拉瓦头套。\
		透气性、柔韧性和舒适度俱佳，由迷彩杰设计。"
	icon_state = "floortile_balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	alternate_worn_layer = LOW_FACEMASK_LAYER
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/floortilebalaclava/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -5) //tacticool

/obj/item/clothing/mask/floortilebalaclava/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/luchador
	name = "墨西哥摔角面具"
	desc = "强健的格斗选手佩戴的面具，助你高高跃起击败敌人！"
	icon_state = "luchag"
	inhand_icon_state = null
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/luchador/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("luchador_replacement.json", "luchador"), end_string = " 好样的！", end_string_chance = 25, uppercase = TRUE, slots = ITEM_SLOT_MASK)

/obj/item/clothing/mask/luchador/tecnicos
	name = "正派摔角面具"
	desc = "由维护正义、光明磊落地战斗的强健格斗选手佩戴。"
	icon_state = "luchador"

/obj/item/clothing/mask/luchador/rudos
	name = "反派摔角面具"
	desc = "由为了获胜而不择手段的强健格斗选手佩戴。"
	icon_state = "luchar"

/obj/item/clothing/mask/russian_balaclava
	name = "俄式巴拉克拉瓦头套"
	desc = "保护你的脸免受风雪侵袭。"
	icon_state = "rus_balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	alternate_worn_layer = LOW_FACEMASK_LAYER //This lets it layer below glasses and headsets; yes, that's below hair, but it already has HIDEHAIR
	w_class = WEIGHT_CLASS_SMALL
