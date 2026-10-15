//*******************Contains everything related to the flora on lavaland.*******************************
//This includes: The structures, their produce, their seeds and the crafting recipe for the mushroom bowl

/obj/structure/flora/ash
	name = "大型蘑菇"
	desc = "一群大型蘑菇，表面覆着薄薄一层灰烬，还有一些想必是孢子的东西。"
	icon = 'icons/obj/mining_zones/ash_flora.dmi'
	icon_state = "l_mushroom1"
	base_icon_state = "l_mushroom"
	resistance_flags = LAVA_PROOF
	gender = PLURAL
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER //sporangiums up don't shoot
	harvest_with_hands = TRUE
	harvested_name = "变矮的蘑菇"
	harvested_desc = "一些正在迅速再生的蘑菇，它们原本长得相当大。"
	harvest_message_low = "你摘下一朵蘑菇，但没能从菌盖上收集到多少削片。"
	harvest_message_med = "你摘下一朵蘑菇，小心地收集菌盖上的削片。"
	harvest_message_high = "你采下几朵蘑菇，从它们的菌盖上收集了削片。"
	harvest_message_true_thresholds = TRUE
	harvest_verb = "采摘"
	flora_flags = FLORA_HERBAL //not really accurate but what sound do hit mushrooms make anyway
	var/number_of_variants = 4

/obj/structure/flora/ash/Initialize(mapload)
	. = ..()
	base_icon_state = "[base_icon_state][rand(1, number_of_variants)]"
	icon_state = base_icon_state

/obj/structure/flora/ash/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/shavings = 1)

/obj/structure/flora/ash/harvest(user, product_amount_multiplier)
	if(!..())
		return FALSE
	icon_state = "[base_icon_state]p"
	return TRUE

/obj/structure/flora/ash/regrow()
	..()
	icon_state = base_icon_state

/obj/structure/flora/ash/tall_shroom //exists only so that the spawning check doesn't allow these spawning near other things
	regrowth_time_low = 7 MINUTES

/obj/structure/flora/ash/leaf_shroom
	name = "叶状蘑菇"
	desc = "一群蘑菇，每朵都有若干叶片状结构围着淡绿色的孢子囊。"
	icon_state = "s_mushroom1"
	base_icon_state = "s_mushroom"
	harvested_name = "无叶蘑菇"
	harvested_desc = "一群曾长着叶片的蘑菇，如今孢子囊暴露在外。是不是有伤风化？"
	harvest_amount_high = 4
	harvest_message_low = "你摘下了一片合适的叶子。"
	harvest_message_med = "你摘下了一些叶子，留下了几片不合适的。"
	harvest_message_high = "你摘下了很多合适的叶子。"
	harvest_time = 20
	regrowth_time_low = 4 MINUTES
	regrowth_time_high = 10 MINUTES

/obj/structure/flora/ash/leaf_shroom/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/mushroom_leaf = 1)

/obj/structure/flora/ash/cap_shroom
	name = "高大蘑菇"
	desc = "几朵蘑菇，其中较大的菌柄中部生着一圈架状菌体。"
	icon_state = "r_mushroom1"
	base_icon_state = "r_mushroom"
	harvested_name = "小蘑菇"
	harvested_desc = "几朵小蘑菇，旁边的残柄看起来曾属于更大的蘑菇。"
	harvest_amount_high = 4
	harvest_message_low = "你切下了一朵蘑菇的菌盖。"
	harvest_message_med = "你从较大的蘑菇上切下了几块架状菌体。"
	harvest_message_high = "你从这些蘑菇上切下了许多菌盖和架状菌体。"
	harvest_time = 50
	regrowth_time_low = 5 MINUTES
	regrowth_time_high = 9 MINUTES

/obj/structure/flora/ash/cap_shroom/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/mushroom_cap = 1)

