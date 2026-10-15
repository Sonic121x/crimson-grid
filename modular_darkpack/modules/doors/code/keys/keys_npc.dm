/obj/item/vamp/keys/npc
	name = "一串钥匙"
	accesslocks = list(
		"npc"
	)

/obj/item/vamp/keys/npc/Initialize(mapload)
	. = ..()
	accesslocks = list(
		"npc[rand(1, 20)]"
	)

/obj/item/vamp/keys/npc/fix
	roundstart_fix = TRUE
