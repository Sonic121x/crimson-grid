//Not to be confused with /obj/item/reagent_containers/cup/glass/bottle

/obj/item/reagent_containers/cup/bottle
	name = "小瓶"
	desc = "一个小瓶子。"
	icon_state = "bottle"
	fill_icon_state = "bottle"
	inhand_icon_state = "atoxinbottle"
	worn_icon_state = "bottle"
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	possible_transfer_amounts = list(5, 10, 15, 25, 50)
	volume = 50
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)
	can_lid = TRUE
	assembly_pixel_y = 4

/obj/item/reagent_containers/cup/bottle/Initialize(mapload)
	. = ..()
	if(!icon_state)
		icon_state = "bottle"
	update_appearance()

/obj/item/reagent_containers/cup/bottle/epinephrine
	name = "肾上腺素瓶"
	desc = "一个小瓶子，装着用于稳定病人状况的肾上腺素。"
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30)

/obj/item/reagent_containers/cup/bottle/toxin
	name = "毒素瓶"
	desc = "一小瓶毒素。请勿饮用，有毒。"
	list_reagents = list(/datum/reagent/toxin = 30)

/obj/item/reagent_containers/cup/bottle/cyanide
	name = "氰化物瓶"
	desc = "一小瓶氰化物。苦杏仁味？"
	list_reagents = list(/datum/reagent/toxin/cyanide = 30)

/obj/item/reagent_containers/cup/bottle/anacea
	name = "灭药毒素瓶"
	desc = "一小瓶灭药毒素。"
	list_reagents = list(/datum/reagent/toxin/anacea = 30)

/obj/item/reagent_containers/cup/bottle/spewium
	name = "催吐素瓶"
	desc = "一小瓶催吐素。"
	list_reagents = list(/datum/reagent/toxin/spewium = 30)

/obj/item/reagent_containers/cup/bottle/syndol
	name = "辛幻灵瓶"
	desc = "一小瓶辛幻灵。"
	list_reagents = list(/datum/reagent/drug/syndol = 30)

/obj/item/reagent_containers/cup/bottle/morphine
	name = "吗啡瓶"
	desc = "一小瓶吗啡。"
	icon = 'icons/obj/medical/chemical.dmi'
	list_reagents = list(/datum/reagent/medicine/morphine = 30)

/obj/item/reagent_containers/cup/bottle/chloralhydrate
	name = "水合氯醛瓶"
	desc = "一小瓶水合氯醛。米奇的最爱！"
	icon_state = "bottle20"
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 15)

/obj/item/reagent_containers/cup/bottle/mannitol
	name = "甘露醇瓶"
	desc = "一小瓶甘露醇，可用于治疗脑损伤。"
	list_reagents = list(/datum/reagent/medicine/mannitol = 30)

/obj/item/reagent_containers/cup/bottle/multiver
	name = "多效净瓶"
	desc = "一小瓶多效净，能清除血液中的毒素及其他化学物质，但会导致呼吸急促。所有效果都会随病人体内试剂的数量增强。"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 30)

/obj/item/reagent_containers/cup/bottle/calomel
	name = "甘汞瓶"
	desc = "一小瓶甘汞，这种有毒药物能迅速清除血液中的化学物质，对重伤者不会造成额外伤害。"
	list_reagents = list(/datum/reagent/medicine/calomel = 30)

/obj/item/reagent_containers/cup/bottle/phlogiston
	name = "燃素瓶"
	desc = "一小瓶燃素，使用后会让你着火。"
	list_reagents = list(/datum/reagent/phlogiston = 30)

/obj/item/reagent_containers/cup/bottle/ammoniated_mercury
	name = "氯氨汞瓶"
	desc = "迅速清除体内有毒化学物质。在身体状况良好、\
		没有物理或烧伤损伤时能治疗毒素损伤；存在物理或烧伤损伤时，则可能造成大量毒素损伤。\
		体内没有毒素时，它会开始缓慢自行清除。"
	list_reagents = list(/datum/reagent/medicine/ammoniated_mercury = 30)