/obj/structure/flora/ash/stem_shroom
	name = "密集蘑菇群"
	desc = "一大群蘑菇，其中一些有着长长的肉质菌柄。它们正在发光！"
	icon_state = "t_mushroom1"
	base_icon_state = "t_mushroom"
	light_range = 1.5
	light_power = 2.1
	harvested_name = "微小蘑菇"
	harvested_desc = "几朵微小的蘑菇围在粗大的残柄周围。你已经能看到它们在重新生长。"
	harvest_amount_high = 4
	harvest_message_low = "你摘下一朵蘑菇，切去菌盖，留下菌柄。"
	harvest_message_med = "你摘下几朵蘑菇，切去菌盖以获取菌柄。"
	harvest_message_high = "你从这些蘑菇上取得了许多菌柄。"
	harvest_time = 40
	regrowth_time_low = 5 MINUTES
	regrowth_time_high = 10 MINUTES

/obj/structure/flora/ash/stem_shroom/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/mushroom_stem = 1)

/obj/structure/flora/ash/cacti
	name = "结果仙人掌"
	desc = "几株多刺的仙人掌，挂满成熟的果实，表面覆着薄薄一层灰烬。"
	icon_state = "cactus1"
	base_icon_state = "cactus"
	harvested_name = "仙人掌"
	harvested_desc = "一丛多刺的仙人掌。你能看到果实在灰烬的覆盖下缓缓生长。"
	harvest_amount_high = 2
	harvest_message_low = "你摘下了一个仙人掌果。"
	harvest_message_med = "你摘下了几个仙人掌果。" //shouldn't show up, because you can't get more than two
	harvest_message_high = "你摘下了两个仙人掌果。"
	harvest_time = 10
	regrowth_time_low = 8 MINUTES
	regrowth_time_high = 12 MINUTES
	can_uproot = FALSE //Don't want 50 in one tile to decimate whoever dare step on the mass of cacti

/obj/structure/flora/ash/cacti/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = 3, max_damage = 6, probability = 70)

/obj/structure/flora/ash/cacti/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/cactus_fruit = 20, /obj/item/seeds/lavaland/cactus = 1)

/obj/structure/flora/ash/seraka
	name = "塞拉卡菇"
	desc = "一小簇塞拉卡菇。它们一定是随灰烬蜥蜴人一同来到这里的。"
	icon_state = "seraka_mushroom1"
	base_icon_state = "seraka_mushroom"
	harvested_name = "采摘过的塞拉卡菇"
	harvested_desc = "几朵小塞拉卡菇，较大的显然刚被摘走。它们会重新长出来的……迟早会。"
	harvest_amount_high = 6
	harvest_message_low = "你精选了几朵美味的蘑菇摘下。"
	harvest_message_med = "你采到了一批不错的蘑菇。"
	harvest_message_high = "你找到了蘑菇宝藏，满载美味的蘑菇而归。"
	harvest_time = 25
	regrowth_time_low = 5 MINUTES
	regrowth_time_high = 9 MINUTES
	number_of_variants = 2
	harvest_message_true_thresholds = FALSE

/obj/structure/flora/ash/seraka/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/seraka = 1)

/obj/structure/flora/ash/fireblossom
	name = "火焰花"
	desc = "一种常见于熔岩附近的奇异花朵。"
	icon_state = "fireblossom1"
	base_icon_state = "fireblossom"
	light_range = LIGHT_FIRE_BLOSSOM
	light_power = LIGHT_FIRE_BLOSSOM
	light_color = COLOR_BIOLUMINESCENCE_YELLOW
	harvested_name = "火焰花茎"
	harvested_desc = "几根失去了花朵的火焰花茎。"
	harvest_amount_high = 3
	harvest_message_low = "你摘下了一朵合适的花。"
	harvest_message_med = "你摘下了一些花，留下了几朵不合适的。"
	harvest_message_high = "你摘下了很多合适的花。"
	regrowth_time_low = 4 MINUTES
	regrowth_time_high = 7 MINUTES
	number_of_variants = 2

/obj/structure/flora/ash/fireblossom/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/fireblossom = 1)

/obj/structure/flora/ash/fireblossom/after_harvest()
	set_light_power(LIGHT_RANGE_FIRE_BLOSSOM_HARVESTED)
	set_light_range(LIGHT_POWER_FIRE_BLOSSOM_HARVESTED)
	update_light()
	return ..()

/obj/structure/flora/ash/fireblossom/regrow()
	set_light_power(initial(light_power))
	set_light_range(initial(light_range))
	update_light()
	return ..()

