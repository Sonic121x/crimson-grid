/obj/ritual_rune/thaumaturgy/teleport
	name = "传送"
	desc = "在城市街道间传送自身。需要一袋血。"
	icon_state = "rune6"
	word = "CLAV'TRANSITUM"
	level = 5
	sacrifices = list(/obj/item/reagent_containers/blood)

/obj/ritual_rune/thaumaturgy/teleport/complete()
	. = ..()
	if(!activated)
		activated = TRUE
		color = rgb(255,255,255)
		icon_state = "teleport"

/obj/ritual_rune/thaumaturgy/teleport/attack_hand(mob/user)
	. = ..()
	if(activated)
		if(last_activator != user)
			to_chat(user, span_warning("这道符文不是由你激活的！"))
			return
		var/direction = tgui_input_list(user, "选择方向：", "传送符文", list("北", "东", "南", "西"))
		if(direction)
			var/x_dir = user.x
			var/y_dir = user.y
			var/step = 1
			var/min_distance = 10
			var/max_distance = 20
			var/valid_destination = FALSE
			var/turf/destination = null

			if(get_dist(src, user) > 1)
				to_chat(user, span_warning("你已经离开了符文附近！"))
				return

			// Move at least min_distance tiles in the chosen direction
			while(step <= min_distance)
				switch(direction)
					if("北")
						y_dir += 1
					if("东")
						x_dir += 1
					if("南")
						y_dir -= 1
					if("西")
						x_dir -= 1
				step += 1

			// Continue moving until a valid destination is found or max_distance is reached
			while(step <= max_distance && !valid_destination)
				switch(direction)
					if("北")
						y_dir += 1
					if("东")
						x_dir += 1
					if("南")
						y_dir -= 1
					if("西")
						x_dir -= 1

				if(x_dir < 15 || x_dir > 240 || y_dir < 15 || y_dir > 240)
					to_chat(user, span_warning("你不能传送到城市之外！"))
					return

				destination = locate(x_dir, y_dir, user.z)
				if(destination && !istype(destination, /turf/open/space/basic) && !istype(destination, /turf/closed/wall/vampwall))
					valid_destination = TRUE
				else
					step += 1

			if(valid_destination)
				playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
				user.forceMove(destination)
				qdel(src)
			else
				to_chat(user, span_warning("找不到可用的目的地，法术失败了！"))


