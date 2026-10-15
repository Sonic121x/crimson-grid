/obj/item/clothing/mask/fakemoustache
	name = "假八字胡"
	desc = "警告：胡子是假的。"
	icon_state = "fake-moustache"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEFACE
	species_exception = list(/datum/species/golem)

/obj/item/clothing/mask/fakemoustache/italian
	name = "意大利八字胡"
	desc = "用真正的意大利胡须制成，让佩戴者忍不住夸张地比画手势。"

/obj/item/clothing/mask/fakemoustache/italian/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("italian_replacement.json", "italian"), end_string = list(" 意饺意饺，配方交出来！"," 我的妈呀！"," 我的妈呀！这肉丸可真辣！", " 啦啦啦啦啦，登山缆车上山啦！"), end_string_chance = 3, slots = ITEM_SLOT_MASK)
