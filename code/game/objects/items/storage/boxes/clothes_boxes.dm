// This contains all boxes that will possess something wearable, like an outfit or something similar.area

/obj/item/storage/box/gloves
	name = "乳胶手套盒"
	desc = "内有无菌乳胶手套。"
	illustration = "latex"

/obj/item/storage/box/gloves/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/gloves/latex(src)

/obj/item/storage/box/masks
	name = "无菌口罩盒"
	desc = "盒内装有无菌医用口罩。"
	illustration = "sterile"

/obj/item/storage/box/masks/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/mask/surgical(src)

/obj/item/storage/box/rxglasses
	name = "矫正眼镜盒"
	desc = "盒内装有书呆子眼镜。"
	illustration = "glasses"

/obj/item/storage/box/rxglasses/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/glasses/regular(src)

//it needs to be linked, hence a kit.
/obj/item/storage/box/rxglasses/spyglasskit
	name = "间谍眼镜套件"
	desc = "盒内装有<i>很酷的</i>书呆子眼镜，内置显示屏可查看连接的摄像头。"

/obj/item/storage/box/rxglasses/spyglasskit/PopulateContents()
	var/obj/item/clothing/accessory/spy_bug/newbug = new(src)
	var/obj/item/clothing/glasses/sunglasses/spy/newglasses = new(src)
	newbug.linked_glasses = newglasses
	newglasses.linked_bug = newbug
	new /obj/item/paper/fluff/nerddocs(src)

/obj/item/storage/box/tape_wizard
	name = "胶带巫师——第二十三集"
	desc = "盒内装着传奇娱乐偶像“超级胶带巫师”穿过的服装，取出来时有点粘。"

/obj/item/storage/box/tape_wizard/PopulateContents()
	new /obj/item/clothing/head/wizard/tape/fake(src)
	new /obj/item/clothing/suit/wizrobe/tape/fake(src)
	new /obj/item/staff/tape(src)
	new /obj/item/stack/medical/wrap/sticky_tape(src)

/obj/item/storage/box/fakesyndiesuit
	name = "仿制太空服与头盔盒"
	desc = "用于存放玩具太空服的光滑结实盒子。"
	icon_state = "syndiebox"
	illustration = "syndiesuit"

/obj/item/storage/box/fakesyndiesuit/PopulateContents()
	new /obj/item/clothing/head/syndicatefake(src)
	new /obj/item/clothing/suit/syndicatefake(src)

/obj/item/storage/box/syndie_kit/battle_royale
	name = "皇家乱斗转播套件"
	desc = "主持银河最精彩节目《皇家乱斗》所需的一切。"

/obj/item/storage/box/syndie_kit/battle_royale/PopulateContents()
	var/obj/item/royale_implanter/implanter = new(src)
	var/obj/item/royale_remote/remote = new(src)
	remote.link_implanter(implanter)

/obj/item/storage/box/deputy
	name = "辅警臂章盒"
	desc = "发给获准担任安保辅警的人员。"
	icon_state = "secbox"
	illustration = "depband"

/obj/item/storage/box/deputy/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/clothing/accessory/armband/deputy(src)

/obj/item/storage/box/hero
	name = "勇敢的古墓探险家——20世纪40年代"
	desc = "这位历史真实性尚存疑的传奇人物，据说是一位世界闻名的考古学家，带着标志性的长鞭和软呢帽，在遥远异域经历无数冒险。"

/obj/item/storage/box/hero/PopulateContents()
	new /obj/item/clothing/head/fedora/curator(src)
	new /obj/item/clothing/shoes/workboots/mining(src)
	new /obj/item/clothing/suit/jacket/curator(src)
	new /obj/item/clothing/under/rank/civilian/curator/treasure_hunter(src)
	new /obj/item/melee/curator_whip(src)

/obj/item/storage/box/hero/astronaut
	name = "首位登月者——20世纪60年代"
	desc = "个人的一小步，人类的一大步。穿上这套功能完备的复古舱外作业装备，重温太空探索的开端。"

/obj/item/storage/box/hero/astronaut/PopulateContents()
	new /obj/item/clothing/suit/space/nasavoid(src)
	new /obj/item/clothing/head/helmet/space/nasavoid(src)
	new /obj/item/tank/internals/oxygen(src)
	new /obj/item/gps(src)

/obj/item/storage/box/hero/scottish
	name = "勇敢的心，苏格兰反抗者——14世纪"
	desc = "似乎是苏格兰独立战争中的传奇人物，蓝色脸彩、大剑、奇怪的男式裙子，还有永不磨灭的口号：“自由！！”都与他紧密相连。"

/obj/item/storage/box/hero/scottish/PopulateContents()
	new /obj/item/claymore/weak/ceremonial(src)
	new /obj/item/clothing/shoes/sandal(src)
	new /obj/item/clothing/under/costume/kilt(src)
	new /obj/item/toy/crayon/spraycan(src)