/obj/structure/flora/ash/glowgrowth
	name = "荧光菌群"
	desc = "一群生长在热气喷口上的发光真菌，以喷出的矿物微粒为食。"
	icon_state = "glowgrowth1"
	base_icon_state = "glowgrowth"
	density = TRUE // Large rock formations with plants ontop
	light_range = 1.7
	light_power = 1.2
	light_color = "#67b6a5"
	harvested_name = "热气喷口"
	harvested_desc = "一个带有棱脊的多孔岩体，正从星球深处喷出热气。"
	harvest_amount_high = 4
	harvest_verb = "刮取"
	harvest_message_low = "你刮下了薄薄一层发光真菌。"
	harvest_message_med = "你采下了相当大的一片发光真菌。"
	harvest_message_high = "你抓起了一大把发光真菌。"
	regrowth_time_low = 8 MINUTES
	regrowth_time_high = 16 MINUTES
	number_of_variants = 3

/obj/structure/flora/ash/glowgrowth/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/structure/flora/ash/glowgrowth/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/glowgrowth = 1)

/obj/structure/flora/ash/glowgrowth/after_harvest()
	set_light_on(FALSE)
	update_light()
	update_appearance()
	return ..()

/obj/structure/flora/ash/glowgrowth/regrow()
	set_light_on(TRUE)
	update_light()
	update_appearance()
	return ..()

/obj/structure/flora/ash/glowgrowth/update_overlays()
	. = ..()
	if (!harvested)
		. += emissive_appearance(icon, "[icon_state]e", src, alpha = 120)

///Snow flora to exist on icebox.
/obj/structure/flora/ash/chilly
	name = "弹韧结果草"
	desc = "一群鲜艳而富有弹性的蓝色结果植物。它们似乎完全不在乎恶劣寒冷的环境。"
	icon_state = "chilly_pepper1"
	base_icon_state = "chilly_pepper"
	harvested_name = "弹韧草"
	harvested_desc = "一丛富有弹性、摇晃回弹的结果草，果实已被摘光。也许它们根本就没结过果？"
	harvest_amount_high = 3
	harvest_message_low = "你摘下了一个弯曲的果实。"
	harvest_message_med = "你摘下了一些弯曲的果实。"
	harvest_message_high = "你摘下了很多弯曲的果实。"
	harvest_time = 15
	regrowth_time_low = 2400
	regrowth_time_high = 5500
	number_of_variants = 2

/obj/structure/flora/ash/chilly/get_potential_products()
	return list(/obj/item/food/grown/icepepper = 1)

/obj/structure/flora/ash/fonarstolbe
	name = "灯柱果"
	desc = "一种具有微弱生物荧光的化能营养植物，被旋臂星区的科学家称为灯柱果。只要扎根稳固，它们就能在足以杀死大多数植物的环境和压力下存活数周。"
	icon_state = "lamppostfruit1"
	base_icon_state = "lamppostfruit"
	light_range = 1.5
	light_power = 2.1
	harvested_name = "灯柱果植株"
	harvested_desc = "灯柱果的茎。它迟早会重新长好，到时候你就能摘下酸甜的果实。"
	harvest_amount_high = 3
	harvest_message_low = "你摘下了一个灯柱果。"
	harvest_message_med = "你摘下了一些灯柱果。"
	harvest_message_high = "你摘下了很多灯柱果。"
	harvest_time = 40
	number_of_variants = 4

/obj/structure/flora/ash/fonarstolbe/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/fonarstolbe = 1)

/obj/structure/flora/ash/vahrezjia
	name = "狂性荚花"
	desc = "鲜蓝色花茎从紫色花荚中伸出。据说它们能让动物变得好斗。旋臂殖民者带来的哈士奇和熊确实因它们而加快了野化，不过它们大概不是直接原因。"
	icon_state = "flowerpod1"
	base_icon_state = "flowerpod"
	harvested_name = "狂性荚花荚"
	harvested_desc = "一丛狂性荚花荚。尽管人们多次尝试焚烧或连根拔除，它们仍不知为何顽强地四处蔓延。"
	harvest_amount_high = 3
	harvest_message_low = "你摘下了一根狂性荚花茎。"
	harvest_message_med = "你摘下了一些狂性荚花茎。"
	harvest_message_high = "你摘下了很多狂性荚花茎。"
	harvest_time = 25
	number_of_variants = 4

