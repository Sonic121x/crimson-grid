//Lizard Foods, for lizards (and weird humans!)

//Meat Dishes

/obj/item/food/raw_tiziran_sausage
	name = "生提兹拉血肠"
	desc = "一根生提兹拉血肠，可以放上晾干架风干。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "raw_lizard_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/blood = 3,
	)
	tastes = list("meat" = 1, "black pudding" = 1)
	foodtypes = MEAT|RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/raw_tiziran_sausage/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/tiziran_sausage)

/obj/item/food/tiziran_sausage
	name = "\improper 提兹拉血肠"
	desc = "质地粗实的风干血肠，由扎戈斯凯尔德周边农民依传统工艺制作。口感类似古老地球上的西班牙辣肠。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("meat" = 1, "black pudding" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_price = PAYCHECK_CREW
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/raw_headcheese
	name = "生头肉酪块"
	desc = "头肉酪是提兹拉的常见食品。传统做法是取动物头部，去除器官后煮至软烂，捞出沥干，拌入大量盐并压成块，再风干熟成数月。成品坚硬，味道类似奶酪。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "raw_lizard_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/salt = 5,
	)
	tastes = list("meat" = 1, "salt" = 1)
	foodtypes = MEAT|RAW|GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/raw_headcheese/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/headcheese)

/obj/item/food/headcheese
	name = "头肉酪块"
	desc = "一块熟成的头肉酪。如果你是蜥蜴人，应该会觉得美味。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/salt = 5,
	)
	tastes = list("cheese" = 1, "salt" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/headcheese/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/headcheese_slice, 5, 3 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/headcheese_slice
	name = "头肉酪片"
	desc = "一片头肉酪，适合做三明治和小吃，也能帮你熬过提兹拉寒冷的冬天。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_cheese_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("cheese" = 1, "salt" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 5)

/obj/item/food/shredded_lungs
	name = "香脆炒肺丝"
	desc = "香脆的肺丝配上蔬菜和辣酱。如果你喜欢吃肺，那一定很美味。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lung_stirfry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("meat" = 1, "heat" = 1, "veggies" = 1)
	foodtypes = MEAT | VEGETABLES | GORE
	trash_type = /obj/item/reagent_containers/cup/bowl
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/tsatsikh
	name = "香料杂碎肚"
	desc = "一道提兹拉菜，将调好香料的内脏碎灌进胃袋后煮熟。不习惯这味道的人会觉得很难下咽。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "tsatsikh"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 10)
	tastes = list("assorted minced organs" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/liver_pate
	name = "肝酱"
	desc = "用肝脏、肉和少许提味配料制成的浓郁肉酱。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "pate"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 5)
	tastes = list("liver" = 1)
	foodtypes = MEAT|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/moonfish_eggs
	name = "月鱼卵"
	gender = PLURAL
	desc = "月鱼产下硕大、半透明的蓝色鱼卵，是蜥蜴人料理中的珍贵食材。味道类似鱼子酱，却通常被认为更浓郁、更有层次。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_eggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("caviar" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/moonfish_eggs/Initialize(mapload)
	. = ..()
	//Moonfish can lay eggs inside aquariums (unaffected by breeding, so think of them as unfertilizard)
	RegisterSignal(src, COMSIG_AQUARIUM_CONTENT_GENERATE_APPEARANCE, PROC_REF(generate_aquarium_appearance))
	RegisterSignal(src, COMSIG_AQUARIUM_CONTENT_RANDOMIZE_POSITION, PROC_REF(randomize_aquarium_position))
	AddComponent(/datum/component/aquarium_content)
	RegisterSignal(src, COMSIG_MOVABLE_GET_AQUARIUM_BEAUTY, PROC_REF(get_aquarium_beauty))

/obj/item/food/moonfish_eggs/proc/generate_aquarium_appearance(datum/source, obj/effect/aquarium/visual)
	SIGNAL_HANDLER
	visual.icon = icon
	visual.icon_state = "moonfish_eggs_aquarium"
	visual.layer_mode = AQUARIUM_LAYER_MODE_BOTTOM

/obj/item/food/moonfish_eggs/proc/randomize_aquarium_position(datum/source, obj/structure/aquarium/current_aquarium, obj/effect/aquarium/visual)
	SIGNAL_HANDLER
	var/sprite_width = 5
	var/sprite_height = 4
	var/pw_min = visual.aquarium_zone_min_pw
	var/pw_max = visual.aquarium_zone_max_pw - sprite_width
	var/pz_min = visual.aquarium_zone_min_pz - sprite_height

	visual.pixel_w = rand(pw_min, pw_max)
	visual.pixel_z = pz_min + rand(-1, 1)

/obj/item/food/moonfish_eggs/proc/get_aquarium_beauty(datum/source, list/beauty_holder)
	SIGNAL_HANDLER
	beauty_holder += 100 //moonfish eggs are kinda eye candy

/obj/item/food/moonfish_caviar
	name = "月鱼子酱"
	desc = "用月鱼卵制成的浓郁酱料。多数蜥蜴人只能以这种形式吃到月鱼卵，沿海料理尤其常用。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_caviar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("caviar" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/lizard_escargot
	name = "罗马式沙漠蜗牛"
	desc = "又一道蜥蜴人与人类文化交融的菜肴。这种沙漠蜗牛料理更接近古罗马的做法，而非现代法式蜗牛，是沙漠城市常见的街头小吃。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_escargot"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("snails" = 1, "garlic" = 1, "oil" = 1)
	foodtypes = MEAT|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/fried_blood_sausage
	name = "炸血肠"
	desc = "裹糊油炸的血肠。在扎戈斯凯尔德街头，常配薯条作为方便快捷的小吃。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "fried_blood_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 1,
	)
	tastes = list("black pudding" = 1, "batter" = 1, "oil" = 1)
	foodtypes = MEAT|NUTS|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

//Why does like, every language on the planet besides English call them pommes? Who knows, who cares- the lizards call them it too, because funny.
/obj/item/food/lizard_fries
	name = "豪华龙语薯条"
	desc = "薯条是传入蜥蜴人社会的众多人类食品之一，并有了龙语叫法。浇上烤肉和酱汁，就成了一顿丰盛的饭。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/bbqsauce = 2,
	)
	tastes = list("fries" = 2, "bbq sauce" = 1, "barbecued meat" = 1)
	foodtypes = MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/brain_pate
	name = "眼球脑髓酱"
	desc = "将水煮眼球和脑髓切碎，与炒洋葱、油脂一起制成浓稠的粉色泥酱。蜥蜴人发誓这很好吃！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "brain_pate"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/liquidgibs = 2,
	)
	tastes = list("brains" = 2)
	foodtypes = MEAT | VEGETABLES | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/crispy_headcheese
	name = "酥炸头肉酪"
	desc = "扎戈斯凯尔德街头的美味小吃，将头肉酪裹上块根面包屑炸制，常配薯条食用。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "crispy_headcheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("cheese" = 1, "oil" = 1)
	foodtypes = MEAT | VEGETABLES | NUTS | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 5)