/obj/item/storage/box/hero/carphunter
	name = "猎鲤人，野生动物专家——2506年"
	desc = "虽然有这个绰号，他主要以热情的环保与保育工作闻名，常接触危险野生动物，向人们展示自然之美。"

/obj/item/storage/box/hero/carphunter/PopulateContents()
	new /obj/item/clothing/mask/gas/carp(src)
	new /obj/item/clothing/suit/hooded/carp_costume/spaceproof/old(src)
	new /obj/item/knife/hunting(src)
	new /obj/item/storage/box/papersack/meat(src)

/obj/item/storage/box/hero/mothpioneer
	name = "蛾人舰队先驱——2429年"
	desc = "有人认为，现代航天设计的大部分进步直接归功于舰队工程师。尽管过去贡献的细节有些模糊，他们的才智至今仍无可匹敌、无可置疑。"

/obj/item/storage/box/hero/mothpioneer/PopulateContents()
	new /obj/item/clothing/head/mothcap/original(src)
	new /obj/item/clothing/suit/mothcoat/original(src)
	new /obj/item/crowbar(src)
	new /obj/item/flashlight/lantern(src)
	new /obj/item/screwdriver(src)
	new /obj/item/stack/sheet/glass/fifty(src)
	new /obj/item/stack/sheet/iron/fifty(src)
	new /obj/item/wrench(src)

/obj/item/storage/box/hero/etherealwarden
	name = "以太人巡路卫士——2450年代"
	desc = "英勇巡路卫士的奇闻广为流传，连在其指引下躲过萌芽星险路厄运的外星旅客也津津乐道。实际工作中，他们走路修路远比屠龙多，但同样重要、备受尊敬：对许多聚落而言，维护道路安全关乎生死。"

/obj/item/storage/box/hero/etherealwarden/PopulateContents()
	new /obj/item/clothing/suit/hooded/ethereal_raincoat/trailwarden(src)
	new /obj/item/clothing/under/ethereal_tunic/trailwarden(src)
	new /obj/item/storage/backpack/saddlepack(src)

/obj/item/storage/box/hero/journalist
	name = "被中情局暗杀——1984年" // Literally
	desc = "许多勇敢的人冒死报道政府试图隐瞒的事件，确保真相仍被埋藏、无人知晓。这套衣服仿制自一位这样的“记者”，一名争取真相的沉默哨兵。"

/obj/item/storage/box/hero/journalist/PopulateContents()
	new /obj/item/clothing/under/costume/buttondown/slacks(src)
	new /obj/item/clothing/suit/toggle/suspenders(src)
	new /obj/item/clothing/neck/tie/red(src)
	new /obj/item/clothing/head/fedora/beige/press(src)
	new /obj/item/clothing/accessory/press_badge(src)
	new /obj/item/clothing/suit/hazardvest/press(src)
	new /obj/item/radio/entertainment/microphone/physical(src)
	new /obj/item/radio/entertainment/speakers/physical(src)
	new /obj/item/clipboard(src)
	new /obj/item/taperecorder(src)
	new /obj/item/camera(src)
	new /obj/item/wallframe/telescreen/entertainment(src)

/obj/item/storage/box/holy
	name = "圣殿骑士套装"
	/// This item is used to generate a preview image for this set.
	/// It could be any item, doesn't even necessarily need to be something in the kit
	var/obj/item/typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/templar

/obj/item/storage/box/holy/PopulateContents()
	new /obj/item/clothing/head/helmet/chaplain(src)
	new /obj/item/clothing/suit/chaplainsuit/armor/templar(src)

/obj/item/storage/box/holy/clock
	name = "遗忘者套装"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/clock

/obj/item/storage/box/holy/clock/PopulateContents()
	new /obj/item/clothing/head/helmet/chaplain/clock(src)
	new /obj/item/clothing/suit/chaplainsuit/armor/clock(src)

/obj/item/storage/box/holy/student
	name = "亵渎学者套装"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/studentuni

/obj/item/storage/box/holy/student/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/studentuni(src)
	new /obj/item/clothing/head/helmet/chaplain/cage(src)

/obj/item/storage/box/holy/sentinel
	name = "磐石哨兵套装"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/ancient

/obj/item/storage/box/holy/sentinel/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/ancient(src)
	new /obj/item/clothing/head/helmet/chaplain/ancient(src)

/obj/item/storage/box/holy/witchhunter
	name = "猎巫人套装"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/witchhunter

/obj/item/storage/box/holy/witchhunter/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/witchhunter(src)
	new /obj/item/clothing/head/helmet/chaplain/witchunter_hat(src)

/obj/item/storage/box/holy/adept
	name = "神圣修士套装"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/adept