/obj/item/reagent_containers/cup/bottle/syriniver
	name = "注净灵瓶"
	desc = "一小瓶注净灵。"
	list_reagents = list(/datum/reagent/medicine/c2/syriniver = 30)

/obj/item/reagent_containers/cup/bottle/mutagen
	name = "不稳定诱变剂瓶"
	desc = "一小瓶不稳定诱变剂，会随机改变接触者的DNA结构。"
	list_reagents = list(/datum/reagent/toxin/mutagen = 30)

/obj/item/reagent_containers/cup/bottle/plasma
	name = "液态等离子瓶"
	desc = "一小瓶液态等离子，毒性极强，会与血液中的微生物发生反应。"
	list_reagents = list(/datum/reagent/toxin/plasma = 30)

/obj/item/reagent_containers/cup/bottle/synaptizine
	name = "突触嗪瓶"
	desc = "一小瓶突触嗪。"
	list_reagents = list(/datum/reagent/medicine/synaptizine = 30)

/obj/item/reagent_containers/cup/bottle/ammonia
	name = "氨瓶"
	desc = "一小瓶氨。"
	list_reagents = list(/datum/reagent/ammonia = 30)

/obj/item/reagent_containers/cup/bottle/diethylamine
	name = "二乙胺瓶"
	desc = "一小瓶二乙胺。"
	list_reagents = list(/datum/reagent/diethylamine = 30)

/obj/item/reagent_containers/cup/bottle/facid
	name = "氟磺酸瓶"
	desc = "一个小瓶子，装着少量氟磺酸。"
	list_reagents = list(/datum/reagent/toxin/acid/fluacid = 30)

/obj/item/reagent_containers/cup/bottle/adminordrazine
	name = "神赐灵瓶"
	desc = "一个小瓶子，装着诸神的液态精华。"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "holyflask"
	worn_icon_state = "holyflask"
	inhand_icon_state = "holyflask"
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 30)

/obj/item/reagent_containers/cup/bottle/capsaicin
	name = "辣椒素瓶"
	desc = "一个小瓶子，装着辣酱。"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 30)

/obj/item/reagent_containers/cup/bottle/frostoil
	name = "冰霜油瓶"
	desc = "一个小瓶子，装着冰冷的酱汁。"
	list_reagents = list(/datum/reagent/consumable/frostoil = 30)

/obj/item/reagent_containers/cup/bottle/strange_reagent
	name = "奇异试剂瓶"
	desc = "一个小瓶子，或许能用来复活人。"
	list_reagents = list(/datum/reagent/medicine/strange_reagent = 30)

/obj/item/reagent_containers/cup/bottle/fishy_reagent
	name = "鱼腥试剂瓶"
	desc = "一个小瓶子，或许能用来复活鱼。"
	list_reagents = list(/datum/reagent/medicine/strange_reagent/fishy_reagent = 30)

/obj/item/reagent_containers/cup/bottle/traitor
	name = "辛迪加试剂瓶"
	desc = "一个小瓶子，装着一种随机的恶毒化学品。"
	icon = 'icons/obj/medical/chemical.dmi'
	var/extra_reagent = null

/obj/item/reagent_containers/cup/bottle/traitor/Initialize(mapload)
	. = ..()
	extra_reagent = pick(/datum/reagent/toxin/polonium, /datum/reagent/toxin/histamine, /datum/reagent/toxin/formaldehyde, /datum/reagent/toxin/venom, /datum/reagent/toxin/fentanyl, /datum/reagent/toxin/cyanide)
	reagents.add_reagent(extra_reagent, 3)

/obj/item/reagent_containers/cup/bottle/polonium
	name = "钋瓶"
	desc = "一个小瓶子，装着钋。"
	list_reagents = list(/datum/reagent/toxin/polonium = 30)