/obj/item/food/kebab/picoss_skewers
	name = "醋腌甲鱼串"
	desc = "提兹拉的人气街头小吃，把醋腌披甲鱼与洋葱、辣椒串在一起。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "picoss_skewer"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/vinegar = 1,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("fish" = 1, "acid" = 1, "onion" = 1, "heat" = 1)
	foodtypes = VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/nectar_larvae
	name = "花蜜幼虫"
	desc = "酥脆的小幼虫裹着以科塔花蜜调制的甜辣酱。虫味十足！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "nectar_larvae"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/korta_nectar = 3,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("meat" = 1, "sweet" = 1, "heat" = 1)
	foodtypes = MEAT|VEGETABLES|BUGS|GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mushroomy_stirfry
	name = "杂菇小炒"
	desc = "满满一盘杂菇，满足你怪兽般的食欲。妙不可言！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "mushroomy_stirfry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("marvelous mushrooms" = 1, "sublime shrooms" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Fish Dishes
/obj/item/food/grilled_moonfish
	name = "烤月鱼"
	desc = "一块烤月鱼。传统吃法是放在焗烤块根片上，淋上葡萄酒酱汁。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "grilled_moonfish"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("fish" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/moonfish_demiglace
	name = "浓汁月鱼"
	desc = "煎得恰到好处的月鱼垫着土豆和胡萝卜，上面淋着葡萄酒与浓缩肉汁熬成的酱。实在美妙。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_demiglace"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("fish" = 2, "potatoes" = 1, "carrots" = 1)
	foodtypes = VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/lizard_surf_n_turf
	name = "\improper 扎戈斯克海陆大拼盘"
	desc = "装满提兹拉顶级肉类和海鲜的巨型拼盘，通常供一群人在海滩分享。当然，也没人拦着你独吞……死胖子。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "surf_n_turf"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("surf" = 1, "turf" = 1)
	foodtypes = MEAT | SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_BULKY
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 3)