/obj/structure/flora/ash/vahrezjia/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/vahrezjia = 1)

/obj/structure/flora/ash/podsneyzka
	name = "腐肉花"
	desc = "一丛盛开的腐肉花。它们吃起来很像肉，化学成分也与肉十分相似。也许还是别细想为好。"
	icon_state = "flower1"
	base_icon_state = "flower"
	harvested_name = "腐肉花茎"
	harvested_desc = "一丛腐肉花茎。植株的大部分其实藏在地下，极长的根系不断寻找腐烂尸体，从中吸取养分。"
	harvest_amount_high = 5
	harvest_message_low = "你成功摘下了一小束腐肉花。"
	harvest_message_med = "你小心地摘下了一整束腐肉花。"
	harvest_message_high = "你十分小心地摘下了很多腐肉花。"
	harvest_time = 30
	number_of_variants = 4

/obj/structure/flora/ash/podsneyzka/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/podsneyzka = 1)

/obj/structure/flora/ash/inozhakust
	name = "油蔓灌木"
	desc = "一种看起来像是树根朝天生长的植物，覆满湿软油腻的藤蔓。藤蔓一碰就会噗叽一声碎开，只能收集成糊状。"
	icon_state = "shrub1"
	base_icon_state = "shrub"
	harvested_name = "油蔓灌木"
	harvested_desc = "油蔓灌木，一种看起来像是树根朝天生长的植物。它过滤土壤中的化合物，吐出恶心的藤蔓，应该很快就能采集了。"
	harvest_amount_high = 5
	harvest_message_low = "你成功舀下了一点油蔓灌木的藤蔓糊。"
	harvest_message_med = "你成功舀下了一些油蔓灌木的藤蔓糊。"
	harvest_message_high = "你成功舀下了很多油蔓灌木的藤蔓糊。"
	harvest_time = 30
	number_of_variants = 4

/obj/structure/flora/ash/inozhakust/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/inozhakust = 1)

/obj/structure/flora/ash/plasma_flower
	name = "等离子花"
	desc = "一丛藤蔓围绕着簇生的等离子花。研究人员还在绞尽脑汁理解它们。"
	icon_state = "plasma_flower1"
	base_icon_state = "plasma_flower"
	light_range = LIGHT_FIRE_BLOSSOM
	light_power = LIGHT_FIRE_BLOSSOM
	light_color = COLOR_BIOLUMINESCENCE_PURPLE
	harvested_name = "火焰花藤"
	harvested_desc = "几根失去了花朵的等离子花藤。"
	harvest_amount_high = 3
	harvest_message_low = "你摘下了一朵合适的花。"
	harvest_message_med = "你摘下了一些花，留下了几朵不合适的。"
	harvest_message_high = "你摘下了很多合适的花。"
	regrowth_time_low = 4 MINUTES
	regrowth_time_high = 7 MINUTES
	number_of_variants = 2

/obj/structure/flora/ash/plasma_flower/get_potential_products()
	return list(/obj/item/food/grown/ash_flora/plasma_flower = 1)

/obj/structure/flora/ash/plasma_flower/after_harvest()
	set_light_power(LIGHT_RANGE_FIRE_BLOSSOM_HARVESTED)
	set_light_range(LIGHT_POWER_FIRE_BLOSSOM_HARVESTED)
	update_light()
	return ..()

/obj/structure/flora/ash/plasma_flower/regrow()
	set_light_power(initial(light_power))
	set_light_range(initial(light_range))
	update_light()
	return ..()

/obj/structure/flora/ash/drake_beet
	name = "飞龙甜菜"
	desc = "一种变异甜菜。它似乎通过粗略模仿飞龙外形来适应当地生态。不知道这有什么用，不过它应该还是很好吃。"
	icon_state = "drakebeet1"
	base_icon_state = "drakebeet"
	harvested_name = "飞龙甜菜幼苗"
	harvested_desc = "一种变异甜菜，这些还没长大。旋臂居民原本把它带来做罗宋汤，后来它和这里的其他生物一样野化并发生了变异。"
	harvest_amount_high = 4
	harvest_message_low = "你从地里拔出了一颗合适的甜菜。"
	harvest_message_med = "你从地里拔出了一些合适的甜菜。"
	harvest_message_high = "你从地里拔出了很多合适的甜菜。"
	regrowth_time_low = 3 MINUTES
	regrowth_time_high = 6 MINUTES
	harvest_time = 25
	number_of_variants = 2

