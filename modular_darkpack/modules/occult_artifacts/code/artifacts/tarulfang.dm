// DARKPACK TODO - FRENZY - (This never did FUCK anything.)
/obj/item/occult_artifact/vampire/tarulfang
	true_name = "塔鲁之牙"
	true_desc = "降低陷入狂乱的几率。"
	icon_state = "tarulfang"

/obj/item/occult_artifact/vampire/tarulfang/grant_powers()
	. = ..()
	owner.frenzy_chance_boost = 5

/obj/item/occult_artifact/vampire/tarulfang/ungrant_powers()
	. = ..()
	owner.frenzy_chance_boost = 10