//Spaghetti Dishes

/obj/item/food/spaghetti/nizaya
	name = "根果面疙瘩"
	desc = "源自提兹拉沿海地区的块根与坚果面食，外观和口感都类似意式土豆团子。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("gnocchi" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/nizaya/egg
	foodtypes = parent_type::foodtypes | MEAT

/obj/item/food/spaghetti/snail_nizaya
	name = "沙漠蜗牛根果面疙瘩"
	desc = "来自提兹拉葡萄酒产区瓦林吉亚的高级面食。传统上只用最好的提兹拉葡萄酒……不过实在没有，人类的劣酒也能凑合。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "snail_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("snails" = 1, "wine" = 1, "gnocchi" = 1)
	foodtypes = VEGETABLES | MEAT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/garlic_nizaya
	name = "蒜油根果面疙瘩"
	desc = "蜥蜴人用根果面疙瘩改编的意大利蒜油意面。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "garlic_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("garlic" = 1, "oil" = 1, "gnocchi" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spaghetti/demit_nizaya
	name = "蜜乳根果面疙瘩"
	desc = "用科塔乳和花蜜调制的根果面疙瘩，香甜绵滑。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "demit_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/korta_nectar = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("peppery sweet" = 1, "veggies" = 1, "gnocchi" = 1)
	foodtypes = VEGETABLES|NUTS|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/mushroom_nizaya
	name = "蘑菇根果面疙瘩"
	desc = "加入塞拉卡菇与优质油脂的根果面疙瘩，坚果香味浓郁。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "mushroom_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("savouriness" = 1, "nuttiness" = 1, "gnocchi" = 1)
	foodtypes = VEGETABLES|NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

//Dough Dishes

/obj/item/food/rootdough
	name = "块根面团"
	desc = "以块根和坚果制成的面团，广泛用于提兹拉料理。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootdough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("potato" = 1, "earthy heat" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1
	var/bread_type = /obj/item/food/bread/root
	var/flat_type = /obj/item/food/flatrootdough

/obj/item/food/rootdough/make_bakeable()
	AddComponent(/datum/component/bakeable, bread_type, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/rootdough/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, flat_type, 1, 3 SECONDS, table_required = TRUE, screentip_verb = "擀平", sound_to_play = SFX_ROLLING_PIN_ROLLING)

/obj/item/food/rootdough/egg
	desc = "以块根、坚果和鸡蛋制成的面团，广泛用于提兹拉料理。"
	foodtypes = parent_type::foodtypes | MEAT
	bread_type = /obj/item/food/bread/root/egg
	flat_type = /obj/item/food/flatrootdough/egg

/obj/item/food/flatrootdough
	name = "块根面饼"
	desc = "擀平的块根面团，可以做成薄饼，也可以切成小份。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "flat_rootdough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("potato" = 1, "earthy heat" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1
	var/process_type = /obj/item/food/rootdoughslice
	var/grill_type = /obj/item/food/root_flatbread

/obj/item/food/flatrootdough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, process_type, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/flatrootdough/make_grillable()
	AddComponent(/datum/component/grillable, grill_type, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/flatrootdough/egg
	foodtypes = parent_type::foodtypes | MEAT
	process_type = /obj/item/food/rootdoughslice/egg
	grill_type = /obj/item/food/root_flatbread/egg

/obj/item/food/rootdoughslice
	name = "块根面团球"
	desc = "一团块根面团，非常适合做面食或面包卷。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootdough_slice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("potato" = 1, "earthy heat" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1
	var/process_type = /obj/item/food/spaghetti/nizaya
	var/bake_type = /obj/item/food/rootroll

/obj/item/food/rootdoughslice/egg
	foodtypes = parent_type::foodtypes | MEAT

/obj/item/food/rootdoughslice/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spaghetti/nizaya, 1, 3 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/rootdoughslice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/rootroll, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/rootdoughslice/egg
	process_type = /obj/item/food/spaghetti/nizaya/egg
	bake_type = /obj/item/food/rootroll/egg

/obj/item/food/root_flatbread
	name = "块根薄饼"
	desc = "朴素的烤块根薄饼，可以铺上蜥蜴人爱吃的各种食材。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "root_flatbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("bread" = 1, "earthy heat" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/root_flatbread/egg
	foodtypes = parent_type::foodtypes | MEAT

/obj/item/food/rootroll
	name = "块根面包卷"
	desc = "以块根制成的扎实耐嚼面包卷，配汤吃很不错。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootroll"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("roll" = 1) // the roll tastes of roll.
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/rootroll/egg
	foodtypes = parent_type::foodtypes | MEAT

//Bread Dishes

/obj/item/food/bread/root
	name = "块根面包"
	desc = "蜥蜴人的面包，用土豆、薯蓣等块根与磨碎的坚果、种子混合制成，明显比普通面包更扎实。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_bread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("bread" = 8, "nuts" = 2)
	foodtypes = VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/breadslice/root

/obj/item/food/bread/root/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/bread/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 8)

/obj/item/food/bread/root/egg
	foodtypes = parent_type::foodtypes | MEAT
	slice_type = /obj/item/food/breadslice/root/egg

/obj/item/food/breadslice/root
	name = "块根面包片"
	desc = "一片扎实耐嚼的块根面包。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_breadslice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("bread" = 8, "nuts" = 2)
	foodtypes = VEGETABLES | NUTS
	venue_value = FOOD_PRICE_TRASH

/obj/item/food/breadslice/root/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/breadslice/root/egg
	foodtypes = parent_type::foodtypes | MEAT

//Pizza Dishes
/obj/item/food/pizza/flatbread
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = null
	abstract_type = /obj/item/food/pizza/flatbread
	slice_type = null

/obj/item/food/pizza/flatbread/rustic
	name = "乡村薄饼"
	desc = "简单的提兹拉乡村菜，常用来搭配肉类或鱼类料理。上面撒着香草、淋着油。"
	icon_state = "rustic_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/vitamin = 15,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("bread" = 1, "herb" = 1, "oil" = 1, "garlic" = 1)
	foodtypes = VEGETABLES | NUTS
	boxtag = "提兹拉薄饼"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/italic
	name = "\improper 意式薄饼"
	desc = "人类食品传入提兹拉，推动了蜥蜴人烹饪的发展。如今意式薄饼已是当地外卖店菜单上的常客。"
	icon_state = "italic_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	tastes = list("bread" = 1, "herb" = 1, "oil" = 1, "garlic" = 1, "tomato" = 1, "meat" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT
	boxtag = "意式薄饼"
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/pizza/flatbread/imperial
	name = "\improper 帝国薄饼"
	desc = "铺着肉酱、腌蔬菜和头肉酪丁的薄饼。除了蜥蜴人，大概没多少人吃得惯。"
	icon_state = "imperial_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("bread" = 1, "herb" = 1, "oil" = 1, "garlic" = 1, "tomato" = 1, "meat" = 1)
	foodtypes = VEGETABLES | MEAT | NUTS | GORE
	boxtag = "帝国凯旋薄饼"
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/pizza/flatbread/rawmeat
	name = "肉食爱好者薄饼"
	desc = "奇怪的是，这道提兹拉菜竟颇受某些注重健康的人类喜爱。"
	icon_state = "rawmeat_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 10,
	)
	tastes = list("bread" = 1, "meat" = 1)
	foodtypes = MEAT|VEGETABLES|RAW|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/pizza/flatbread/stinging
	name = "\improper 蜇刺薄饼"
	desc = "水母与蜂幼虫碰撞出触电般的味觉体验，让你吃了还想吃！"
	icon_state = "stinging_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/consumable/honey = 2,
	)
	tastes = list("bread" = 1, "sweetness" = 1, "stinging" = 1, "slime" = 1)
	foodtypes = MEAT|VEGETABLES|NUTS|SEAFOOD|BUGS|GORE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/zmorgast  // Name is based off of the Swedish dish Smörgåstårta
	name = "\improper 蜥式三明治蛋糕薄饼"
	desc = "由瑞典三明治蛋糕改编而来的提兹拉料理，是家庭聚会上的常见菜。"
	icon_state = "zmorgast_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bread" = 1, "liver" = 1, "family" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT | EGG
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/fish
	name = "\improper 烧烤鱼肉薄饼"
	desc = "超级引擎脱层、小丑特工、外面冷得要命——看在提兹拉的份上，我只想安安静静烧烤！"
	icon_state = "fish_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/bbqsauce = 2,
	)
	tastes = list("bread" = 1, "fish" = 1)
	foodtypes = VEGETABLES|NUTS|SEAFOOD
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/flatbread/mushroom
	name = "蘑菇番茄薄饼"
	desc = "比意式薄饼更简单的选择，适合已经在别处吃够了肉的时候。"
	icon_state = "mushroom_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 18,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes =  list("bread" = 1, "mushroom" = 1, "tomatoes" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/flatbread/nutty
	name = "坚果酱薄饼"
	desc = "现代烹饪的进步，让科塔坚果既能做饼底又能做配料，带来双倍的美味。"
	icon_state = "nutty_flatbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes =  list("bread" = 1, "nuts" = 2)
	foodtypes = NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