/obj/structure/flora/ash/drake_beet/get_potential_products()
	return list(/obj/item/food/grown/drake_beet = 1)

//SNACKS

/obj/item/food/grown/ash_flora
	name = "不明怪异植物碎片"
	desc = "这是什么？这是个不该出现的东西。把这事告诉别人吧。"
	icon = 'icons/obj/mining_zones/ash_flora.dmi'
	icon_state = "mushroom_shavings"
	abstract_type = /obj/item/food/grown/ash_flora
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	max_integrity = 100
	foodtypes = VEGETABLES

/obj/item/food/grown/ash_flora/Initialize(mapload)
	. = ..()
	pixel_x = base_pixel_x + rand(-4, 4)
	pixel_y = base_pixel_y + rand(-4, 4)

/obj/item/food/grown/ash_flora/shavings
	name = "蘑菇削片"
	desc = "从高大蘑菇上削下的薄片。数量足够的话，也许能做成一个碗。"
	seed = /obj/item/seeds/lavaland/polypore
	wine_power = 20

/obj/item/food/grown/ash_flora/shavings/grind_results()
	return list(/datum/reagent/toxin/mushroom_powder = 5)

/obj/item/food/grown/ash_flora/mushroom_leaf
	name = "蘑菇叶"
	desc = "一片长在蘑菇上的叶子。"
	icon_state = "mushroom_leaf"
	seed = /obj/item/seeds/lavaland/porcini
	wine_power = 40

/obj/item/food/grown/ash_flora/mushroom_cap
	name = "蘑菇菌盖"
	desc = "一朵大型蘑菇的菌盖。"
	icon_state = "mushroom_cap"
	seed = /obj/item/seeds/lavaland/inocybe
	wine_power = 70

/obj/item/food/grown/ash_flora/mushroom_stem
	name = "蘑菇菌柄"
	desc = "一根长长的蘑菇菌柄，微微发着光。"
	icon_state = "mushroom_stem"
	seed = /obj/item/seeds/lavaland/ember
	wine_power = 60

/obj/item/food/grown/ash_flora/cactus_fruit
	name = "仙人掌果"
	desc = "一个包着厚实红皮的仙人掌果。上面还沾着些灰烬。"
	icon_state = "cactus_fruit"
	seed = /obj/item/seeds/lavaland/cactus
	wine_power = 50
	foodtypes = FRUIT

/obj/item/food/grown/ash_flora/cactus_fruit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/raptor_food, growth_modifier = 0.1, ability_modifier = -0.05)

/obj/item/food/grown/ash_flora/seraka
	name = "塞拉卡菌盖"
	desc = "原产于提兹拉的小蘑菇，滋味浓郁。"
	icon_state = "seraka_cap"
	seed = /obj/item/seeds/lavaland/seraka
	wine_power = 40

/obj/item/food/grown/ash_flora/seraka/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/raptor_food, ability_modifier = 0.1)

/obj/item/food/grown/ash_flora/fireblossom
	name = "火焰花"
	desc = "一朵从火焰花植株上摘下的花。"
	icon_state = "fireblossom"
	slot_flags = ITEM_SLOT_HEAD
	seed = /obj/item/seeds/lavaland/fireblossom
	wine_power = 40

/obj/item/food/grown/ash_flora/fireblossom/Initialize(mapload)
	. = ..()
	// Fire flowers make fireproof raptors
	AddElement(/datum/element/raptor_food, color_chances = string_list(list(/datum/raptor_color/blue = 5)))

/obj/item/food/grown/ash_flora/glowgrowth
	name = "荧光菌片"
	desc = "一片厚厚的发光真菌。"
	icon_state = "glowgrowth"
	seed = /obj/item/seeds/lavaland/glowgrowth // Cannot be grown in hydroponics as it feeds off mineral air
	wine_power = 50

//SNACKS - icebox

/obj/item/food/grown/ash_flora/fonarstolbe
	name = "灯柱果"
	desc = "一个灯柱果，散发着微弱的蓝光。"
	icon_state = "fonarstolbe"
	seed = /obj/item/seeds/lavaland/fonarstolbe
	wine_power = 50
	foodtypes = FRUIT

