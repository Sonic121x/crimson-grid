// Starthistle
/obj/item/seeds/starthistle
	name = "星蓟种子包"
	desc = "一种顽强的杂草，常从飞船停泊场的地面裂缝中钻出来。"
	icon_state = "seed-starthistle"
	plant_icon_offset = 3
	species = "starthistle"
	plantname = "星蓟"
	lifespan = 70
	endurance = 50 // damm pesky weeds
	maturation = 5
	production = 1
	yield = 2
	potency = 10
	instability = 35
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_flowers.dmi'
	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy)
	mutatelist = list(/obj/item/seeds/starthistle/corpse_flower, /obj/item/seeds/galaxythistle)
	graft_gene = /datum/plant_gene/trait/plant_type/weed_hardy

/obj/item/seeds/starthistle/harvest(mob/user)
	var/obj/machinery/hydroponics/parent = loc
	var/seed_count = yield
	if(prob(getYield() * 20))
		seed_count++
		var/output_loc = parent.Adjacent(user) ? user.loc : parent.loc
		for(var/i in 1 to seed_count)
			var/obj/item/seeds/starthistle/harvestseeds = Copy()
			harvestseeds.forceMove(output_loc)

	parent.update_tray(user, seed_count)

// Corpse flower
/obj/item/seeds/starthistle/corpse_flower
	name = "尸花种子包"
	desc = "一种散发恶臭的植物。大气条件不适宜时会停止产生臭味。"
	icon_state = "seed-corpse-flower"
	species = "corpse-flower"
	plantname = "尸花"
	production = 2
	growing_icon = 'icons/obj/service/hydroponics/growing_flowers.dmi'
	genes = list(/datum/plant_gene/trait/gas_production)
	mutatelist = null
	reagents_add = list(/datum/reagent/toxin/formaldehyde = 0.1, /datum/reagent/fluorine = 0.1)

//Galaxy Thistle
/obj/item/seeds/galaxythistle
	name = "银河蓟种子包"
	desc = "一种令人惊叹的杂草，据信由普通水飞蓟演化而来。含有能帮助修复受损肝脏的黄酮木脂素。"
	icon_state = "seed-galaxythistle"
	species = "galaxythistle"
	plantname = "银河蓟"
	product = /obj/item/food/grown/galaxythistle
	lifespan = 70
	endurance = 40
	maturation = 3
	production = 2
	yield = 2
	potency = 25
	instability = 35
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_flowers.dmi'
	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy, /datum/plant_gene/trait/invasive/galaxythistle)
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05, /datum/reagent/medicine/silibinin = 0.1)
	graft_gene = /datum/plant_gene/trait/invasive

/obj/item/food/grown/galaxythistle
	seed = /obj/item/seeds/galaxythistle
	name = "银河蓟花头"
	desc = "这簇带刺的小花让你想起了高地。"
	icon_state = "galaxythistle"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	wine_power = 35
	tastes = list("thistle" = 2, "artichoke" = 1)
