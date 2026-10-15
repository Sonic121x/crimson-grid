// TODO: Repath these to remove keys. They have no real relation to them.
/obj/item/vamp/keys/hack
	name = "\improper 撬锁工具"
	desc = "能打开某些门，不过是非法的……<br>手持此工具查看门，可以估算门锁的强度；如果建筑支持踩点，还会开始侦察。"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "hack"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/keys
	resistance_flags = FIRE_PROOF | ACID_PROOF
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')

