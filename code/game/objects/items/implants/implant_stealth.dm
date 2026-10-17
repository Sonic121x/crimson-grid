/obj/item/implant/stealth
	name = "S3植入体"
	desc = "让你在众目睽睽之下隐去身形。"
	actions_types = list(/datum/action/item_action/agent_box)

	implant_info = "手动启动。\
		在使用者周围生成一个脆弱得可怕的纸箱，内置逐步生效的光学迷彩。"

	implant_lore = "赛博太阳S3植入体，俗称\"隐身\"植入体，能让使用者\
		当场在周围生成一个\"隐身\"纸箱。为了容纳光学迷彩织层，\
		纸箱牺牲了本就微不足道的结构强度。不幸的是，光学迷彩无法瞬间启动；\
		撞到生物会打断迷彩，而每次中断后或初次启动时，\
		迷彩系统都需要重新校准周围环境。不过，一旦校准完成，它便能从肉眼前隐去。"

/obj/item/implanter/stealth
	name = "植入器（隐身）"
	imp_type = /obj/item/implant/stealth

//Box Object

/obj/structure/closet/cardboard/agent
	name = "不起眼的纸箱"
	desc = "它太普通了，你之前根本没注意到。"
	icon_state = "agentbox"
	max_integrity = 1 // "This dumb box shouldn't take more than one hit to make it vanish."
	move_speed_multiplier = 0.5
	enable_door_overlay = FALSE

/obj/structure/closet/cardboard/agent/Initialize(mapload)
	. = ..()
	go_invisible()

/obj/structure/closet/cardboard/agent/proc/go_invisible()
	animate(src, alpha = 0, time = 20)

/obj/structure/closet/cardboard/agent/after_open(mob/living/user)
	. = ..()
	qdel(src)

/obj/structure/closet/cardboard/agent/process()
	alpha = max(0, alpha - 50)

/obj/structure/closet/cardboard/agent/proc/reveal()
	alpha = 255
	addtimer(CALLBACK(src, PROC_REF(go_invisible)), 10, TIMER_OVERRIDE|TIMER_UNIQUE)

/obj/structure/closet/cardboard/agent/Bump(atom/A)
	. = ..()
	if(istype(A, /obj/machinery/door))
		for(var/mob/mob_in_box in contents)
			A.Bumped(mob_in_box)
	if(isliving(A))
		reveal()

/obj/structure/closet/cardboard/agent/Bumped(atom/movable/A)
	. = ..()
	if(isliving(A))
		reveal()
