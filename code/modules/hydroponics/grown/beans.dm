// Soybeans
/obj/item/seeds/soya
	name = "大豆种子包"
	desc = "这些种子能长成大豆植株。"
	icon_state = "seed-soybean"
	species = "soybean"
	plantname = "大豆植株"
	product = /obj/item/food/grown/soybeans
	maturation = 4
	production = 4
	potency = 15
	growthstages = 4
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "soybean-grow"
	icon_dead = "soybean-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/soya/koi, /obj/item/seeds/soya/butter)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/consumable/nutriment/fat/oil = 0.03) //Vegetable oil!

/obj/item/food/grown/soybeans
	seed = /obj/item/seeds/soya
	name = "大豆"
	desc = "味道挺寡淡，却有无穷的可能……"
	gender = PLURAL
	icon_state = "soybeans"
	foodtypes = VEGETABLES
	tastes = list("soy" = 1)
	distill_reagent = /datum/reagent/consumable/soysauce

/obj/item/food/grown/soybeans/juice_typepath()
	return /datum/reagent/consumable/soymilk

// Koibean
/obj/item/seeds/soya/koi
	name = "锦鲤豆种子包"
	desc = "这些种子能长成锦鲤豆植株。"
	icon_state = "seed-koibean"
	species = "koibean"
	plantname = "锦鲤豆植株"
	product = /obj/item/food/grown/koibeans
	potency = 10
	mutatelist = null
	reagents_add = list(/datum/reagent/toxin/carpotoxin = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.05)
	rarity = PLANT_MODERATELY_RARE

/obj/item/food/grown/koibeans
	seed = /obj/item/seeds/soya/koi
	name = "锦鲤豆"
	desc = "这些豆子有点鱼腥味，软乎乎的，似乎一捏就碎！"
	icon_state = "koibeans"
	foodtypes = VEGETABLES
	tastes = list("koi" = 1)
	wine_power = 40

//Now squeezable for imitation carpmeat
/obj/item/food/grown/koibeans/attack_self(mob/living/user)
	user.visible_message(span_notice("[user]把[src]捏成了一块类似鲤鱼肉的东西。"), span_notice("你把[src]捏成了一块类似鲤鱼肉的东西。"))
	playsound(user, 'sound/effects/blob/blobattack.ogg', 50, TRUE)
	var/obj/item/food/fishmeat/carp/imitation/fishie = new(null)
	fishie.reagents.set_all_reagents_purity(seed.get_reagent_purity())
	qdel(src)
	user.put_in_hands(fishie)
	return TRUE

//Butterbeans, the beans wid da butta!
// Butterbeans! - Squeeze for a single butter slice!
/obj/item/seeds/soya/butter
	name = "黄油豆种子包"
	desc = "这些种子能长成黄油豆植株。"
	icon_state = "seed-butterbean"
	species = "butterbean"
	plantname = "黄油豆植株"
	product = /obj/item/food/grown/butterbeans
	potency = 10
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/milk = 0.05, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/cream = 0.05)
	rarity = 20

/obj/item/food/grown/butterbeans
	seed = /obj/item/seeds/soya/butter
	name = "黄油豆"
	desc = "柔软绵滑，奶香浓郁……简直可以直接抹在吐司上。"
	icon_state = "butterbeans"
	foodtypes = VEGETABLES | DAIRY
	tastes = list("creamy butter" = 1)
	distill_reagent = /datum/reagent/consumable/yoghurt

/obj/item/food/grown/butterbeans/attack_self(mob/living/user)
	user.visible_message(span_notice("[user]把[src]捏成了一小块黄油。"), span_notice("你把[src]捏成了类似黄油的东西。"))
	playsound(user, 'sound/effects/blob/blobattack.ogg', 50, TRUE)
	var/obj/item/food/butterslice/butties = new(null)
	butties.reagents.set_all_reagents_purity(seed.get_reagent_purity())
	qdel(src)
	user.put_in_hands(butties)
	return TRUE

// Green Beans
/obj/item/seeds/greenbean
	name = "green bean seed pack"
	desc = "These seeds grow into green bean plants."
	icon_state = "seed-greenbean"
	species = "greenbean"
	plantname = "Green Bean Plants"
	product = /obj/item/food/grown/greenbeans
	instability = 0
	maturation = 4
	production = 3
	potency = 10
	growthstages = 4
	icon_dead = "bean-dead"
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/never_mutate, /datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/greenbean/jump)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/medicine/c2/multiver = 0.04) //They're good for you!
	graft_gene = /datum/plant_gene/trait/never_mutate

/obj/item/food/grown/greenbeans
	seed = /obj/item/seeds/greenbean
	name = "green beans"
	desc = "Simple and healthy, what more do you need?"
	gender = PLURAL
	icon_state = "greenbean"
	foodtypes = FRUIT
	tastes = list("beans" = 1)

// Jumping Bean
/obj/item/seeds/greenbean/jump
	name = "jumping bean seed pack"
	desc = "These seeds grow into jumping bean plants."
	icon_state = "seed-jumpingbean"
	species = "jumpingbean"
	plantname = "Jumping Bean Plants"
	product = /obj/item/food/grown/jumpingbeans
	yield = 2
	instability = 18
	maturation = 8
	production = 4
	potency = 20
	genes = list(/datum/plant_gene/trait/stable_stats, /datum/plant_gene/trait/repeated_harvest)
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05, /datum/reagent/ants = 0.1) //IRL jumping beans contain insect larve, hence the ants
	graft_gene = /datum/plant_gene/trait/stable_stats
	rarity = PLANT_MODERATELY_RARE

/obj/item/food/grown/jumpingbeans
	seed = /obj/item/seeds/greenbean/jump
	name = "jumping bean"
	desc = "Umm, what's causing it to move like that?"
	icon_state = "jumpingbean"
	foodtypes = FRUIT | BUGS
	tastes = list("bugs" = 1)