/obj/item/food/grown/ash_flora/vahrezjia
	name = "狂性荚花茎"
	desc = "一束狂性荚花茎，质地粗糙得出乎意料。"
	icon_state = "vahrezjia"
	seed = /obj/item/seeds/lavaland/vahrezjia
	wine_power = 50
	foodtypes = FRUIT

/obj/item/food/grown/ash_flora/podsneyzka
	name = "腐肉花束"
	desc = "一束带斑点、向内折叠的腐肉花，闻起来有点像腐烂的肉。"
	icon_state = "podsneyzka"
	seed = /obj/item/seeds/lavaland/podsneyzka
	wine_power = 50
	foodtypes = MEAT|VEGETABLES

/obj/item/food/grown/ash_flora/inozhakust
	name = "油蔓糊"
	desc = "捣碎的油蔓灌木藤蔓，被舀进了你随手找到的容器里。"
	icon_state = "inozhakust"
	seed = /obj/item/seeds/lavaland/inozhakust
	distill_reagent = /datum/reagent/consumable/ethanol/mouthwash
	foodtypes = VEGETABLES|GROSS

/obj/item/food/grown/ash_flora/plasma_flower
	name = "等离子花"
	desc = "一小段连着等离子结晶花朵的藤蔓。"
	icon_state = "plasmaflower"
	slot_flags = ITEM_SLOT_HEAD
	seed = /obj/item/seeds/lavaland/plasma_flower
	foodtypes = TOXIC
	wine_power = 40

/obj/item/food/grown/ash_flora/plasma_flower/Initialize(mapload)
	. = ..()
	// Fire flowers make fireproof raptors
	AddElement(/datum/element/raptor_food, color_chances = string_list(list(/datum/raptor_color/blue = 5)))

// SEEDS

/obj/item/seeds/lavaland
	name = "熔岩星球种子"
	desc = "你不应该看到这个。"
	lifespan = 50
	endurance = 25
	maturation = 7
	production = 4
	yield = 4
	potency = 15
	growthstages = 3
	rarity = PLANT_MODERATELY_RARE
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	species = "polypore" // silence unit test
	genes = list(/datum/plant_gene/trait/fire_resistance)
	graft_gene = /datum/plant_gene/trait/fire_resistance

/obj/item/seeds/lavaland/cactus
	name = "结果仙人掌种子包"
	desc = "这些种子能长成结果仙人掌。"
	icon_state = "seed-cactus"
	species = "cactus"
	plantname = "结果仙人掌"
	product = /obj/item/food/grown/ash_flora/cactus_fruit
	mutatelist = list(/obj/item/seeds/star_cactus)
	genes = list(/datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	growthstages = 2
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04, /datum/reagent/consumable/vitfro = 0.08)

///Star Cactus seeds, mutation of lavaland cactus.
/obj/item/seeds/star_cactus
	name = "星形仙人掌种子包"
	desc = "这些种子能长成星形仙人掌。"
	icon_state = "seed-starcactus"
	species = "starcactus"
	plantname = "星形仙人掌丛"
	product = /obj/item/food/grown/star_cactus
	lifespan = 60
	endurance = 30
	maturation = 7
	production = 6
	yield = 3
	growthstages = 4
	genes = list(/datum/plant_gene/trait/sticky, /datum/plant_gene/trait/stinging)
	graft_gene = /datum/plant_gene/trait/sticky
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/water = 0.08, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/medicine/c2/helbital = 0.05)

///Star Cactus Plants.
/obj/item/food/grown/star_cactus
	seed = /obj/item/seeds/star_cactus
	name = "星形仙人掌"
	desc = "一簇浑身尖刺、圆滚滚的星形仙人掌。没错，它叫星形仙人掌可不是因为长在太空里。"
	icon_state = "starcactus"
	filling_color = "#1c801c"
	foodtypes = VEGETABLES
	distill_reagent = /datum/reagent/consumable/ethanol/tequila