/obj/item/reagent_containers/cup/bottle/magillitis
	name = "巨猿血清瓶"
	desc = "一个小瓶子，装着一种仅知其名为'巨猿血清'的血清。"
	list_reagents = list(/datum/reagent/magillitis = 5)

/obj/item/reagent_containers/cup/bottle/venom
	name = "毒液瓶"
	desc = "一个小瓶子，装着毒液。"
	list_reagents = list(/datum/reagent/toxin/venom = 30)

/obj/item/reagent_containers/cup/bottle/fentanyl
	name = "芬太尼瓶"
	desc = "一个小瓶子，装着芬太尼。"
	list_reagents = list(/datum/reagent/toxin/fentanyl = 30)

/obj/item/reagent_containers/cup/bottle/formaldehyde
	name = "甲醛瓶"
	desc = "一个小瓶子，装着能防止器官腐烂的甲醛。"
	list_reagents = list(/datum/reagent/toxin/formaldehyde = 30)

/obj/item/reagent_containers/cup/bottle/initropidril
	name = "停心普利瓶"
	desc = "一个小瓶子，装着停心普利。"
	list_reagents = list(/datum/reagent/toxin/initropidril = 30)

/obj/item/reagent_containers/cup/bottle/pancuronium
	name = "泮库溴铵瓶"
	desc = "一个小瓶子，装着泮库溴铵。"
	list_reagents = list(/datum/reagent/toxin/pancuronium = 30)

/obj/item/reagent_containers/cup/bottle/sodium_thiopental
	name = "硫喷妥钠瓶"
	desc = "一个小瓶子，装着硫喷妥钠。"
	list_reagents = list(/datum/reagent/toxin/sodium_thiopental = 30)

/obj/item/reagent_containers/cup/bottle/coniine
	name = "毒芹碱瓶"
	desc = "一个小瓶子，装着毒芹碱。"
	list_reagents = list(/datum/reagent/toxin/coniine = 30)

/obj/item/reagent_containers/cup/bottle/curare
	name = "箭毒瓶"
	desc = "一个小瓶子，装着箭毒。"
	list_reagents = list(/datum/reagent/toxin/curare = 30)

/obj/item/reagent_containers/cup/bottle/amanitin
	name = "鹅膏毒肽瓶"
	desc = "一个小瓶子，装着鹅膏毒肽。"
	list_reagents = list(/datum/reagent/toxin/amanitin = 30)

/obj/item/reagent_containers/cup/bottle/histamine
	name = "组胺瓶"
	desc = "一个小瓶子，装着组胺。"
	list_reagents = list(/datum/reagent/toxin/histamine = 30)

/obj/item/reagent_containers/cup/bottle/carnivorous_blood
	name = "食肉血液瓶"
	desc = "一个小瓶子，装着食肉血液。"
	list_reagents = list(/datum/reagent/toxin/carnivorousblood = 30)

/obj/item/reagent_containers/cup/bottle/diphenhydramine
	name = "抗组胺剂瓶"
	desc = "一小瓶苯海拉明。"
	list_reagents = list(/datum/reagent/medicine/diphenhydramine = 30)

/obj/item/reagent_containers/cup/bottle/potass_iodide
	name = "抗辐射药瓶"
	desc = "一小瓶碘化钾。"
	list_reagents = list(/datum/reagent/medicine/potass_iodide = 30)

/obj/item/reagent_containers/cup/bottle/salglu_solution
	name = "葡萄糖盐水瓶"
	desc = "一小瓶葡萄糖盐水。"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 30)

/obj/item/reagent_containers/cup/bottle/atropine
	name = "阿托品瓶"
	desc = "一小瓶阿托品。"
	list_reagents = list(/datum/reagent/medicine/atropine = 30)

/obj/item/reagent_containers/cup/bottle/random_buffer
	name = "缓冲液瓶"
	desc = "一小瓶化学缓冲液。"

