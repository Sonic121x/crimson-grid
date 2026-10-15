/obj/item/holosign_creator/police_tape
	name = "警戒带卷"
	desc = "一卷警用警戒带，用来封锁犯罪现场，防止公众进入。"
	icon = 'modular_darkpack/master_files/icons/obj/devices/tool.dmi'
	icon_state = "police_tape"
	custom_materials = null
	custom_price = PAYCHECK_LOWER

	holosign_type = /obj/structure/holosign/barrier/police_tape
	creation_time = 1 SECONDS
	max_signs = 9

/obj/item/holosign_creator/police_tape/attack_self(mob/user)
	if(LAZYLEN(signs))
		for(var/obj/structure/holosign/hologram as anything in signs)
			qdel(hologram)
		balloon_alert(user, "已收起警戒带")
