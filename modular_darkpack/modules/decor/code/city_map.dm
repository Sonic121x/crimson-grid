/obj/structure/city_map
	name = "\improper 城市地图"
	desc = "立即找到你的位置。"
	icon = 'modular_darkpack/modules/decor/icons/city_map.dmi'
	icon_state = "map"
	anchored = TRUE
	density = TRUE
	var/page_link = "Map"

/obj/structure/city_map/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "导航", rmb_text = "打开地图")

/obj/structure/city_map/attack_hand(mob/user)
	. = ..()
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[initial(icon_state)]-snow"
	if(!isliving(user))
		return TRUE
	var/mob/living/navigator = user
	navigator.navigate()

/obj/structure/city_map/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	var/wiki_url = CONFIG_GET(string/wikiurl)
	if(!wiki_url)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	var/confirmation = (alert(user, "要在维基上查看地图吗？", "[src]", "是", "否"))
	if(confirmation == "是")
		DIRECT_OUTPUT(user, link("[wiki_url]/[page_link]"))
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