//Sandwiches/Toast Dishes
/obj/item/food/emperor_roll
	name = "帝皇面包卷"
	desc = "提兹拉流行的三明治，为致敬皇室而得名。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "emperor_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bread" = 1, "cheese" = 1, "liver" = 1, "caviar" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT | GORE | SEAFOOD
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2.25)

/obj/item/food/honey_roll
	name = "蜂蜜甜面包卷"
	desc = "加甜的块根面包卷配上水果片，是提兹拉的时令甜点。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "honey_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/honey = 2,
	)
	tastes = list("bread" = 1, "honey" = 1, "fruit" = 1)
	foodtypes = VEGETABLES | NUTS | FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

//Egg Dishes
/obj/item/food/black_eggs
	name = "黑炒蛋"
	desc = "提兹拉乡间的家常菜，用鸡蛋、血和采来的野菜做成，传统上配块根面包和辣酱食用。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "black_eggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("eggs" = 1, "greens" = 1, "blood" = 1)
	foodtypes = MEAT | BREAKFAST | GORE | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/patzikula
	name = "辣番茄烘蛋"
	desc = "绵滑辛辣的番茄酱汁上打入鸡蛋，再一同烘烤。美味。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "patzikula"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("eggs" = 1, "tomato" = 1, "heat" = 1)
	foodtypes = VEGETABLES | MEAT | BREAKFAST | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Cakes/Sweets