/obj/item/seeds/lavaland/polypore
	name = "多孔菌菌丝包"
	desc = "这些菌丝能长成架状蘑菇，也称多孔菌。其质地坚硬如木，矿工常用它们制作简易用品。"
	icon_state = "mycelium-polypore"
	species = "polypore"
	plantname = "多孔菌"
	product = /obj/item/food/grown/ash_flora/shavings
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.04, /datum/reagent/consumable/ethanol = 0.04, /datum/reagent/stabilizing_agent = 0.06, /datum/reagent/consumable/mintextract = 0.02)

/obj/item/seeds/lavaland/porcini
	name = "牛肝菌菌丝包"
	desc = "这些菌丝能长成美味牛肝菌，通常简称牛肝菌。原产于已不复存在的地球，后来在熔岩星球上被发现。可供烹饪、药用，也有放松作用。"
	icon_state = "mycelium-porcini"
	species = "porcini"
	plantname = "牛肝菌"
	product = /obj/item/food/grown/ash_flora/mushroom_leaf
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.06,  /datum/reagent/consumable/sugar = 0.06, /datum/reagent/consumable/vitfro = 0.04, /datum/reagent/drug/nicotine = 0.04)

/obj/item/seeds/lavaland/inocybe
	name = "丝盖菇菌丝包"
	desc = "这些菌丝能长成丝盖菇，一种原产于熔岩星球、具有致幻性和毒性的蘑菇。"
	icon_state = "mycelium-inocybe"
	species = "inocybe"
	plantname = "丝盖菇"
	product = /obj/item/food/grown/ash_flora/mushroom_cap
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/toxin/mindbreaker = 0.04, /datum/reagent/consumable/entpoly = 0.08, /datum/reagent/drug/mushroomhallucinogen = 0.04)

/obj/item/seeds/lavaland/ember
	name = "余烬菇菌丝包"
	desc = "这些菌丝能长成余烬菇，一种原产于熔岩星球的发光蘑菇。"
	icon_state = "mycelium-ember"
	species = "ember"
	plantname = "余烬菇"
	product = /obj/item/food/grown/ash_flora/mushroom_stem
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/glow, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/tinlux = 0.04, /datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/drug/space_drugs = 0.02)

/obj/item/seeds/lavaland/seraka
	name = "塞拉卡菇菌丝包"
	desc = "这些菌丝能长成塞拉卡菇，一种原产于提兹拉的鲜美蘑菇，可用于烹饪和传统医药。"
	icon_state = "mycelium-seraka"
	species = "seraka"
	plantname = "塞拉卡菇"
	product = /obj/item/food/grown/ash_flora/seraka
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/toxin/mushroom_powder = 0.1, /datum/reagent/medicine/coagulant/seraka_extract = 0.02)

/obj/item/seeds/lavaland/fireblossom
	name = "火焰花种子包"
	desc = "这些种子能长成火焰花。"
	plantname = "火焰花"
	icon_state = "seed-fireblossom"
	species = "fireblossom"
	growthstages = 3
	product = /obj/item/food/grown/ash_flora/fireblossom
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/glow/yellow)
	growing_icon = 'icons/obj/service/hydroponics/growing_flowers.dmi'
	reagents_add = list(/datum/reagent/consumable/tinlux = 0.04, /datum/reagent/consumable/nutriment = 0.03, /datum/reagent/carbon = 0.05)

/obj/item/seeds/lavaland/glowgrowth
	name = "荧光菌菌丝包"
	desc = "这些菌丝能长成荧光菌。"
	plantname = "荧光菌"
	icon_state = "mycelium-glowgrowth"
	species = "glowgrowth"
	product = /obj/item/food/grown/ash_flora/glowgrowth
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/glow/blue) // Fungal metab doesn't do anything (cause it can't be planted) but it shows up in analyzers
	reagents_add = list(/datum/reagent/luminescent_fluid/cyan = 0.06, /datum/reagent/consumable/nutriment = 0.01, /datum/reagent/silicon = 0.03)
	seed_flags = parent_type::seed_flags | NO_PLANTING

/// SEEDS - icebox

/obj/item/seeds/lavaland/fonarstolbe
	name = "灯柱果种子包"
	desc = "这些种子能长成灯柱果。"
	icon_state = "seed-fonarstolbe"
	species = "fonarstolbe"
	plantname = "灯柱果"
	lifespan = 40
	production = 5
	yield = 3
	growthstages = 4
	product = /obj/item/food/grown/ash_flora/fonarstolbe
	genes = list(/datum/plant_gene/trait/tox_resistance, /datum/plant_gene/trait/glow/blue)
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04, /datum/reagent/luminescent_fluid/cyan = 0.03, /datum/reagent/iron = 0.02, /datum/reagent/consumable/guidoferrun = 0.2)
	graft_gene = /datum/plant_gene/trait/glow/blue