/obj/item/reagent_containers/cup/bottle/random_buffer/Initialize(mapload)
	. = ..()
	if(prob(50))
		name = "酸性缓冲液瓶"
		desc = "一小瓶酸性缓冲液。"
		reagents.add_reagent(/datum/reagent/reaction_agent/acidic_buffer, 30)
	else
		name = "碱性缓冲液瓶"
		desc = "一小瓶碱性缓冲液。"
		reagents.add_reagent(/datum/reagent/reaction_agent/basic_buffer, 30)

/obj/item/reagent_containers/cup/bottle/acidic_buffer
	name = "酸性缓冲液瓶"
	desc = "一小瓶酸性缓冲液。"
	list_reagents = list(/datum/reagent/reaction_agent/acidic_buffer = 30)

/obj/item/reagent_containers/cup/bottle/basic_buffer
	name = "碱性缓冲液瓶"
	desc = "一小瓶碱性缓冲液。"
	list_reagents = list(/datum/reagent/reaction_agent/basic_buffer = 30)

/obj/item/reagent_containers/cup/bottle/inversing_buffer
	name = "手性反转缓冲液瓶"
	desc = "一小瓶手性反转缓冲液。"
	list_reagents = list(/datum/reagent/reaction_agent/inversing_buffer = 30)

/obj/item/reagent_containers/cup/bottle/romerol
	name = "罗梅罗瓶"
	desc = "一小瓶罗梅罗。这才是真正的僵尸粉。"
	list_reagents = list(/datum/reagent/romerol = 30)

/obj/item/reagent_containers/cup/bottle/moltobeso
	name = "暴食浓酱瓶"
	desc = "辛迪加烹饪专家带来的革命性新酱汁，旨在瞬间重塑你的身材！\
			本品功效的关键在于独特配方，以精挑细选的原料刺激食欲，增强热量吸收。"
	list_reagents = list(/datum/reagent/consumable/moltobeso = 50)

/obj/item/reagent_containers/cup/bottle/random_virus
	name = "实验疾病培养瓶"
	desc = "一个小瓶子，装着以合成血为培养基、未经测试的病毒培养物。"
	spawned_disease = /datum/disease/advance/random

/obj/item/reagent_containers/cup/bottle/pierrot_throat
	name = "丑角喉症培养瓶"
	desc = "一个小瓶子，装着以合成血为培养基的H0NI<42型病毒粒子培养物。"
	spawned_disease = /datum/disease/pierrot_throat

/obj/item/reagent_containers/cup/bottle/cold
	name = "鼻病毒培养瓶"
	desc = "一个小瓶子，装着以合成血为培养基的XY型鼻病毒培养物。"
	spawned_disease = /datum/disease/advance/cold

/obj/item/reagent_containers/cup/bottle/flu_virion
	name = "流感病毒粒子培养瓶"
	desc = "一个小瓶子，装着以合成血为培养基的H13N1型流感病毒粒子培养物。"
	spawned_disease = /datum/disease/advance/flu

/obj/item/reagent_containers/cup/bottle/retrovirus
	name = "逆转录病毒培养瓶"
	desc = "一个小瓶子，装着以合成血为培养基的逆转录病毒培养物。"
	spawned_disease = /datum/disease/dna_retrovirus

/obj/item/reagent_containers/cup/bottle/gbs
	name = "GBS病培养瓶"
	desc = "一个小瓶子，装着以合成血为培养基的重力操控双势因子SADS+培养物。"//Or simply - General BullShit
	amount_per_transfer_from_this = 5
	spawned_disease = /datum/disease/gbs

/obj/item/reagent_containers/cup/bottle/fake_gbs
	name = "GBS病培养瓶"
	desc = "一个小瓶子，装着以合成血为培养基的重力操控双势因子SADS-培养物。"//Or simply - General BullShit
	spawned_disease = /datum/disease/fake_gbs

