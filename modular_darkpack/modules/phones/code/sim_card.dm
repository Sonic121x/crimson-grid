/obj/item/sim_card
	name = "\improper SIM 卡"
	desc = "一张绑定了电话号码的 SIM 卡。"
	ONFLOOR_ICON_HELPER(null)
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "ssd_micro"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/published = FALSE
	var/published_name = "" //the published number listing for this sim

	var/phone_number = ""
	var/datum/weakref/phone_weakref = null

/obj/item/sim_card/Initialize(mapload)
	. = ..()
	if(!phone_number)
		phone_number = SSphones.generate_phone_number(src)

/obj/item/sim_card/Destroy(force)
	. = ..()
	SSphones.assigned_phone_numbers.Remove(src)
	for(var/contact in SSphones.published_phone_numbers)
		if(SSphones.published_phone_numbers[contact] == phone_number)
			SSphones.published_phone_numbers.Remove(src)
	phone_weakref = null

/obj/item/sim_card/examine(mob/user)
	. = ..()
	. += span_notice("[EXAMINE_HINT("互动")]以将其捏碎。")

/obj/item/sim_card/attack_self(mob/user, modifiers)
	. = ..()

	balloon_alert(user, "你开始捏碎[src]！")
	if(do_after(user, 5 SECONDS, src))
		balloon_alert(user, "你捏碎了[src]！")
		new /obj/effect/decal/cleanable/blood/gibs/robot_debris/plastic(get_turf(user))
		qdel(src)
		return TRUE
	return FALSE

/obj/effect/decal/cleanable/blood/gibs/robot_debris/plastic
	name = "塑料碎片"
	desc = "一堆毫无用处的碎片……"

////////////////////////////////////////////////////////////////////////////////////////

/obj/item/sim_card/emergency
	name = "\improper 紧急服务 SIM 卡"
	desc = "一张号码为 911 的 SIM 卡。"
	phone_number = "911"

/obj/item/sim_card/emergency/Initialize(mapload)
	SSphones.assigned_phone_numbers[src] = phone_number
	. = ..()

/obj/item/sim_card/cleaner
	name = "\improper 清洁服务 SIM 卡"
	desc = "一张绑定了清洁公司号码的 SIM 卡。"
	phone_number = "1415444444"

/obj/item/sim_card/cleaner/Initialize(mapload)
	SSphones.assigned_phone_numbers[src] = phone_number
	. = ..()

/obj/item/sim_card/landline
	name = "\improper 固定电话 SIM 卡"
	desc = "请把我放回公用电话里。"

/obj/item/sim_card/landline/Initialize(mapload)
	phone_number = SSphones.generate_phone_number(src, TRUE)
	. = ..()
