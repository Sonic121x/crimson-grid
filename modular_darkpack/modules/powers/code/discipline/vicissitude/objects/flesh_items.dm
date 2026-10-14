/obj/item/autosurgeon/vicissitude
	name = "小兄弟"
	desc = "一只技艺高超的血肉造物，无需大动手术就能将植入物或器官植入主人身体。 \
		它的嘴正急切地等着吞入植入物或器官。不过它相当贪婪，误放进去的物品必须用螺丝刀才能撬出来。"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 10, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/structure/fleshwall
	name = "血肉墙"
	desc = "用血肉筑成的墙。"
	icon = 'modular_darkpack/modules/powers/icons/flesh_objects.dmi'
	icon_state = "fleshwall"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	max_integrity = 100
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/tzijelly
	name = "胶状怪物"
	desc = "血肉网络的重要组成部分。"
	icon = 'modular_darkpack/modules/powers/icons/flesh_objects.dmi'
	icon_state = "tzijelly"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	max_integrity = 100
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 30)

/obj/item/ground_heir
	name = "土袋"
	desc = "英雄之力在此铸就……"
	icon_state = "dirt"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

// Why is this NOT a floor type.
/obj/effect/decal/gut_floor
	name = "内脏地板"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "tzimisce_floor"
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT)

/obj/effect/decal/gut_floor/Initialize(mapload)
	. = ..()
	if(isopenturf(get_turf(src)))
		var/turf/open/T = get_turf(src)
		if(T)
			T.slowdown = 1

/obj/effect/decal/gut_floor/Destroy()
	. = ..()
	var/turf/open/T = get_turf(src)
	if(T)
		T.slowdown = initial(T.slowdown)

/obj/structure/chair/old/tzimisce
	icon = 'modular_darkpack/modules/powers/icons/flesh_objects.dmi'
	icon_state = "tzimisce_stool"
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/guts
	name = "肠脏"
	desc = "不过是血和肠脏……"
	icon_state = "guts"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/spine
	name = "脊柱"
	desc = "要是我能掌控就好了……"
	icon_state = "spine"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/suit/vampire/trench/tzi
	name = "血肉大衣"
	desc = "人皮夹克。"
	icon_state = "trench_tzi"
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 50)
	armor_type = /datum/armor/fleshcoat
	clothing_traits = list(TRAIT_UNMASQUERADE)

/datum/armor/fleshcoat
	melee = 50
	bullet = 50
	laser = 10
	energy = 10
	bomb = 25
	acid = 10
	wound = 50

/obj/item/organ/cyberimp/brain/anti_stun/tzi
	name = "副肾上腺"
	desc = "这个器官会在你被击晕时分泌强效兴奋剂混合物，缩短失去行动能力的时间。安装于头部。"
	icon_state = "tongueayylmao"
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 25)

/obj/item/organ/eyes/night_vision/tzimisce
	low_light_cutoff = list(15, 6, 8)
	medium_light_cutoff = list(35, 20, 25)
	high_light_cutoff = list(50, 40, 40)
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 15)