/obj/item/seeds/lavaland/vahrezjia
	name = "狂性荚花种子包"
	desc = "这些种子能长成狂性荚花。"
	icon_state = "seed-vahrezjia"
	species = "vahrezjia"
	plantname = "狂性荚花"
	growthstages = 3
	product = /obj/item/food/grown/ash_flora/vahrezjia
	genes = list(/datum/plant_gene/trait/tox_resistance, /datum/plant_gene/trait/repeated_harvest)
	growing_icon = 'icons/obj/service/hydroponics/growing_fruits.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/consumable/nutriment = 0.02, /datum/reagent/toxin/berserker = 0.06, /datum/reagent/consumable/nutriment/fat/oil = 0.03)

/obj/item/seeds/lavaland/podsneyzka
	name = "腐肉花种子包"
	desc = "这些种子能长成腐肉花。"
	icon_state = "seed-podsneyzka"
	species = "podsneyzka"
	plantname = "腐肉花"
	lifespan = 30
	endurance = 15
	production = 4
	yield = 5
	growthstages = 3
	product = /obj/item/food/grown/ash_flora/podsneyzka
	genes = list(/datum/plant_gene/trait/tox_resistance, /datum/plant_gene/trait/chem_cooling)
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.03, /datum/reagent/consumable/nutriment = 0.03, /datum/reagent/cryostylane = 0.02, /datum/reagent/consumable/liquidgibs = 0.02)
	graft_gene = /datum/plant_gene/trait/chem_cooling

/obj/item/seeds/lavaland/inozhakust
	name = "油蔓灌木种子包"
	desc = "这些种子能长成油蔓灌木。"
	icon_state = "seed-inozhakust"
	species = "inozhakust"
	plantname = "油蔓灌木"
	lifespan = 40
	endurance = 30
	yield = 3
	growthstages = 5
	product = /obj/item/food/grown/ash_flora/inozhakust
	genes = list(/datum/plant_gene/trait/plant_type/toxin_adaptation, /datum/plant_gene/trait/repeated_harvest)
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.01, /datum/reagent/consumable/nutriment = 0.09,  /datum/reagent/consumable/mintextract = 0.03, /datum/reagent/impurity = 0.02)
	graft_gene = /datum/plant_gene/trait/plant_type/toxin_adaptation

/obj/item/seeds/lavaland/plasma_flower
	name = "等离子花种子包"
	desc = "这些种子能长成等离子花。"
	icon_state = "seed-plasmaflower"
	species = "plasmaflower"
	plantname = "等离子花"
	lifespan = 40
	endurance = 15
	production = 5
	yield = 3
	potency = 20
	growthstages = 3
	product = /obj/item/food/grown/ash_flora/plasma_flower
	genes = list(/datum/plant_gene/trait/plant_type/toxin_adaptation, /datum/plant_gene/trait/glow/purple)
	growing_icon = 'icons/obj/service/hydroponics/growing_flowers.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.02, /datum/reagent/plasma_oxide = 0.01, /datum/reagent/stable_plasma = 0.02)

//CRAFTING

/datum/crafting_recipe/mushroom_bowl
	name = "蘑菇碗"
	result = /obj/item/reagent_containers/cup/bowl/mushroom_bowl
	reqs = list(/obj/item/food/grown/ash_flora/shavings = 5)
	time = 3 SECONDS
	category = CAT_CONTAINERS

/obj/item/reagent_containers/cup/bowl/mushroom_bowl
	name = "蘑菇碗"
	desc = "用蘑菇做成的碗。它不是食物，不过以前也许盛过食物。"
	icon = 'icons/obj/mining_zones/ash_flora.dmi'
	base_icon_state = "mushroom_bowl"
	icon_state = "mushroom_bowl"
	fill_icon_state = "fullbowl"
	fill_icon = 'icons/obj/mining_zones/ash_flora.dmi'
	custom_materials = null

