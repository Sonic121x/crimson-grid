// Finally, peas. Base plant.
/obj/item/seeds/peas
	name = "豌豆种子包"
	desc = "这些种子能长成富含维生素的豌豆！"
	icon_state = "seed-peas"
	species = "peas"
	plantname = "豌豆藤"
	product = /obj/item/food/grown/peas
	maturation = 3
	potency = 25
	instability = 15
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "peas-grow"
	icon_dead = "peas-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/peas/laugh)
	reagents_add = list (/datum/reagent/consumable/nutriment/vitamin = 0.1, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/water = 0.05)

/obj/item/food/grown/peas
	seed = /obj/item/seeds/peas
	name = "豌豆荚"
	desc = "终于……豌豆。"
	icon_state = "peas"
	foodtypes = VEGETABLES
	tastes = list ("peas" = 1, "chalky saltiness" = 1)
	wine_power = 50
	wine_flavor = "what is, distressingly, fermented peas."

// Laughin' Peas
/obj/item/seeds/peas/laugh
	name = "欢笑豌豆种子包"
	desc = "这些种子散发着柔和的紫光……应该能长成欢笑豌豆。"
	icon_state = "seed-laughpeas"
	species = "laughpeas"
	plantname = "欢笑豌豆"
	product = /obj/item/food/grown/laugh
	maturation = 7
	potency = 10
	yield = 7
	production = 5
	growthstages = 3
	icon_grow = "laughpeas-grow"
	icon_dead = "laughpeas-dead"
	genes = list (/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/purple, /datum/plant_gene/trait/plant_laughter)
	mutatelist = list (/obj/item/seeds/peas/laugh/peace)
	reagents_add = list (/datum/reagent/consumable/laughter = 0.05, /datum/reagent/consumable/sugar = 0.05, /datum/reagent/consumable/nutriment = 0.07)
	rarity = 25 //It actually might make Central Command Officials loosen up a smidge, eh?
	graft_gene = /datum/plant_gene/trait/plant_laughter

/obj/item/food/grown/laugh
	seed = /obj/item/seeds/peas/laugh
	name = "欢笑豌豆荚"
	desc = "欢笑豆，吃下去保证让你的心情大为好转！"
	icon_state = "laughpeas"
	foodtypes = VEGETABLES
	tastes = list ("a prancing rabbit" = 1) //Vib Ribbon sends her regards.. wherever she is.
	wine_power = 90
	wine_flavor = "a vector-graphic rabbit dancing on your tongue"

/obj/item/food/grown/laugh/juice_typepath()
	return /datum/reagent/consumable/laughsyrup

// World Peas - Peace at last, peace at last...
/obj/item/seeds/peas/laugh/peace
	name = "和平豌豆种子包"
	desc = "这些硕大的种子散发着令人安心的蓝光……"
	icon_state = "seed-worldpeas"
	species = "worldpeas"
	plantname = "和平豌豆"
	product = /obj/item/food/grown/peace
	maturation = 20
	potency = 75
	yield = 1
	production = 10
	instability = 45 //The world is a very unstable place. Constantly changing.
	growthstages = 3
	icon_grow = "worldpeas-grow"
	icon_dead = "worldpeas-dead"
	genes = list (/datum/plant_gene/trait/glow/blue)
	reagents_add = list (/datum/reagent/pax = 0.1, /datum/reagent/drug/happiness = 0.1, /datum/reagent/consumable/nutriment = 0.15)
	rarity = 50 // This absolutely will make even the most hardened Syndicate Operators relax.
	graft_gene = /datum/plant_gene/trait/glow/blue
	mutatelist = null

/obj/item/food/grown/peace
	seed = /obj/item/seeds/peas/laugh/peace
	name = "一簇和平豌豆"
	desc = "通过大量基因工程实验和反复嫁接培育出的植物。据说食用它的人都能获得平静。农业科学界给它起了个绰号：‘天下太平’。" //at last... world peas. I'm not sorry.
	icon_state = "worldpeas"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	tastes = list ("numbing tranquility" = 2, "warmth" = 1)
	wine_power = 100
	wine_flavor = "mind-numbing peace and warmth"
