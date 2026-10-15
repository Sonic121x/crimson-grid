/obj/structure/closet/crate/secure
	desc = "一个带锁的安全货箱。"
	name = "安全货箱"
	icon_state = "securecrate"
	base_icon_state = "securecrate"
	secure = TRUE
	locked = TRUE
	max_integrity = 300
	armor_type = /datum/armor/crate_secure
	damage_deflection = 10

	var/tamperproof = 0

/datum/armor/crate_secure
	melee = 15
	bullet = 25
	laser = 25
	energy = 50
	fire = 40
	acid = 40

/obj/structure/closet/crate/secure/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_MISSING_ITEM_ERROR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NO_MANIFEST_CONTENTS_ERROR, TRAIT_GENERIC)

/obj/structure/closet/crate/secure/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	if(prob(tamperproof) && damage_amount >= DAMAGE_PRECISION)
		boom()
	else
		return ..()

/obj/structure/closet/crate/secure/proc/boom(mob/user)
	if(user)
		to_chat(user, span_danger("货箱的防拆系统启动了！"))
		log_bomber(user, "has detonated a", src)
	dump_contents()
	explosion(src, heavy_impact_range = 1, light_impact_range = 5, flash_range = 5)
	qdel(src)

/obj/structure/closet/crate/secure/weapon
	desc = "一个带锁的武器箱。"
	name = "武器箱"
	icon_state = "weaponcrate"
	base_icon_state = "weaponcrate"

/obj/structure/closet/crate/secure/plasma
	desc = "一个带锁的等离子体货箱。"
	name = "等离子体箱"
	icon_state = "plasmacrate"
	base_icon_state = "plasmacrate"

/obj/structure/closet/crate/secure/gear
	desc = "一个带锁的装备箱。"
	name = "装备箱"
	icon_state = "secgearcrate"
	base_icon_state = "secgearcrate"

/obj/structure/closet/crate/secure/hydroponics
	desc = "一个带锁的货箱，采用空间站植物学家的配色。"
	name = "安全水培用品箱"
	icon_state = "hydrosecurecrate"
	base_icon_state = "hydrosecurecrate"

/obj/structure/closet/crate/secure/freezer //for consistency with other "freezer" closets/crates
	desc = "一个带锁的冷藏箱，用于妥善存放易腐食品。"
	name = "安全厨房冷藏箱"
	icon_state = "kitchen_secure_crate"
	base_icon_state = "kitchen_secure_crate"
	paint_jobs = null

/obj/structure/closet/crate/secure/freezer/pizza
	name = "安全披萨箱"
	desc = "一个带锁的保温箱，用于妥善存放披萨。"
	tamperproof = 10
	req_access = list(ACCESS_KITCHEN)

/obj/structure/closet/crate/secure/freezer/pizza/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/food_or_drink/pizzaparty(src)

/obj/structure/closet/crate/secure/centcom
	name = "中央指挥部安全货箱"
	icon_state = "centcom_secure"
	base_icon_state = "centcom_secure"

/obj/structure/closet/crate/secure/cargo
	name = "安全货运箱"
	icon_state = "cargo_secure"
	base_icon_state = "cargo_secure"

/obj/structure/closet/crate/secure/cargo/mining
	name = "安全采矿用品箱"
	icon_state = "mining_secure"
	base_icon_state = "mining_secure"

/obj/structure/closet/crate/secure/radiation
	name = "安全辐射防护箱"
	icon_state = "radiation_secure"
	base_icon_state = "radiation_secure"

/obj/structure/closet/crate/secure/engineering
	desc = "一个带锁的货箱，采用空间站工程师的配色。"
	name = "安全工程用品箱"
	icon_state = "engi_secure_crate"
	base_icon_state = "engi_secure_crate"

/obj/structure/closet/crate/secure/engineering/atmos
	name = "安全大气设备箱"
	desc = "一个带锁的货箱，采用空间站大气工程师的配色。"
	icon_state = "atmos_secure"
	base_icon_state = "atmos_secure"


/obj/structure/closet/crate/secure/science
	name = "安全科研用品箱"
	desc = "一个带锁的货箱，采用空间站科学家的配色。"
	icon_state = "scisecurecrate"
	base_icon_state = "scisecurecrate"

/obj/structure/closet/crate/secure/science/robo
	name = "机器人科研设备箱"
	icon_state = "robo_secure"
	base_icon_state = "robo_secure"

/obj/structure/closet/crate/secure/trashcart
	desc = "一辆带轮子的沉重金属垃圾车，装有电子锁。"
	name = "安全垃圾推车"
	max_integrity = 250
	damage_deflection = 10
	icon_state = "securetrashcart"
	base_icon_state = "securetrashcart"
	weld_z = 5
	paint_jobs = null
	req_access = list(ACCESS_JANITOR)

/obj/structure/closet/crate/secure/trashcart/filled

/obj/structure/closet/crate/secure/trashcart/filled/PopulateContents()
	. = ..()
	for(var/i in 1 to rand(8,12))
		new /obj/effect/spawner/random/trash/deluxe_garbage(src)
		if(prob(35))
			new /obj/effect/spawner/random/trash/garbage(src)
	for(var/i in 1 to rand(4,6))
		if(prob(30))
			new /obj/item/storage/bag/trash/filled(src)