/obj/item/reagent_containers/cup/bottle/brainrot
	name = "脑腐病培养瓶"
	desc = "一个小瓶子，装着以合成血为培养基的星际隐球菌培养物。"
	icon_state = "bottle3"
	spawned_disease = /datum/disease/brainrot

/obj/item/reagent_containers/cup/bottle/magnitis
	name = "磁化症培养瓶"
	desc = "一个小瓶子，装着少量见鬼奇迹因子。"
	spawned_disease = /datum/disease/magnitis

/obj/item/reagent_containers/cup/bottle/wizarditis
	name = "巫师症培养瓶"
	desc = "一个小瓶子，装着林斯温德普通型病原体样本。"
	spawned_disease = /datum/disease/wizarditis

/obj/item/reagent_containers/cup/bottle/anxiety
	name = "重度焦虑症培养瓶"
	desc = "一个小瓶子，装着灭蝶剂样本。"
	spawned_disease = /datum/disease/anxiety

/obj/item/reagent_containers/cup/bottle/beesease
	name = "蜂巢病培养瓶"
	desc = "一个小瓶子，装着入侵性蜜蜂样本。"
	spawned_disease = /datum/disease/beesease

/obj/item/reagent_containers/cup/bottle/fluspanish
	name = "西班牙流感培养瓶"
	desc = "一个小瓶子，装着宗教裁判因子样本。"
	spawned_disease = /datum/disease/fluspanish

/obj/item/reagent_containers/cup/bottle/tuberculosis
	name = "真菌性结核病培养瓶"
	desc = "一个小瓶子，装着真菌性结核杆菌样本。"
	spawned_disease = /datum/disease/tuberculosis

/obj/item/reagent_containers/cup/bottle/tuberculosiscure
	name = "生物病毒解毒套剂瓶"
	desc = "一个装着生物病毒解毒套剂的小瓶子。"
	list_reagents = list(/datum/reagent/vaccine/fungal_tb = 30)

//Oldstation.dmm chemical storage bottles

/obj/item/reagent_containers/cup/bottle/hydrogen
	name = "氢瓶"
	list_reagents = list(/datum/reagent/hydrogen = 30)

/obj/item/reagent_containers/cup/bottle/lithium
	name = "锂瓶"
	list_reagents = list(/datum/reagent/lithium = 30)

/obj/item/reagent_containers/cup/bottle/carbon
	name = "碳瓶"
	list_reagents = list(/datum/reagent/carbon = 30)

/obj/item/reagent_containers/cup/bottle/nitrogen
	name = "氮瓶"
	list_reagents = list(/datum/reagent/nitrogen = 30)

/obj/item/reagent_containers/cup/bottle/oxygen
	name = "氧瓶"
	list_reagents = list(/datum/reagent/oxygen = 30)

/obj/item/reagent_containers/cup/bottle/fluorine
	name = "氟瓶"
	list_reagents = list(/datum/reagent/fluorine = 30)

/obj/item/reagent_containers/cup/bottle/sodium
	name = "钠瓶"
	list_reagents = list(/datum/reagent/sodium = 30)

/obj/item/reagent_containers/cup/bottle/aluminium
	name = "铝瓶"
	list_reagents = list(/datum/reagent/aluminium = 30)

/obj/item/reagent_containers/cup/bottle/silicon
	name = "硅瓶"
	list_reagents = list(/datum/reagent/silicon = 30)

/obj/item/reagent_containers/cup/bottle/phosphorus
	name = "磷瓶"
	list_reagents = list(/datum/reagent/phosphorus = 30)

/obj/item/reagent_containers/cup/bottle/sulfur
	name = "硫瓶"
	list_reagents = list(/datum/reagent/sulfur = 30)

/obj/item/reagent_containers/cup/bottle/chlorine
	name = "氯瓶"
	list_reagents = list(/datum/reagent/chlorine = 30)

/obj/item/reagent_containers/cup/bottle/potassium
	name = "钾瓶"
	list_reagents = list(/datum/reagent/potassium = 30)