/obj/item/food/cake/korta_brittle
	name = "科塔坚果脆糖板"
	desc = "一大板科塔坚果脆糖。甜得简直该算犯罪！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_brittle"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 20,
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/korta_nectar = 15,
	)
	tastes = list("peppery heat" = 1, "sweetness" = 1)
	foodtypes = NUTS | SUGAR
	slice_type = /obj/item/food/cakeslice/korta_brittle
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/korta_brittle
	name = "科塔坚果脆糖片"
	desc = "一小片科塔坚果脆糖。糖尿病患者的头号敌人。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_brittle_slice"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/korta_nectar = 3,
	)
	tastes = list("peppery heat" = 1, "sweetness" = 1)
	foodtypes = NUTS | SUGAR

/obj/item/food/snowcones/korta_ice
	name = "科塔刨冰"
	desc = "刨冰、科塔花蜜和莓果，香甜的消暑佳品！"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_ice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/ice = 4,
		/datum/reagent/consumable/berryjuice = 6,
	)
	tastes = list("peppery sweet" = 1, "berry" = 1)
	foodtypes = NUTS | SUGAR | FRUIT

/obj/item/food/kebab/candied_mushrooms
	name = "糖渍蘑菇串"
	desc = "略显古怪的提兹拉菜，把塞拉卡菇裹上焦糖串起来，咸甜交织的滋味十分鲜明。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "candied_mushrooms"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/caramel = 4,
	)
	tastes = list("savouriness" = 1, "sweetness" = 1)
	foodtypes = SUGAR | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

