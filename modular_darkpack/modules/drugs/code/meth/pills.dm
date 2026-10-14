/obj/item/storage/pill_bottle/ephedrine
	name = "麻黄碱药片瓶"
	desc = "瓶顶有鸦片警示标志。"
	spawn_count = 10
	spawn_type = /obj/item/reagent_containers/applicator/pill/ephedrine
	custom_price = 200

/obj/item/reagent_containers/applicator/pill/ephedrine
	name = "麻黄碱药片"
	desc = "用于稳定患者状况。"
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/medicine/ephedrine = 15)
	rename_with_volume = TRUE

//Sugar pills

/datum/reagent/drug/placebatol
	name = "Placebatol"
	description = "一种有时会被开进处方的无色无味粉末。也许根本没什么作用……？"
	//reagent_state = SOLID
	color = "#f5f5f0"
	metabolization_rate = REAGENTS_METABOLISM * 0.25
	taste_description = "sugar" //effectively a sugar pill, but sugar actually has a use

/obj/item/reagent_containers/applicator/pill/placebatol
	name = "处方药片"
	desc = "由白色粉末制成的药片。按处方服用。"
	icon_state = "pill9"
	list_reagents = list(/datum/reagent/drug/placebatol = 10)

/obj/item/storage/pill_bottle/estrogen
	name = "雌激素药片瓶"
	desc = "瓶顶画着乳房。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/placebatol

/obj/item/storage/pill_bottle/unknown
	name = "不明药片瓶"
	desc = "没有标签，看不出里面的药究竟用来治疗什么。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/placebatol