/obj/structure/closet/crate/secure/freezer/interdyne
	name = "\improper 星际动力冷冻柜"
	desc = "星际动力制药品牌的冷冻柜。里面也许有新鲜器官，也许没有。"
	icon_state = "interdynefreezer"
	base_icon_state = "interdynefreezer"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/crate/secure/freezer/interdyne/blood
	name = "\improper 星际动力血液冷冻柜"
	desc = "星际动力制药品牌的冷冻柜，用于储存新鲜优质的血液。"

/obj/structure/closet/crate/secure/freezer/interdyne/blood/PopulateContents()
	. = ..()
	for(var/i in 1 to 13)
		new /obj/item/reagent_containers/blood/random(src)

/obj/structure/closet/crate/secure/freezer/donk
	name = "\improper 当克公司冰箱"
	desc = "当克品牌冰箱，让你的当克口袋饼和泡沫弹药保持新鲜！"
	icon_state = "donkcocrate_secure"
	base_icon_state = "donkcocrate_secure"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/crate/secure/syndicate
	name = "\improper 辛迪加货箱"
	desc = "印有辛迪加标志的安全货箱。"
	icon_state = "syndicrate"
	base_icon_state = "syndicrate"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/crate/secure/syndicate/interdyne
	name = "\improper 星际动力货箱"
	desc = "星际动力制药的货箱。希望里面没有生化武器……"
	icon_state = "interdynecrate"
	base_icon_state = "interdynecrate"

/obj/structure/closet/crate/secure/syndicate/tiger
	name = "\improper 猛虎合作社货箱"
	icon_state = "tigercrate"
	base_icon_state = "tigercrate"

/obj/structure/closet/crate/secure/syndicate/self
	name = "\improper S.E.L.F.货箱"
	desc = "一个从内部上锁的安全货箱，上方设有扫描面板，并用全息影像显示锁的状态。有智机械解放阵线的工程师可真爱炫技。"
	icon_state = "selfcrate_secure"
	base_icon_state = "selfcrate_secure"

/obj/structure/closet/crate/secure/syndicate/mi13
	name = "神秘安全货箱"
	desc = "一个安全货箱。没有明显的标志，连标明来源的编号都没有，看起来像是从间谍电影里直接搬出来的。"
	icon_state = "mithirteencrate"
	base_icon_state = "mithirteencrate"
	open_sound_volume = 15
	close_sound_volume = 20

/obj/structure/closet/crate/secure/syndicate/arc
	name = "\improper 动物权益联盟货箱"
	icon_state = "arccrate"
	base_icon_state = "arccrate"

/obj/structure/closet/crate/secure/syndicate/cybersun
	name = "\improper 赛博太阳货箱"

/obj/structure/closet/crate/secure/syndicate/cybersun/dawn
	desc = "赛博太阳工业的安全货箱。独特的橙绿配色大概代表某个部门或分部，但你认不出来。"
	icon_state = "cyber_dawncrate"
	base_icon_state = "cyber_dawncrate"

/obj/structure/closet/crate/secure/syndicate/cybersun/noon
	desc = "赛博太阳工业的安全货箱。独特的黄橙配色大概代表某个部门或分部，但你认不出来。"
	icon_state = "cyber_nooncrate"
	base_icon_state = "cyber_nooncrate"

/obj/structure/closet/crate/secure/syndicate/cybersun/dusk
	desc = "赛博太阳工业的安全货箱。独特的紫绿配色大概代表某个部门或分部，但你认不出来。"
	icon_state = "cyber_duskcrate"
	base_icon_state = "cyber_duskcrate"

/obj/structure/closet/crate/secure/syndicate/cybersun/night
	desc = "赛博太阳工业的安全货箱。它毫不掩饰地采用了辛迪加配色。你只能猜测里面装着辛迪加特工的装备。"
	icon_state = "cyber_nightcrate"
	base_icon_state = "cyber_nightcrate"

/obj/structure/closet/crate/secure/syndicate/wafflecorp
	name = "\improper 华夫公司货箱"
	desc = "型号和设计都极其过时的运输箱，却加装了一把现代锁，真符合华夫公司这个品牌的风格。标志旁的金色花体字写着：“自2055年起，为您奉上连续位列全球前五*的早餐。”下方更小的花体字补充道：“*2099至2126年期间”……然而现在已经是2563年了。"
	icon_state = "wafflecrate"
	base_icon_state = "wafflecrate"

/obj/structure/closet/crate/secure/syndicate/gorlex
	name = "\improper 戈尔莱克斯掠夺者货箱"
	icon_state = "gorlexcrate"
	base_icon_state = "gorlexcrate"

/obj/structure/closet/crate/secure/syndicate/gorlex/weapons
	desc = "戈尔莱克斯掠夺者的安全武器箱。"
	name = "武器箱"
	icon_state = "gorlex_weaponcrate"
	base_icon_state = "gorlex_weaponcrate"

/obj/structure/closet/crate/secure/syndicate/gorlex/weapons/bustedlock
	desc = "印有戈尔莱克斯掠夺者标志的破旧武器箱。锁似乎已经坏了。"
	name = "损坏的武器箱"
	secure = FALSE
	locked = FALSE
	max_integrity = 400
	damage_deflection = 15