//Misc Dishes
/obj/item/food/sauerkraut
	name = "德式酸菜"
	desc = "因德国人而闻名的腌卷心菜，如今也常见于蜥蜴人料理，并有了蜥式酸菜的称呼。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "sauerkraut"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("cabbage" = 1, "acid" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/lizard_dumplings
	name = "\improper 提兹拉团子"
	desc = "将块根蔬菜泥与科塔粉混合，煮成硕大圆润、略带辣味的团子，通常放在汤里吃。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_dumplings"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("potato" = 1, "earthy heat" = 1)
	foodtypes = VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/steeped_mushrooms
	name = "浸泡塞拉卡菇"
	desc = "用碱水浸泡，去除提取物后的塞拉卡菇，已经可以完全放心地食用。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "steeped_mushrooms"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("savouriness" = 1, "nuttiness" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/canned/jellyfish
	name = "炮手水母罐头"
	desc = "一罐盐水浸泡的炮手水母，含有少量致幻物质，烹饪后会被破坏。"
	icon_state = "jellyfish"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/toxin/mindbreaker = 2,
		/datum/reagent/consumable/salt = 1,
	)
	trash_type = /obj/item/trash/can/food/jellyfish
	tastes = list("slime" = 1, "burning" = 1, "salt" = 1)
	foodtypes = SEAFOOD | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/canned/desert_snails
	name = "沙漠蜗牛罐头"
	desc = "来自提兹拉沙漠的巨型蜗牛，连壳泡在盐水里装罐。除非你是蜥蜴人，否则最好别生吃。"
	icon_state = "snails"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/salt = 2,
	)
	trash_type = /obj/item/trash/can/food/desert_snails
	tastes = list("snails" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/canned/larvae
	name = "蜂幼虫罐头"
	desc = "一罐浸在蜂蜜里的蜂幼虫。总有人会觉得开胃吧。"
	icon_state = "larvae"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/honey = 2,
	)
	trash_type = /obj/item/trash/can/food/larvae
	tastes = list("sweet bugs" = 1)
	foodtypes = MEAT | GORE | BUGS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/rootbread_peanut_butter_jelly
	name = "花生酱果酱块根三明治"
	desc = "经典的花生酱果酱块根三明治，就像取代你妈妈的复制人以前做的一样。"
	icon_state = "peanutbutter-jelly"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("peanut butter" = 1, "jelly" = 1, "rootbread" = 2)
	foodtypes = FRUIT|VEGETABLES|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rootbread_peanut_butter_banana
	name = "花生酱香蕉块根三明治"
	desc = "花生酱块根三明治里夹着香蕉片，是不错的高蛋白点心。"
	icon_state = "peanutbutter-banana"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("peanut butter" = 1, "banana" = 1, "rootbread" = 2)
	foodtypes = FRUIT|VEGETABLES|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/burger/plain/korta
	name = "原味块根汉堡"
	desc = "块根圆面包夹着一块朴素的肉饼。"
	icon_state = "kortaburger"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = MEAT|VEGETABLES|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3 //Gotta make the dough, +1
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/rat/korta
	name = "鼠肉块根汉堡"
	desc = "基本就是你想的那样……只是换成了块根圆面包。"
	icon_state = "ratburger"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("dead rat" = 4, "bun" = 2)
	foodtypes = NUTS | MEAT | GORE | VEGETABLES | RAW
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/burger/rootguffin
	name = "根香麦高芬"
	desc = "廉价油腻的班尼迪克蛋仿制品，蜥蜴人也能享用。"
	icon_state = "rootguffin"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/eggyolk = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("muffin" = 2, "bacon" = 3)
	foodtypes = NUTS | MEAT | BREAKFAST | VEGETABLES | FRIED | EGG
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/rootrib
	name = "根香肋排堡"
	desc = "银河各地限量供应、难觅踪影的肋排形汉堡。如今也满足亚人类的需求。"
	icon_state = "rootrib"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/bbqsauce = 1,
	)
	tastes = list("bun" = 2, "pork patty" = 4)
	foodtypes = NUTS | MEAT | VEGETABLES | SUGAR
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/rootchicken
	name = "鸡肉块根三明治"
	desc = "美味的鸡肉夹在松软的块根面包卷里。"
	icon_state = "rootchicken"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/mayonnaise = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("bun" = 2, "chicken" = 4, "God's covenant" = 1)
	foodtypes = NUTS | MEAT | VEGETABLES
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/rootfish
	name = "鱼肉块根三明治"
	desc = "薄薄裹糊的鱼肉夹在块根面包卷里。"
	icon_state = "rootfish"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 4, "fish" = 4)
	foodtypes = VEGETABLES | NUTS | SEAFOOD
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/burger/sloppyroot
	name = "嘶嘶邋遢莫"
	desc = "碎肉混着洋葱和烧烤酱——嘶，乱糟糟地堆在块根面包卷上。美味，但绝对会弄脏你的手。"
	icon_state = "sloppyroot"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("juicy meat" = 4, "BBQ sauce" = 3, "onions" = 2, "bun" = 2)
	foodtypes = NUTS | MEAT | VEGETABLES
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)