/obj/item/reagent_containers/cup/bottle/iron
	name = "铁瓶"
	list_reagents = list(/datum/reagent/iron = 30)

/obj/item/reagent_containers/cup/bottle/copper
	name = "铜瓶"
	list_reagents = list(/datum/reagent/copper = 30)

/obj/item/reagent_containers/cup/bottle/mercury
	name = "汞瓶"
	list_reagents = list(/datum/reagent/mercury = 30)

/obj/item/reagent_containers/cup/bottle/radium
	name = "镭瓶"
	list_reagents = list(/datum/reagent/uranium/radium = 30)

/obj/item/reagent_containers/cup/bottle/water
	name = "水瓶"
	list_reagents = list(/datum/reagent/water = 30)

/obj/item/reagent_containers/cup/bottle/ethanol
	name = "乙醇瓶"
	list_reagents = list(/datum/reagent/consumable/ethanol = 30)

/obj/item/reagent_containers/cup/bottle/sugar
	name = "糖瓶"
	list_reagents = list(/datum/reagent/consumable/sugar = 30)

/obj/item/reagent_containers/cup/bottle/sacid
	name = "硫酸瓶"
	list_reagents = list(/datum/reagent/toxin/acid = 30)

/obj/item/reagent_containers/cup/bottle/welding_fuel
	name = "焊接燃料瓶"
	list_reagents = list(/datum/reagent/fuel = 30)

/obj/item/reagent_containers/cup/bottle/silver
	name = "银瓶"
	list_reagents = list(/datum/reagent/silver = 30)

/obj/item/reagent_containers/cup/bottle/iodine
	name = "碘瓶"
	list_reagents = list(/datum/reagent/iodine = 30)

/obj/item/reagent_containers/cup/bottle/bromine
	name = "溴瓶"
	list_reagents = list(/datum/reagent/bromine = 30)

/obj/item/reagent_containers/cup/bottle/thermite
	name = "铝热剂瓶"
	list_reagents = list(/datum/reagent/thermite = 50)

// Bottles for mail goodies.

/obj/item/reagent_containers/cup/bottle/clownstears
	name = "蒸馏小丑苦难瓶"
	desc = "一个小瓶子，装着顶级调酒师使用的神话液体，由小丑的不幸制成。"
	list_reagents = list(/datum/reagent/consumable/nutriment/soup/clown_tears = 30)

/obj/item/reagent_containers/cup/bottle/saltpetre
	name = "硝石瓶"
	desc = "一个小瓶子，装着硝石。"
	list_reagents = list(/datum/reagent/saltpetre = 30)

/obj/item/reagent_containers/cup/bottle/flash_powder
	name = "闪光粉瓶"
	desc = "一个小瓶子，装着闪光粉。"
	list_reagents = list(/datum/reagent/flash_powder = 30)

/obj/item/reagent_containers/cup/bottle/exotic_stabilizer
	name = "异质稳定剂瓶"
	desc = "一个小瓶子，装着异质稳定剂。"
	list_reagents = list(/datum/reagent/exotic_stabilizer = 30)

/obj/item/reagent_containers/cup/bottle/leadacetate
	name = "醋酸铅瓶"
	desc = "一个小瓶子，装着醋酸铅。"
	list_reagents = list(/datum/reagent/toxin/leadacetate = 30)

/obj/item/reagent_containers/cup/bottle/caramel
	name = "焦糖瓶"
	desc = "一个装着焦化糖的小瓶子，也就是焦糖。请勿舔舐。"
	list_reagents = list(/datum/reagent/consumable/caramel = 30)

/*
 *	Syrup bottles, basically a unspillable cup that transfers reagents upon clicking on it with a cup
 */