/obj/item/storage/box/holy/adept/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/adept(src)
	new /obj/item/clothing/head/helmet/chaplain/adept(src)
	new /obj/item/clothing/gloves/bracer(src)

/obj/item/storage/box/holy/follower
	name = "牧师追随者套装"
	typepath_for_preview = /obj/item/clothing/suit/hooded/chaplain_hoodie/leader

/obj/item/storage/box/holy/follower/PopulateContents()
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie/leader(src)

/obj/item/storage/box/holy/divine_archer
	name = "神圣弓手套装"
	typepath_for_preview = /obj/item/clothing/suit/hooded/chaplain_hoodie/divine_archer

/obj/item/storage/box/holy/divine_archer/PopulateContents()
	new /obj/item/clothing/under/rank/civilian/chaplain/divine_archer(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie/divine_archer(src)
	new /obj/item/clothing/gloves/divine_archer(src)
	new /obj/item/clothing/shoes/divine_archer(src)

/obj/item/storage/box/holy/heretic
	name = "秘术修行者套装"
	typepath_for_preview = /obj/item/clothing/suit/chaplainsuit/armor/heretic

/obj/item/storage/box/holy/heretic/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/heretic(src)
	new /obj/item/clothing/head/helmet/chaplain/heretic(src)

/obj/item/storage/box/floor_camo
	name = "地砖迷彩盒"
	desc = "感谢惠顾迷彩杰。我们独家设计的 \
		地砖“纳诺传讯渣滓”风格迷彩服，是顶级间谍使用的 \
		终极制服。采用最新迷彩科技面料， \
		提供绝佳灵活性，完美适用于 \
		高风险走廊谍报行动。祝使用愉快！"

/obj/item/storage/box/floor_camo/PopulateContents()
	new /obj/item/clothing/under/syndicate/floortilecamo(src)
	new /obj/item/clothing/mask/floortilebalaclava(src)
	new /obj/item/clothing/gloves/combat/floortile(src)
	new /obj/item/clothing/shoes/jackboots/floortile(src)
	new /obj/item/storage/backpack/floortile(src)

/obj/item/storage/box/collar_bomb
	name = "项圈炸弹盒"
	desc = "背面小字写着：“仅供研究。小心操作。紧急情况下请拨打以下号码：”……剩下的被记号笔涂掉了……"

/obj/item/storage/box/collar_bomb/PopulateContents()
	var/obj/item/collar_bomb_button/button = new(src)
	new /obj/item/clothing/neck/collar_bomb(src, button)

/obj/item/storage/box/itemset/crusader/blue/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/crusader/blue(src)
	new /obj/item/clothing/head/helmet/plate/crusader/blue(src)
	new /obj/item/clothing/gloves/plate/blue(src)
	new /obj/item/clothing/shoes/plate/blue(src)

/obj/item/storage/box/itemset/crusader/red/PopulateContents()
	new /obj/item/clothing/suit/chaplainsuit/armor/crusader/red(src)
	new /obj/item/clothing/head/helmet/plate/crusader/red(src)
	new /obj/item/clothing/gloves/plate/red(src)
	new /obj/item/clothing/shoes/plate/red(src)

/obj/item/storage/box/wizard_kit
	name = "普通巫师角色扮演套装"

/obj/item/storage/box/wizard_kit/PopulateContents()
	new /obj/item/clothing/head/wizard(src)
	new /obj/item/clothing/suit/wizrobe(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/red
	name = "塑能巫师角色扮演套装"

/obj/item/storage/box/wizard_kit/red/PopulateContents()
	new /obj/item/clothing/head/wizard/red(src)
	new /obj/item/clothing/suit/wizrobe/red(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/yellow
	name = "移位巫师角色扮演套装"

/obj/item/storage/box/wizard_kit/yellow/PopulateContents()
	new /obj/item/clothing/head/wizard/yellow(src)
	new /obj/item/clothing/suit/wizrobe/yellow(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/magusred
	name = "咒法巫师角色扮演套装"

/obj/item/storage/box/wizard_kit/yellow/PopulateContents()
	new /obj/item/clothing/head/wizard/magus(src)
	new /obj/item/clothing/suit/wizrobe/magusred(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/magusblue
	name = "变化巫师角色扮演套装"

/obj/item/storage/box/wizard_kit/yellow/PopulateContents()
	new /obj/item/clothing/head/wizard/magus(src)
	new /obj/item/clothing/suit/wizrobe/magusblue(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/wizard_kit/black
	name = "死灵巫师角色扮演套装"

/obj/item/storage/box/wizard_kit/black/PopulateContents()
	new /obj/item/clothing/head/wizard/black(src)
	new /obj/item/clothing/suit/wizrobe/black(src)
	new /obj/item/clothing/shoes/sandal(src)