/obj/item/reagent_containers/cup/bottle/syrup_bottle
	name = "糖浆瓶"
	desc = "带有糖浆泵头的瓶子，能把美味糖浆直接挤进你的咖啡杯。"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "syrup"
	fill_icon_state = "syrup"
	fill_icon_thresholds = list(0, 20, 40, 60, 80, 100)
	possible_transfer_amounts = list(5, 10)
	amount_per_transfer_from_this = 5
	can_lid = FALSE
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/Initialize(mapload)
	. = ..()
	// this is not done via initial_reagent_flags because it represents state
	update_container_flags(SEALED_CONTAINER | TRANSPARENT)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/examine(mob/user)
	. = ..()
	. += span_notice("按住Alt点击以装卸泵头盖。")
	. += span_notice("用笔为它重命名。")

/obj/item/reagent_containers/cup/bottle/syrup_bottle/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()

	context[SCREENTIP_CONTEXT_ALT_LMB] = (is_open_container() ? "装上泵头盖" : "取下泵头盖")
	if(IS_WRITING_UTENSIL(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "书写标签"
	else if(is_open_container() && held_item?.is_refillable())
		context[SCREENTIP_CONTEXT_LMB] = "按压泵头"

	return CONTEXTUAL_SCREENTIP_SET

//when you attack the syrup bottle with a container it refills it
/obj/item/reagent_containers/cup/bottle/syrup_bottle/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(is_open_container() && tool.is_refillable())
		return refillable_act(user, tool)
	return ..()

/obj/item/reagent_containers/cup/bottle/syrup_bottle/nameformat(input, user)
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	return "[input? "[input] " : null]瓶"


/obj/item/reagent_containers/cup/bottle/syrup_bottle/proc/refillable_act(mob/user, obj/item/tool)
	if(!reagents.total_volume)
		balloon_alert(user, "瓶子空了！")
		return ITEM_INTERACT_BLOCKING
	if(tool.reagents.holder_full())
		balloon_alert(user, "容器已满！")
		return ITEM_INTERACT_BLOCKING

	var/transfer_amount = round(reagents.trans_to(tool, amount_per_transfer_from_this, transferred_by = user), CHEMICAL_VOLUME_ROUNDING)
	if(transfer_amount)
		balloon_alert(user, "已转移[transfer_amount]单位")
	flick("syrup_anim",src)
	tool.update_appearance()
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/bottle/syrup_bottle/update_icon_state()
	. = ..()
	if(is_open_container())
		icon_state = "syrup_open"
	else
		icon_state = "syrup"

/obj/item/reagent_containers/cup/bottle/syrup_bottle/click_alt(mob/user)
	if(is_open_container())
		balloon_alert(user, "已装上泵头盖")
		update_container_flags(SEALED_CONTAINER | TRANSPARENT)
	else
		balloon_alert(user, "已取下泵头盖")
		reset_container_flags()

	update_appearance()
	return CLICK_ACTION_SUCCESS

//types of syrups

/obj/item/reagent_containers/cup/bottle/syrup_bottle/caramel
	name = "焦糖糖浆瓶"
	desc = "一个装着焦化糖的泵瓶，也就是焦糖。请勿舔舐。"
	list_reagents = list(/datum/reagent/consumable/caramel = 50)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/liqueur
	name = "咖啡利口酒糖浆瓶"
	desc = "一个装着墨西哥咖啡风味利口酒糖浆的泵瓶。自1936年投产，HONK。"
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 50)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/korta_nectar
	name = "科塔坚果糖浆瓶"
	desc = "一个装着科塔坚果糖浆的泵瓶。用捣碎的甜科塔坚果制成，香甜可口。"
	list_reagents = list(/datum/reagent/consumable/korta_nectar = 50)

//secret syrup
/obj/item/reagent_containers/cup/bottle/syrup_bottle/laughsyrup
	name = "欢笑糖浆瓶"
	desc = "一个装着欢笑糖浆的泵瓶。欢笑豌豆榨出的汁液，气泡丰富，似乎会随着搭配的食物改变风味！"
	list_reagents = list(/datum/reagent/consumable/laughsyrup = 50)
